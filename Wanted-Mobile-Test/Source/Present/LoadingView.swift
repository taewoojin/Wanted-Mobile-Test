//
//  LoadingView.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/05.
//

import UIKit


class LoadingView: UIView {

    // MARK: UI
    
    let indicatorView = UIActivityIndicatorView(style: .large)
    
    
    // MARK: Initializing
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAttributes()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAttributes()
        setupLayout()
    }
    
    
    // MARK: Setup
    
    private func setupAttributes() {
        backgroundColor = .white
        
        indicatorView.startAnimating()
    }
    
    private func setupLayout() {
        addSubview(indicatorView)
        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
