//
//  SearchViewModel.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/03.
//

import RxCocoa
import RxSwift


class SearchViewModel {
    
    enum Action {
        case fetchBooks
        case updateSearchText(String)
        case resetBooks
    }
    
    enum Mutation {
        case setBooks([Book])
        case setStartIndex(Int)
        case setSearchText(String)
        case setError(ResponseError)
    }
    
    struct Store {
        var searchText: String = ""
        var books: [Book] = []
        var startIndex: Int = 0
        let maxResults: Int = 20
        var error: ResponseError?
    }
    
    
    // MARK: Properties
    
    var disposeBag = DisposeBag()
    
    private(set) var store: Store
    
    let action = PublishRelay<Action>()
    
    lazy var currentStore = BehaviorRelay<Store>(value: store)
    
    let service: SearchServiceProtocol
    
    
    // MARK: Initializing
    
    init(service: SearchServiceProtocol = SearchService()) {
        self.service = service
        self.store = Store()
        
        action
            .flatMap(mutate)
            .flatMap(reduce)
            .bind(to: currentStore)
            .disposed(by: disposeBag)
    }
    
    private func mutate(_ action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchBooks:
            return service
                .fetchBooks(
                    to: store.searchText,
                    startIndex: store.startIndex,
                    maxResults: store.maxResults
                )
                .asObservable()
                .flatMap { result -> Observable<Mutation> in
                    switch result {
                    case .success(let info):
                        return .merge(
                            .just(.setBooks(self.store.books + info.items)),
                            .just(.setStartIndex(self.store.startIndex + self.store.maxResults))
                        )
                        
                    case .failure(let error):
                        guard let error = error as? BaseError else { return .empty() }
                        
                        let responseError = ResponseError(message: error.message)
                        return .just(.setError(responseError))
                    }
                }
            
        case .updateSearchText(let text):
            return .just(.setSearchText(text))
            
        case .resetBooks:
            return .just(.setBooks([]))
        }
    }
    
    private func reduce(_ mutation: Mutation) -> Observable<Store> {
        switch mutation {
        case .setBooks(let books):
            store.books = books
            
        case .setStartIndex(let startIndex):
            store.startIndex = startIndex
        
        case .setSearchText(let text):
            store.searchText = text
            
        case .setError(let error):
            store.error = error
        }
        
        return .just(store)
    }
    
}
