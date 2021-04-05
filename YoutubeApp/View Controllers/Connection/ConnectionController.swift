//
//  ConnectionController.swift
//  YoutubeApp
//
//  Created by Kayo Nakao on 2021-03-31.
//  Copyright © 2021 Guarana Technologies Inc. All rights reserved.
//

import UIKit
import GoogleSignIn
import SnapKit

class ConnectionController: UIViewController {
    private lazy var signInButton = GIDSignInButton()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.titleStrong
        label.textColor = .white
        label.text = "Youtube App"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        configureView()
        configureLayout()
    }
    
}

private extension ConnectionController {
    func configureView() {
        view.backgroundColor = .black
    }
    
    func configureLayout() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(view.bounds.height/4)
        }
        
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottomMargin).offset(-24)
        }
    }
}
