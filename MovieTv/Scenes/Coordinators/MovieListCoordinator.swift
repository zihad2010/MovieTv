//
//  MovieListCoordinator.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation
import UIKit
import RxSwift

final class MovieListCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let navigationController = UINavigationController()
    private let disposable = DisposeBag()

    func start() {
        let movieListViewController: MovieListViewController = .instantiate()
        movieListViewController.coordinator = self
        movieListViewController
            .viewModel
            .info
            .subscribe(onNext: {[weak self] info in
                self?.showDetails(info: info)
            })
            .disposed(by:disposable)
        navigationController.tabBarItem.title = "Movie"
        navigationController.tabBarItem.image = UIImage(named:"unselectedMovie")
        navigationController.tabBarItem.selectedImage = UIImage(named: "selectedMovie")
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(movieListViewController, animated: true)
    }
    
   private func showDetails(info: Info) {
        let showsDetailsCoordinator = ShowsDetailsCoordinator(navigationController: self.navigationController, info: info)
        showsDetailsCoordinator.start()
        
    }
}
