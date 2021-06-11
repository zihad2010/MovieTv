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
   
    private let disposable = DisposeBag()
    private var viewModel = SearchShowsViewModel()
    private let loader = ActivityIndicator()
    var coordinator: SearchShowsCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        self.viewModel.fetchDtaWith(resource: self.viewModel.getResource())
    }
    
    
    private func setupBindings() {
        
        //Loader ----
        self.viewModel.loading
            .subscribe(onNext: { [weak self] active in
                active ? self?.loader.showLoading(view: self?.view) : self?.loader.hideLoading()
            }).disposed(by: disposable)
        
        // TostView ---
        self.viewModel.error.observeOn(MainScheduler.instance).subscribe(onNext: { error in
            switch error{
            case .internetError(let mess):
                ToastView.shared.short(self.view, txt_msg: "  \(mess)  ")
            case .serverMessage(let mess):
                ToastView.shared.short(self.view, txt_msg: "  \(mess)  ")
            }
        }).disposed(by: disposable)
        
        // collectionview ---
        viewModel.searchResultList.observeOn(MainScheduler.instance)
            .bind(to: searchResultTableView.rx.items(cellIdentifier: "SearchResultTableViewCell", cellType: SearchResultTableViewCell.self)) {  (row,eachMovie,cell) in
                cell.eachMovie = eachMovie
            }.disposed(by: disposable)
        
        //delegate ---
        self.searchResultTableView.rx.itemSelected.subscribe { indexPath in
            
        }.disposed(by: disposable)
    }

}
