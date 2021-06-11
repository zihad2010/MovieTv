//
//  ShowsDetailsCoordinator.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation
import UIKit

final class ShowsDetailsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let navigationController = UINavigationController()

    func start() {
        let showsDetailsViewController: ShowsDetailsViewController = .instantiate()
        navigationController.pushViewController(showsDetailsViewController, animated: true)
    }
}
