//
//  TVShowsCoordinator.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation
import UIKit

final class TVShowsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let navigationController = UINavigationController()

    func start() {
        let tvShowsViewController: TVShowsViewController = .instantiate()
        tvShowsViewController.coordinator = self
        navigationController.tabBarItem.title = "TV Shows"
//        homeVC.tabBarItem.image = UIImage(named: ItemImage.RaffekLine.rawValue)
//        homeVC.tabBarItem.selectedImage = UIImage(named: SelectedImage.RaffekLineSelected.rawValue)
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(tvShowsViewController, animated: true)
    }

}

