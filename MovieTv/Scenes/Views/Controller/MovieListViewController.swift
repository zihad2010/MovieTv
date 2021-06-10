//
//  MovieListViewController.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import UIKit
import RxSwift
import RxCocoa


class MovieListViewController: UIViewController {
    
    @IBOutlet private weak var movieListCollectionView: UICollectionView!
    
    private let disposable = DisposeBag()
    private var viewModel = MovieListViewModel()
    var coordinator: MovieListCoordinator?
    private let loader = ActivityIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        self.viewModel.fetchDtaWith(resource: self.viewModel.getResource())
        self.movieListCollectionView.collectionViewLayout = UICollectionViewFlowLayout.customizedCollectionViewLayoutFor(self.movieListCollectionView)
    }
    
    private func setupBindings() {
        
        self.viewModel.loading
            .subscribe(onNext: { [weak self] active in
                active ? self?.loader.showLoading(view: self?.view) : self?.loader.hideLoading()
            }).disposed(by: disposable)
        
        self.viewModel.error.observeOn(MainScheduler.instance).subscribe(onNext: { error in
            switch error{
            case .internetError(let mess):
                ToastView.shared.short(self.view, txt_msg: "  \(mess)  ")
                break
                
            case .serverMessage(let mess):
                ToastView.shared.short(self.view, txt_msg: "  \(mess)  ")
                break
            }
        }).disposed(by: disposable)
        
        self.movieListCollectionView.register(UINib(nibName: "MovTvItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: MovTvItemCollectionViewCell.self))
        
        viewModel.movieList.observeOn(MainScheduler.instance)
            .bind(to: movieListCollectionView.rx.items(cellIdentifier: "MovTvItemCollectionViewCell", cellType: MovTvItemCollectionViewCell.self)) {  (row,eachMovie,cell) in
                cell.eachMovie = eachMovie
            }.disposed(by: disposable)
        
        movieListCollectionView.rx.itemSelected.subscribe { indexPath in
            
        }.disposed(by: disposable)
    }
    
}
