//
//  MovieListViewController.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class MovieListViewController: UIViewController {
    
    private let disposable = DisposeBag()
    private var viewModel = MovieListViewModel()
    var coordinator: MovieListCoordinator?
    
    @IBOutlet private weak var movieListCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        self.movieListCollectionView.rx.setDelegate(self).disposed(by: disposable)
    }
    
    private func setupBindings() {
        
        viewModel.MovieList.observeOn(MainScheduler.instance)
            .bind(to: movieListCollectionView.rx.items(cellIdentifier: "MovieListCollectionViewCell", cellType: MovieListCollectionViewCell.self)) {  (row,eachMovie,cell) in
                cell.eachMovie = eachMovie
            }.disposed(by: disposable)
        
        movieListCollectionView.rx.itemSelected.subscribe { indexPath in
            
        }.disposed(by: disposable)
    }
    
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 30) / 3 // compute your cell width
        return CGSize(width: cellWidth, height: cellWidth / 0.6)
    }
}
