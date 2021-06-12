//
//  SearchShowsCoordinator.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import Foundation
import RxSwift

final class SearchShowsCoordinator: NSObject,Coordinator {
    
    
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
        navigationController.delegate = self
        childCoordinators.append(showsDetailsCoordinator)
        showsDetailsCoordinator.start()
        
    }
    
}

extension SearchShowsCoordinator: UINavigationControllerDelegate {
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
