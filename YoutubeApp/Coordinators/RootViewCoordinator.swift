//
//  RootViewCoordinator.swift
//  YoutubeApp
//
//  Created by Filip Jandrijevic on 2018-11-13.
//  Copyright © 2018 Guarana Technologies Inc. All rights reserved.
//

import Foundation
import UIKit

public protocol RootViewControllerProvider: class {
    // The coordinators 'rootViewController'. It helps to think of this as the view
    // controller that can be used to dismiss the coordinator from the view hierarchy.
    var rootViewController: UIViewController { get }
    func start()
}

/// A Coordinator type that provides a root UIViewController
public typealias RootViewCoordinator = Coordinator & RootViewControllerProvider
