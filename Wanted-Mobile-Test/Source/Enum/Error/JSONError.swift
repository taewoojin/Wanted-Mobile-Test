//
//  JSONError.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/04.
//


enum JSONError: BaseError {
    case objetToDataMapping
    
    var message: String{
        switch self {
        case .objetToDataMapping: return "데이터 매핑에서 오류가 발생했습니다."
        }
    }
}
