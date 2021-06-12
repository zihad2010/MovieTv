//
//  ShowsDetailsCoordinator.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation
import RxCocoa

final class ShowsDetailsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let info: Info
    
    init(navigationController: UINavigationController,info: Info) {
        self.navigationController = navigationController
        self.info = info
    }
    
    func start() {
        let showsDetailsViewController: ShowsDetailsViewController = .instantiate()
        showsDetailsViewController.viewModel.info.accept(self.info)
        showsDetailsViewController.coordinator = self
        navigationController.pushViewController(showsDetailsViewController, animated: true)
    }
    
    func popViewController() {
        self.navigationController.popViewController(animated: true)
    }
}
