//
//  AppCoordinator.swift
//  YoutubeApp
//
//  Created by Filip Jandrijevic on 2018-11-13.
//  Copyright © 2018 Guarana Technologies Inc. All rights reserved.
//

import UIKit
import GoogleSignIn
/// The AppCoordinator is our first coordinator
/// In this example the AppCoordinator as a rootViewController
class AppCoordinator: RootViewCoordinator {
    
    // MARK: - Properties    
    var childCoordinators: [Coordinator] = []
    private lazy var splashVC = SplashController()
    
    /// Remember to change the UIViewController instance to your Splash Screen
    private(set) var rootViewController: UIViewController = SplashController() {
        didSet {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.window.rootViewController = self.rootViewController
            })
        }
    }
    
    /// Window to manage
    let window: UIWindow
    
    // MARK: - Init
    public init(window: UIWindow) {
        self.window = window
        self.window.backgroundColor = .white
        self.splashVC.delegate = self
        self.window.rootViewController = splashVC
        self.window.makeKeyAndVisible()
    }
    
    // MARK: - Functions
    
    private func setCurrentCoordinator(_ coordinator: RootViewCoordinator) {
        rootViewController = coordinator.rootViewController
    }
    
    func start() {}
}

extension AppCoordinator: SplashControllerDelegate, HomeCoordinatorDelegate {
    func showHomeScreen() {
        setupHome()
    }
    
    func showConnectionScreen() {
        setupConnection()
    }
}

extension AppCoordinator {
    func setupConnection() {
        let connectionCoordinator = ConnectionCoordinator()
        addChildCoordinator(connectionCoordinator)
        setCurrentCoordinator(connectionCoordinator)
    }
    
    func setupHome() {
        childCoordinators.removeAll()
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.delegate = self
        addChildCoordinator(homeCoordinator)
        setCurrentCoordinator(homeCoordinator)
    }
}
