//
//  SearchRouter.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/03.
//

import Foundation

import Moya


enum SearchRouter {
    case fetchBooks(String, Int, Int)
    
}

extension SearchRouter: TargetType {
    public var baseURL: URL {
        switch self {
        default: return URL(string: Constant.default.domain.url)!
        }
    }

    public var method: Moya.Method {
        switch self {
        default: return .get
        }
    }

    public var path: String {
        switch self {
        case .fetchBooks:
            return "/books/v1/volumes"
        }
    }

    var parameters: [String: Any] {
        switch self {
        case let .fetchBooks(searchString, startIndex, maxResults):
            return [
                "q": searchString,
                "startIndex": startIndex,
                "maxResults": maxResults
            ]
        }
    }

    public var task: Task {
        switch self {
        case .fetchBooks:
            return .requestParameters(
                parameters: self.parameters,
                encoding: URLEncoding.queryString
            )
        }
    }

    public var headers: [String: String]? {
        switch self {
        default: return ["Content-Type": "application/json"]
        }
    }
    
}
