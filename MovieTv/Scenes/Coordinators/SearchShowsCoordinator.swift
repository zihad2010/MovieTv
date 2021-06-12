//
//  SearchShowsCoordinator.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation
import UIKit
import RxSwift

final class SearchShowsCoordinator: Coordinator {
    
    
    var childCoordinators: [Coordinator] = []
    let navigationController = UINavigationController()
    private let disposable = DisposeBag()

    func start() {
        let searchShowsViewController: SearchShowsViewController = .instantiate()
       searchShowsViewController.coordinator = self
        searchShowsViewController
            .viewModel
            .info
            .subscribe(onNext: {[weak self] info in
                self?.showDetails(info: info)
            })
            .disposed(by:disposable)
        
        navigationController.tabBarItem.title = "Search"
        navigationController.tabBarItem.image = UIImage(named: "unselectedSearch")
        navigationController.tabBarItem.selectedImage = UIImage(named: "selectedSearch")
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(searchShowsViewController, animated: true)
    }
    
    private func showDetails(info: Info) {
         let showsDetailsCoordinator = ShowsDetailsCoordinator(navigationController: self.navigationController, info: info)
         showsDetailsCoordinator.start()
         
     }

}
