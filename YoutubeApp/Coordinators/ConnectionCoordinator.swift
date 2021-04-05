//
//  ConnectionCoordinator.swift
//  YoutubeApp
//
//  Created by Kayo Nakao on 2021-03-31.
//  Copyright © 2021 Guarana Technologies Inc. All rights reserved.
//

import UIKit

class ConnectionCoordinator: RootViewCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: ConnectionController())
        return navigationController
    }()
    
    func start() {}
    
}
