//
//  SearchViewController.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/03.
//

import UIKit

import RxCocoa
import RxOptional
import RxSwift


class SearchViewController: BaseViewController {

    // MARK: UI
    
    let searchController = UISearchController()
    
    let tableView = UITableView()
    
    let emptyTitleLabel = UILabel()
    
    
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
    
    override func setupAttributes() {
        super.setupAttributes()
        
        searchController.searchBar.placeholder = "Search for a book"

        let titleItem = UIBarButtonItem(title: "Search", style: .plain, target: nil, action: nil)
        titleItem.tintColor = .black
        titleItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 30, weight: .bold)], for: .normal)
        navigationItem.leftBarButtonItem = titleItem
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        tableView.register(BookCell.self, forCellReuseIdentifier: BookCell.typeName)
        
        emptyTitleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        emptyTitleLabel.numberOfLines = 0
        emptyTitleLabel.textAlignment = .center
        emptyTitleLabel.textColor = .systemGray2
        emptyTitleLabel.text = "검색 결과가 없습니다.\n검색어를 입력해주세요."
    }
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(emptyTitleLabel)
        emptyTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func setupLifeCycleBinding() {
        rx.viewDidLoad
            .map { .fetchBooks }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)
    }
    
    override func setupBinding() {
        searchController.searchBar.rx.text
            .filterNil()
            .map { .updateSearchText($0) }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.searchButtonClicked
            .flatMap {
                Observable.concat(
                    .just(.resetBooks),
                    .just(.fetchBooks)
                )
            }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.cancelButtonClicked
            .map { .resetBooks }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell
            .filter { [unowned viewModel] (_, indexPath) in
                return viewModel.store.books.count - 2 == indexPath.row
            }
            .map { _ in .fetchBooks }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)
        
        viewModel.currentStore
            .map { $0.books }
            .distinctUntilChanged()
            .bind(to: tableView.rx.items(
                cellIdentifier: BookCell.typeName,
                cellType: BookCell.self
            )) { index, item, cell in
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
     
        viewModel.currentStore
            .map { !$0.books.isEmpty }
            .distinctUntilChanged()
            .bind(to: emptyTitleLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.currentStore
            .map { $0.error }
            .filterNil()
            .distinctUntilChanged()
            .subscribe(onNext: { error in
                print("error: ", error.message)
            })
            .disposed(by: disposeBag)
    }
}
