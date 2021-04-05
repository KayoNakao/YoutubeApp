//
//  SortHeaderView.swift
//  YoutubeApp
//
//  Created by Kayo Nakao on 2021-04-05.
//  Copyright © 2021 Guarana Technologies Inc. All rights reserved.
//

import UIKit

enum SortOption: Int, CaseIterable {
    case recent, aToZ, zToA
    
    var title: String {
        switch self {
        case .recent: return Localizable.Home.recentlyAdded
        case .aToZ: return Localizable.Home.aToZ
        case .zToA: return Localizable.Home.zToA
        }
    }
}

protocol SortHeaderViewDelegate: class {
    func showSortOptions()
}

class SortHeaderView: UITableViewHeaderFooterView {

    weak var delegate: SortHeaderViewDelegate?
    static let identifier = "SortHeaderView"
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle(Localizable.Home.recentlyAdded, for: .normal)
        button.titleLabel?.font = Font.subHeadingRegular
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(didTapSort), for: .touchUpInside)
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SortHeaderView {
    func configureLayout() {
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(16)
        }
    }
}

private extension SortHeaderView {
    @objc func didTapSort() {
        delegate?.showSortOptions()
    }
}

extension SortHeaderView {
    func configure(title: String) {
        button.setTitle(title, for: .normal)
    }
}
