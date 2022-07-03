//
//  SearchViewController.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/03.
//

import UIKit


class SearchViewController: BaseViewController {

    // MARK: UI
    
    var searchController = UISearchController()
    
    var tableView = UITableView()
    
    
    // MARK: Properties
    
    let viewModel: SearchViewModel
    
    
    // MARK: Initializing
    
    init(viewModel: SearchViewModel = SearchViewModel()) {
        self.viewModel = viewModel
        super.init()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: Setup
    
    override func setupLifeCycleBinding() {
        rx.viewDidLoad
            .map { .fetchBooks("as") }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)
    }
    
}

