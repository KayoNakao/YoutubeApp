//
//  BaseViewController.swift
//  YoutubeApp
//
//  Created by Kayo Nakao on 2021-04-02.
//  Copyright © 2021 Guarana Technologies Inc. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        view.backgroundColor = .black
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension BaseViewController {
    func showAlert(for error: Error, title: String = Localizable.Error.title, handle: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localizable.General.ok, style: .default, handler: { _ in handle?() }))
        present(alert, animated: true)
    }
}
