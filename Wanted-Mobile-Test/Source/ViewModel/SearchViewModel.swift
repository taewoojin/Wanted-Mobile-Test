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
        case fetchBooks(String)
    }
    
    enum Mutation {
        case setBooks([Volume])
        case setStartIndex(Int)
    }
    
    struct Store {
        var books: [Volume] = []
        var startIndex: Int = 0
        let maxResults: Int = 20
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
            
        case .fetchBooks(let searchString):
            return service
                .fetchBooks(
                    to: searchString,
                    startIndex: store.startIndex,
                    maxResults: store.maxResults
                )
                .asObservable()
                .flatMap { result -> Observable<Mutation> in
                    switch result {
                    case .success(let info):
                        return .merge(
                            .just(.setBooks(info.items)),
                            .just(.setStartIndex(self.store.startIndex + self.store.maxResults))
                        )
                        
                    case .failure(let error):
                        // TODO: 상황에 따른 에러 처리
                        print(error)
                        return .empty()
                        
                    }
                }
            
        }
    }
    
    private func reduce(_ mutation: Mutation) -> Observable<Store> {
        switch mutation {
        case .setBooks(let books):
            store.books = books
            
        case .setStartIndex(let startIndex):
            store.startIndex = startIndex
        
        }
        
        return .just(store)
    }
    
}
