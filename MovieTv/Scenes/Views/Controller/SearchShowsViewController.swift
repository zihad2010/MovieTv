//
//  SearchViewController.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import UIKit
import RxSwift
import RxCocoa

class SearchShowsViewController: UIViewController {
    
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var infoLabel: UILabel!
    
    private let disposable = DisposeBag()
    public var viewModel = SearchShowsViewModel()
    private let loader = ActivityIndicator()
    var coordinator: SearchShowsCoordinator?
    
    //MARK:- View Lifecycle
    //Start searching your favourite movies
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    //MARK:-data binding-
    
    private func setupBindings() {
        //segmentControl---
        segmentControl
            .rx
            .selectedSegmentIndex.bind(to: self.viewModel.segmentIndex)
            .disposed(by: disposable)
        
        //search bar--
        searchBar
            .rx
            .text
            .orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: self.viewModel.searchText)
            .disposed(by: disposable)
        
        searchBar
            .rx
            .searchButtonClicked
            .subscribe(onNext: { [unowned self] in
                searchBar.resignFirstResponder()
            })
            .disposed(by: disposable)
        
        searchBar
            .rx
            .cancelButtonClicked
            .subscribe(onNext: { [unowned self] in
                searchBar.resignFirstResponder()
            })
            .disposed(by: disposable)
        
        self.viewModel
            .isHidden
            .subscribe(onNext: { isHidden in
                self.infoLabel.isHidden = isHidden
                self.searchResultTableView.isHidden = !isHidden
            }).disposed(by: disposable)
        
        //Loader ----
        self.viewModel
            .loading
            .subscribe(onNext: { [weak self] active in
                active ? self?.loader.showLoading(view: self?.view) : self?.loader.hideLoading()
            })
            .disposed(by: disposable)
        
        // TostView ---
        self.viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { error in
                switch error{
                case .internetError(let mess):
                    ToastView.shared.short(self.view, txt_msg: "  \(mess)  ")
                case .serverMessage(let mess):
                    ToastView.shared.short(self.view, txt_msg: "  \(mess)  ")
                }
            })
            .disposed(by: disposable)
        
        // tableview ---
        viewModel
            .searchResultList
            .observeOn(MainScheduler.instance)
            .bind(to: searchResultTableView.rx.items(cellIdentifier: "SearchResultTableViewCell", cellType: SearchResultTableViewCell.self)) {  (row,eachMovie,cell) in
                cell.eachMovie = eachMovie
            }
            .disposed(by: disposable)
        
        //delegate ---
        searchResultTableView
            .rx.modelSelected(EachItemViewModel.self)
            .subscribe(onNext: { model in
                print(model)
                self.viewModel.info.onNext(Info(id: model.id, type: self.viewModel.searchType))
            })
            .disposed(by: disposable)
    }
    
}
