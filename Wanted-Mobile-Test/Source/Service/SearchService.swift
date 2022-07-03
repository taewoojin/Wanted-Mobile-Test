//
//  SearchService.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/03.
//

import Foundation

import RxSwift


protocol SearchServiceProtocol {
    func fetchBooks(to searchString: String, startIndex: Int, maxResults: Int) -> Single<Result<VolumeResponse, Error>>
}


struct SearchService: SearchServiceProtocol {
    
    let repository: SearchRepositoryProtocol
    
    
    init(repository: SearchRepositoryProtocol = SearchRepository()) {
        self.repository = repository
    }

    func fetchBooks(
        to searchString: String,
        startIndex: Int,
        maxResults: Int
    ) -> Single<Result<VolumeResponse, Error>> {
        repository.fetchBooks(to: searchString, startIndex: startIndex, maxResults: maxResults)
    }
}
