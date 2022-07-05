//
//  Moya+Rx.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/03.
//

import Foundation

import Moya
import RxMoya
import RxSwift


extension PrimitiveSequence where Trait == SingleTrait, Element == Moya.Response {
    
    func asResult<T: Decodable>(_ type: T.Type) -> PrimitiveSequence<Trait, Result<T, Error>> {
        return self
            .flatMap { response in
                if let networkError = NetworkError(rawValue: response.statusCode) {
                    throw networkError
                }
                
                return .just(response)
            }
            .map(T.self)
            .map { .success($0) }
            .catch { .just(.failure($0)) }
    }
    
    // json 데이터에서 원하는 key 값으로 unwrapping 하는 함수
    func asResult<T: Decodable>(_ type: T.Type, key: String) -> PrimitiveSequence<Trait, Result<T, Error>> {
        return self
            .flatMap { response in
                if let networkError = NetworkError(rawValue: response.statusCode) {
                    throw networkError
                }
                
                let jsonObject = try? JSONSerialization.jsonObject(with: response.data, options: [])
                guard let dict = jsonObject as? [String:Any], let object = dict[key] else {
                    throw MoyaError.jsonMapping(response)
                }
                
                guard let objectData = try? JSONSerialization.data(withJSONObject: object) else {
                    throw JSONError.objetToDataMapping
                }
                
                return .just(Moya.Response(statusCode: response.statusCode, data: objectData))
            }
            .map(T.self)
            .map { .success($0) }
            .catch { .just(.failure($0)) }
    }
    
}
