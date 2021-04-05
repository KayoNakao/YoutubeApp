//
//  HomeCoordinator.swift
//  YoutubeApp
//
//  Created by Filip Jandrijevic on 2018-11-13.
//  Copyright © 2018 Guarana Technologies Inc. All rights reserved.
//

import UIKit

protocol HomeCoordinatorDelegate: class {
    func showConnectionScreen()
}

class HomeCoordinator: RootViewCoordinator {

    weak var delegate: HomeCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let viewModel = HomeViewModel()
        let homeVC = HomeViewController(viewModel: viewModel)
        homeVC.delegate = self
        let navigationController = UINavigationController(rootViewController: homeVC)
        return navigationController
    }()
    
    func start() {}
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func showConnectionScreen() {
        delegate?.showConnectionScreen()
    }
    
}
