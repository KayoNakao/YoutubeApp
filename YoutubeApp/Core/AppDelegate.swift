//
//  AppDelegate.swift
//  YoutubeApp
//
//  Created by Filip Jandrijevic on 2019-01-04.
//  Copyright © 2019 Guarana Technologies Inc. All rights reserved.
//

import UIKit
import GoogleSignIn
import AppAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator!
    var isSignIn = false
    
    var currentAuthorizationFlow: OIDExternalUserAgentSession?
    private var authState: OIDAuthState?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
               
        setupGoogleSignin()

        window = UIWindow(frame: UIScreen.main.bounds)
        self.appCoordinator = AppCoordinator(window: window!)
        self.appCoordinator.start()
        
        return true
    }
}

private extension AppDelegate {
    func setupGoogleSignin() {
        GIDSignIn.sharedInstance().clientID = Environment.getValue(forKey: .googleClientID)
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/youtube.readonly")
        AuthManager().restore()
    }
}
