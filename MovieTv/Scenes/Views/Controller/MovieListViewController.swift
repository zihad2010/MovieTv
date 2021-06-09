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
        
    }

    private func setupBindings() {
        
        viewModel.MovieList.observeOn(MainScheduler.instance)
            .bind(to: movieListCollectionView.rx.items(cellIdentifier: "MovieListCollectionViewCell", cellType: MovieListCollectionViewCell.self)) {  (row,eachMovie,cell) in
                cell.eachMovie = eachMovie
            }.disposed(by: disposable)
    }
    
}
