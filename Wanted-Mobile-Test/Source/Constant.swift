//
//  Constant.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/03.
//

import Foundation
import UIKit


struct Constant {
    
    enum BuildType {
        case release
        case debug
    }
    
    static let `default` = Constant(type: .release)
    
    let domain: Domain
    
    
    init(type: BuildType = .release) {
        domain = Domain(type: type)
    }
    
    
    struct Domain {
        
        let url: String
        
        
        init(type: BuildType = .release) {
            switch type {
            case .release:
                url = "https://www.googleapis.com"
                
            case .debug:
                url = "https://www.googleapis.com"
            }
        }
    }
        
}

