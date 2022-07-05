//
//  NSObject+Extensions.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/04.
//

import Foundation


extension NSObject {
    
    static var typeName: String { String(describing: self) }
    
    func className() -> String {
        type(of: self).description().components(separatedBy: ".").last ?? ""
    }
    
}
