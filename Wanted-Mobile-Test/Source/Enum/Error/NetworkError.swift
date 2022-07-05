//
//  NetworkError.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/03.
//


enum NetworkError: Int, BaseError {
    case badRequest = 400
    case authenticationFailed = 401
    case notFoundException = 404
    case systemError = 500
    
    var message: String {
        switch self {
        case .badRequest: return "잘못된 요청입니다."
        case .authenticationFailed: return "인증 정보가 유효하지 않습니다."
        case .notFoundException: return "해당 요청을 찾을 수 없습니다."
        case .systemError: return "시스템 에러가 발생했습니다."
        }
    }
}
