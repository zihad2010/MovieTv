//
//  AppCoordinator.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let tabBarCoordinator = TabBarCoordinator(window: self.window)
        tabBarCoordinator.start()
    }
}
