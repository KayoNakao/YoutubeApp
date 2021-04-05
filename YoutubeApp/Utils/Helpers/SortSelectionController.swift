//
//  SortSelectionController.swift
//  YoutubeApp
//
//  Created by Kayo Nakao on 2021-04-05.
//  Copyright © 2021 Guarana Technologies Inc. All rights reserved.
//

import UIKit

protocol SortSelectionControllerDelegate: class {
    func didSelectOption(_ option: SortOption)
}

class SortSelectionController: BaseViewController {
    
    weak var delegate: SortSelectionControllerDelegate?
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray90
        view.layer.cornerRadius = 5.0
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
    
    override init() {
        super.init()
        configureView()
        configureLayout()
        setupOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SortSelectionController {
    func configureView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        
    }
    
    func configureLayout() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(88)
            make.leading.equalToSuperview().offset(16)
        }
        
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    func setupOptions() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        SortOption.allCases.forEach { option in
            let button = UIButton()
            button.tag = option.rawValue
            button.addTarget(self, action: #selector(didSelectOption(_:)), for: .touchUpInside)
            button.setTitle(option.title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = Font.bodyRegular
            stackView.addArrangedSubview(button)
        }
    }
}

private extension SortSelectionController {
    @objc func didSelectOption(_ sender: UIButton) {
        guard let option = SortOption(rawValue: sender.tag) else { return }
        delegate?.didSelectOption(option)
        dismiss(animated: true)
    }
    
    @objc func didTapView() {
        dismiss(animated: true)
    }
}
