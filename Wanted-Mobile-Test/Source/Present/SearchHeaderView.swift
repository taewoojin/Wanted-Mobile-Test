//
//  SearchHeaderView.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/05.
//

import UIKit

import RxSwift


class SearchHeaderView: UIView {

    // MARK: UI
    
    let titleLabel = UILabel()
    
    
    // MARK: Properties
    
    let viewModel: SearchViewModel
    
    var disposeBag = DisposeBag()
    
    
    // MARK: Initializing
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupAttributes()
        setupLayout()
        setupBinding()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Setup
    
    private func setupAttributes() {
        backgroundColor = .systemGray5
    }
    
    private func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        viewModel.currentStore
            .map { "Results (\($0.totalBooks))" }
            .distinctUntilChanged()
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}
