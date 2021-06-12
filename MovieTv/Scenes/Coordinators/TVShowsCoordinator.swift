//
//  TVShowsCoordinator.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation

import RxSwift

final class TVShowsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let navigationController = UINavigationController()
    private let disposable = DisposeBag()

    func start() {
        let tvShowsViewController: TVShowsViewController = .instantiate()
        tvShowsViewController.coordinator = self
        tvShowsViewController.coordinator = self
        tvShowsViewController
            .viewModel
            .info
            .subscribe(onNext: {[weak self] info in
                self?.showDetails(info: info)
            })
            .disposed(by:disposable)
        navigationController.tabBarItem.title = "TV Shows"
        navigationController.tabBarItem.image = UIImage(named: "unselectedTv")
        navigationController.tabBarItem.selectedImage = UIImage(named:"selectedTv")
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(tvShowsViewController, animated: true)
    }
    
    private func showDetails(info: Info) {
         let showsDetailsCoordinator = ShowsDetailsCoordinator(navigationController: self.navigationController, info: info)
         showsDetailsCoordinator.start()
         
     }

}

