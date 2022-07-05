//
//  SearchRepository.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/03.
//

import Foundation

import Moya
import RxCocoa
import RxMoya
import RxSwift


protocol SearchRepositoryProtocol {
    func fetchBooks(to searchString: String, startIndex: Int, maxResults: Int) -> Single<Result<BookResponse, Error>>
}


class SearchRepository: SearchRepositoryProtocol {
    
    let provider: MoyaProvider<SearchRouter>
    
    
    init(provider: MoyaProvider<SearchRouter> = MoyaProvider<SearchRouter>()) {
        self.provider = provider
    }

    
    func fetchBooks(
        to searchString: String,
        startIndex: Int,
        maxResults: Int
    ) -> Single<Result<BookResponse, Error>> {
        return provider.rx
            .request(.fetchBooks(searchString, startIndex, maxResults))
            .asResult(BookResponse.self)
    }
    
}
