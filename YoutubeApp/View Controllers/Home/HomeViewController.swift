//
//  HomeViewController.swift
//  YoutubeApp
//
//  Created by Filip Jandrijevic on 2019-01-04.
//  Copyright © 2019 Guarana Technologies Inc. All rights reserved.
//

import UIKit
import GoogleSignIn

protocol HomeViewControllerDelegate: class {
    func showConnectionScreen()
}

class HomeViewController: BaseViewController {

    weak var delegate: HomeViewControllerDelegate?
    private let viewModel: HomeViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerCell(cellClass: PlaylistCell.self)
        tableView.register(SortHeaderView.self, forHeaderFooterViewReuseIdentifier: SortHeaderView.identifier)
        return tableView
    }()
    
    private lazy var profileButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemPink
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = Font.bodyRegular
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureLayout()
        getPlaylists()
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension HomeViewController {
    func configureNavBar() {
        navigationItem.title = Localizable.Home.title
        let firstLetter = GIDSignIn.sharedInstance()?.currentUser.profile.givenName.first?.uppercased()
        profileButton.setTitle(firstLetter, for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
    }
    
    func configureLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.snp.topMargin)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-8)
        }
    }
}

private extension HomeViewController {
    func getPlaylists() {
        viewModel.getPlaylists()
            .done { _ in
                self.tableView.reloadData()
            }.catch { error in
                self.showAlert(for: error)
            }
    }
}

private extension HomeViewController {
    @objc func didTapProfile() {
        let alert = UIAlertController(title: Localizable.General.signOut, message: Localizable.Home.signOutMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: Localizable.General.ok, style: .default) { _ in
            GIDSignIn.sharedInstance()?.signOut()
            DispatchQueue.main.async {
                self.delegate?.showConnectionScreen()                
            }
        }
        let cancel = UIAlertAction(title: Localizable.General.cancel, style: .cancel)
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: PlaylistCell.self, indexPath: indexPath)
        let item = viewModel.getItem(at: indexPath.row)
        cell.configure(thumbnailUrl: item?.snippet.thumbnails.standard?.url ?? "", titleText: item?.snippet.title ?? "", numberOfVideos: item?.contentDetails.itemCount ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SortHeaderView.identifier) as? SortHeaderView else { return nil }
        header.configure(title: viewModel.currentSort.title)
        header.delegate = self
        return header
    }
}

extension HomeViewController: SortHeaderViewDelegate {
    func showSortOptions() {
        let sortOptions = SortSelectionController()
        sortOptions.delegate = self
        sortOptions.modalPresentationStyle = .overFullScreen
        sortOptions.modalTransitionStyle = .crossDissolve
        present(sortOptions, animated: true)
    }
}

extension HomeViewController: SortSelectionControllerDelegate {
    func didSelectOption(_ option: SortOption) {
        viewModel.setSortOption(option)
        tableView.reloadData()
    }
}
