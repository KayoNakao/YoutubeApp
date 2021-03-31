//
//  Coordinator.swift
//  YoutubeApp
//
//  Created by Filip Jandrijevic on 2018-11-13.
//  Copyright © 2018 Guarana Technologies Inc. All rights reserved.
//

import Foundation

/// The Coordinator protocol
public protocol Coordinator: class {
        
    /// The array containing any child Coordinators
    var childCoordinators: [Coordinator] { get set }
    
}

public extension Coordinator {
    
    /// Add a child coordinator to the parent
    func addChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }
    
    /// Remove a child coordinator from the parent
    func removeChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
    
}
