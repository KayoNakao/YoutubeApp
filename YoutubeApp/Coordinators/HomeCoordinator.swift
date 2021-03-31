//
//  HomeCoordinator.swift
//  YoutubeApp
//
//  Created by Filip Jandrijevic on 2018-11-13.
//  Copyright © 2018 Guarana Technologies Inc. All rights reserved.
//

import Foundation
import UIKit

class HomeCoordinator: RootViewCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private var navigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: HomeViewController())
        return navigationController
    }()
    
    func start() {}
}
