//
//  AuthManager.swift
//  YoutubeApp
//
//  Created by Kayo Nakao on 2021-04-02.
//  Copyright © 2021 Guarana Technologies Inc. All rights reserved.
//

import Foundation
import GoogleSignIn
import PromiseKit

protocol AuthManagerDelegate: class {
    func didSignIn()
}

class AuthManager: NSObject {

    weak var delegate: AuthManagerDelegate?
    static var authentication: GIDAuthentication?
    
    override init() {
        super.init()
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func restore() {
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    func refreshToken() -> Promise<Void> {
        return Promise { seal in
            guard let auth = AuthManager.authentication else {
                seal.reject(YTError.noAuthentication)
                return
            }
            
            auth.refreshTokens { auth, error in
                guard let auth = auth else {
                    seal.reject(error ?? YTError.unknown)
                    return
                }
                AuthManager.authentication = auth
                seal.fulfill(())
            }
        }
    }
}

extension AuthManager: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
              print("The user has not signed in before or they have since signed out.")
            } else {
              print("\(error.localizedDescription)")
            }
            return
          }
        AuthManager.authentication = user.authentication
        delegate?.didSignIn()
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // ...
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
}
