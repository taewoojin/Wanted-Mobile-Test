//
//  UIImageView+Extensions.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/04.
//

import Foundation
import UIKit

import Kingfisher


extension UIImageView {
    
    func loadImage(
        urlString: String?,
        defaultImage: UIImage? = nil,
        completeHandler: ((UIImage) -> Void)? = nil,
        failedHandler: ((ImageError) -> Void)? = nil
    ) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            image = defaultImage
            return
        }
        
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: nil,
            options: [.cacheMemoryOnly],
            progressBlock: nil
        ) { result in
            switch result {
            case .success(let value):
                completeHandler?(value.image)
                
            case .failure(_):
                failedHandler?(.loadFailed)
            }
        }
    }
    
}
