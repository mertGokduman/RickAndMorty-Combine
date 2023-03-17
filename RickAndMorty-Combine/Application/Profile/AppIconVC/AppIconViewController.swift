//
//  AppIconViewController.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 17.03.2023.
//

import UIKit

struct AppIconModel {

    var name: String
    var imgName: String
    var type: AppIcons
    var value: String? {
        switch type {
        case .orange:
            return nil
        default:
            return type.rawValue
        }
    }
}

class AppIconViewController: BaseVC<BaseViewModel> {

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

    lazy var appIconArray: [AppIconModel] = [AppIconModel(name: "Orange",
                                                          imgName: "appIcon1",
                                                          type: .orange),
                                             AppIconModel(name: "Blue",
                                                          imgName: "appIcon2",
                                                          type: .blue),
                                             AppIconModel(name: "Green",
                                                          imgName: "appIcon3",
                                                          type: .green),
                                             AppIconModel(name: "Red",
                                                          imgName: "appIcon4",
                                                          type: .red),
                                             AppIconModel(name: "Purple",
                                                          imgName: "appIcon5",
                                                          type: .purple)]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

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
    }
}

// MARK: - UITableViewDataSource
extension AppIconViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.appIconArray.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppIconTVC",
                                                       for: indexPath) as? AppIconTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.fillCell(with: appIconArray[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AppIconViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let value = appIconArray[indexPath.row].value
        AppIconManager.shared.changeAppIcon(to: value)
    }
}
