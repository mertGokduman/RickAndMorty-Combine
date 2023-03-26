//
//  AppIconViewController.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 17.03.2023.
//

import UIKit

class AppIconViewController: BaseVC<AppIconViewModel> {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "AppIconTVC",
                                 bundle: nil),
                           forCellReuseIdentifier: "AppIconTVC")
        tableView.rowHeight = 70
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.startLoading()
        self.tabBarController?.tabBar.isHidden = true
        self.btnAddHide()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BGColor")
        self.navigationItem.title = "App Icon"

        setupUI()
    }

    // MARK: - SETUP UI
    private func setupUI() {

        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 350)
        ])
        self.tableView.reloadData()
        self.stopLoading()
    }
}

// MARK: - UITableViewDataSource
extension AppIconViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.appIconArray.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppIconTVC",
                                                       for: indexPath) as? AppIconTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.fillCell(with: self.viewModel.appIconArray[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AppIconViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let value = self.viewModel.appIconArray[indexPath.row].value
        AppIconManager.shared.changeAppIcon(to: value)
    }
}
