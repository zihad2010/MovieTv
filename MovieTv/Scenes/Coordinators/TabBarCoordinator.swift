//
//  TabBarCoordinator.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation
import UIKit

final class TabBarCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    private let navigationController = UINavigationController()
    
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        let tabBarController = UITabBarController()
        
        let movieListCoordinator = MovieListCoordinator()
      //  movieListCoordinator.coordinator = self
        self.childCoordinators.append(movieListCoordinator)
        movieListCoordinator.start()
        
        let tvShowsCoordinator = TVShowsCoordinator()
        self.childCoordinators.append(tvShowsCoordinator)
        tvShowsCoordinator.start()
        
        let searchShowsCoordinator = SearchShowsCoordinator()
        self.childCoordinators.append(searchShowsCoordinator)
        searchShowsCoordinator.start()
        
        tabBarController.viewControllers = [movieListCoordinator.navigationController,tvShowsCoordinator.navigationController,searchShowsCoordinator.navigationController]
    
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

}
