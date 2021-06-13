//
//  MovieListCoordinator.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation
import RxSwift

final class MovieListCoordinator: NSObject,Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let navigationController = UINavigationController()
    private let disposable = DisposeBag()
    
    func start() {
        let movieListViewController: MovieListViewController = .instantiate()
        movieListViewController.coordinator = self
        movieListViewController
            .viewModel
            .info
            .subscribe(onNext: {[weak self] info in
                self?.showDetails(info: info)
            })
            .disposed(by:disposable)
        navigationController.tabBarItem.title = TabBarItem.move
        navigationController.tabBarItem.image = UIImage.unselectedMovie
        navigationController.tabBarItem.selectedImage = UIImage.selectedMovie
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(movieListViewController, animated: true)
    }
    
    private func showDetails(info: Info) {
        let showsDetailsCoordinator = ShowsDetailsCoordinator(navigationController: self.navigationController, info: info)
        navigationController.delegate = self
        childCoordinators.append(showsDetailsCoordinator)
        showsDetailsCoordinator.start()
    }
}

extension MovieListCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        if let vc = fromViewController as? ShowsDetailsViewController {
            removeChildCoordinator(vc.coordinator!)
        }
    }
    
    func removeChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}
