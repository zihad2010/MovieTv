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
    
    private let disposable = DisposeBag()
    private var viewModel = MovieListViewModel()
    var coordinator: MovieListCoordinator?
    
    @IBOutlet private weak var movieListCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
       
        let resource = Resource<MovieResponseModel>(url: URL(string: "https://api.themoviedb.org/3/discover/tv?api_key=eb8aa6f914f794f711fb1841fb141f12")!)
        self.viewModel.fetchDtaWith(resource: resource)
        self.movieListCollectionView.collectionViewLayout = UICollectionViewFlowLayout.customizedCollectionViewLayoutFor(self.movieListCollectionView)
    }
    
    private func setupBindings() {
        
        self.movieListCollectionView.register(UINib(nibName: "MovTvItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: MovTvItemCollectionViewCell.self))
        
        viewModel.MovieList.observeOn(MainScheduler.instance)
            .bind(to: movieListCollectionView.rx.items(cellIdentifier: "MovTvItemCollectionViewCell", cellType: MovTvItemCollectionViewCell.self)) {  (row,eachMovie,cell) in
                cell.eachMovie = eachMovie
            }.disposed(by: disposable)
        
        movieListCollectionView.rx.itemSelected.subscribe { indexPath in
            
        }.disposed(by: disposable)
    }
    
}
