//
//  SearchShowsCoordinator.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation
import UIKit

final class SearchShowsCoordinator: Coordinator {
    
    
    var childCoordinators: [Coordinator] = []
    let navigationController = UINavigationController()

    func start() {
        let searchShowsViewController: SearchShowsViewController = .instantiate()
       searchShowsViewController.coordinator = self
       navigationController.tabBarItem.title = "Search"
//        homeVC.tabBarItem.image = UIImage(named: ItemImage.RaffekLine.rawValue)
//        homeVC.tabBarItem.selectedImage = UIImage(named: SelectedImage.RaffekLineSelected.rawValue)
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(searchShowsViewController, animated: true)
    }

}
