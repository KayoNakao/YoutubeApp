//
//  SplashController.swift
//  YoutubeApp
//
//  Created by Raphael on 2019-06-21.
//  Copyright © 2019 Guarana Technologies Inc. All rights reserved.
//

import UIKit
import GoogleSignIn

protocol SplashControllerDelegate: class {
    func showConnectionScreen()
    func showHomeScreen()
}

class SplashController: UIViewController {
    
    weak var delegate: SplashControllerDelegate?
    private let authManager = AuthManager()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Environment.getValue(forKey: .appName)
        label.font = Font.headingStrong
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.color = .lightGray
        return ai
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.authManager.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayout()
        authenticate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SplashController {
    func configureView() {
        view.backgroundColor = .black
    }
    
    func configureLayout() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activityIndicator.startAnimating()
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activityIndicator.snp.top).offset(-24)
            make.centerX.equalToSuperview()
        }
    }
    
    func authenticate() {
        if GIDSignIn.sharedInstance()?.currentUser == nil {
            delegate?.showConnectionScreen()
        } else {
            authManager.refreshToken()
                .done { _ in
                    self.delegate?.showHomeScreen()
                }.catch { _ in
                    self.delegate?.showConnectionScreen()
                }
        }
    }
}

extension SplashController: AuthManagerDelegate {
    func didSignIn() {
        delegate?.showHomeScreen()
    }
}
