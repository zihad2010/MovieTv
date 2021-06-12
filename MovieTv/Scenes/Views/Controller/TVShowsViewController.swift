//
//  TVShowsViewController.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import UIKit
import RxSwift
import RxCocoa

class TVShowsViewController: UIViewController {

    @IBOutlet private weak var tvShowsListCollectionView: UICollectionView!
    
    var coordinator: TVShowsCoordinator?
    private let disposable = DisposeBag()
    private var viewModel = TVShowsListViewModel()
    private let loader = ActivityIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        self.viewModel.fetchDtaWith(resource:self.viewModel.getResource(value: String.self) as! Resource<ResponseModel>)
        self.tvShowsListCollectionView.collectionViewLayout = UICollectionViewFlowLayout.customizedCollectionViewLayoutFor(self.tvShowsListCollectionView)
    }
    
    private func setupBindings() {
        
        self.viewModel
            .loading
            .subscribe(onNext: { [weak self] active in
                active ? self?.loader.showLoading(view: self?.view) : self?.loader.hideLoading()
            })
            .disposed(by: disposable)
        
        self.viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { error in
            switch error{
            case .internetError(let mess):
                ToastView.shared.short(self.view, txt_msg: "  \(mess)  ")
                break
                
            case .serverMessage(let mess):
                ToastView.shared.short(self.view, txt_msg: "  \(mess)  ")
                break
            }
        })
        .disposed(by: disposable)
        
        //collection view
        self.tvShowsListCollectionView.register(UINib(nibName: "MovTvItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: MovTvItemCollectionViewCell.self))
        
        viewModel
            .tvShowsList
            .observeOn(MainScheduler.instance)
            .bind(to: tvShowsListCollectionView.rx.items(cellIdentifier: "MovTvItemCollectionViewCell", cellType: MovTvItemCollectionViewCell.self)) {  (row,eachMovie,cell) in
                cell.eachMovie = eachMovie
            }
            .disposed(by: disposable)
        
        self.tvShowsListCollectionView
            .rx
            .itemSelected
            .subscribe { indexPath in
                
        }.disposed(by: disposable)
    }
}
