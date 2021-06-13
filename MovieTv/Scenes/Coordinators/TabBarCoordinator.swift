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
        movieListCoordinator.start()
        
        let tvShowsCoordinator = TVShowsCoordinator()
        tvShowsCoordinator.start()
        
        let searchShowsCoordinator = SearchShowsCoordinator()
        searchShowsCoordinator.start()
        
        tabBarController.viewControllers = [movieListCoordinator.navigationController,tvShowsCoordinator.navigationController,searchShowsCoordinator.navigationController]
    
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

}
