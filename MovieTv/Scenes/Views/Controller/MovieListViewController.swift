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
    public var viewModel = MovieListViewModel()
    var coordinator: MovieListCoordinator?
    private let loader = ActivityIndicator()
    
    //MARK:- View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        self.viewModel.getDataWith(resource:self.viewModel.getResource(value: String.self) as! Resource<ResponseModel>)
        self.movieListCollectionView.collectionViewLayout = UICollectionViewFlowLayout.customizedCollectionViewLayoutFor(self.movieListCollectionView)
    }
    
    //MARK:- data binding
    
    private func setupBindings() {
        
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
        
        // collectionview ---
        self.movieListCollectionView.register(UINib(nibName: "MovTvItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: MovTvItemCollectionViewCell.self))
        
        viewModel
            .movieList
            .observeOn(MainScheduler.instance)
            .bind(to: movieListCollectionView.rx.items(cellIdentifier: "MovTvItemCollectionViewCell", cellType: MovTvItemCollectionViewCell.self)) {  (row,eachMovie,cell) in
                cell.eachMovie = eachMovie
            }
            .disposed(by: disposable)
        
        //delegate ---
        movieListCollectionView
            .rx.modelSelected(EachItemViewModel.self)
            .subscribe(onNext: {model in
                self.viewModel.info.onNext(Info(id: model.id, type: TMDbSearchingCollection(index: 0).map { $0.rawValue }))
            })
            .disposed(by: disposable)
    }
    
}
