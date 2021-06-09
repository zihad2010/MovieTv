//
//  MovieListCoordinator.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation
import UIKit

final class MovieListCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let navigationController = UINavigationController()

    func start() {
        let movieListViewController: MovieListViewController = .instantiate()
        movieListViewController.coordinator = self
        navigationController.tabBarItem.title = "Movie"
//        homeVC.tabBarItem.image = UIImage(named: ItemImage.RaffekLine.rawValue)
//        homeVC.tabBarItem.selectedImage = UIImage(named: SelectedImage.RaffekLineSelected.rawValue)
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(movieListViewController, animated: true)
    }

}
