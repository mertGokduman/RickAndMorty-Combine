//
//  ProfileViewController.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 16.03.2023.
//

import UIKit

enum ProfileCollectionViewType {
    case photo
    case appearance
    case appIcon
}

class ProfileViewController: BaseVC<ProfileViewModel> {

    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        return flowLayout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: self.collectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0)
        return collectionView
    }()

    var typeArray: [ProfileCollectionViewType] = [.photo, .appearance]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tabBarController?.tabBar.isHidden = false
        self.viewModel.getUserDatas()
        self.btnAddShow()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BGColor")
        self.navigationItem.title = "Profile"

        setupUI()
        bind()
    }

    // MARK: - Bind
    private func bind() {

        viewModel.$profilePicture
            .sink { _ in
                self.collectionView.reloadData()
            }.store(in: &cancelables)

        viewModel.$fullName
            .sink { _ in
                self.collectionView.reloadData()
            }.store(in: &cancelables)

        viewModel.$isDarkModeOn
            .sink { _ in
                self.collectionView.reloadData()
            }.store(in: &cancelables)

        viewModel.$appIconName
            .sink { _ in
                self.collectionView.reloadData()
            }.store(in: &cancelables)
    }

    // MARK: - SETUP UI
    private func setupUI() {

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        self.setupCollectionView()
    }

    // MARK: - COLLECTIONVIEW SETUPS
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        self.registerCollectionView()
    }

    private func registerCollectionView() {
        let nibs = [ProfilePhotoCVC.self, AppearanceCVC.self]
        collectionView.registerNibs(withClassesAndIdentifiers: nibs)
    }
}

// MARK: - UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return typeArray.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let section = typeArray[section]
        switch section {
        case .photo:
            return 1
        case .appearance:
            return 1
        case .appIcon:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = typeArray[indexPath.section]
        switch section {
        case .photo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePhotoCVC",
                                                                for: indexPath) as? ProfilePhotoCVC else { return UICollectionViewCell() }
            cell.delegate = self
            cell.fillCell(with: self.viewModel.profilePicture,
                          userName: self.viewModel.fullName)
            return cell
        case .appearance:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppearanceCVC",
                                                                for: indexPath) as? AppearanceCVC else { return UICollectionViewCell() }
            cell.delegate = self
            cell.fillCell(isDarkMode: self.viewModel.isDarkModeOn ?? false,
                          appIconName: self.viewModel.appIconName)
            return cell
        case .appIcon:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ProfileViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = typeArray[indexPath.section]
        switch section {
        case .photo:
            return CGSize(width: getScreenSize().width, height: getScreenSize().width)
        case .appearance:
            return CGSize(width: getScreenSize().width,
                          height: 100)
        case .appIcon:
            return .zero
        }
    }
}

// MARK: - AppearanceCellDelegate
extension ProfileViewController: AppearanceCellDelegate {

    func btnAppearancePressed() {
        let vc = AppIconViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func switchChanged(isOn: Bool) {
        UIView.animate(withDuration: 0.5) {
            if #available(iOS 13.0, *) {
                let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
                sceneDelegate.window?.overrideUserInterfaceStyle = isOn ? .dark : .light
                UserDefaults.standard.set(isOn, forKey: AppConstants.UserDefaultsConstants.appearance)
            }
        }
    }
}

// MARK: - ProfilePhotoDelegate
extension ProfileViewController: ProfilePhotoDelegate {

    func btnEditPressed() {
        let vc = EditProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - TabBarItemable
extension ProfileViewController: TabBarItemable {
    var tabItem: TabItem {
        return TabItem(title: "Profile",
                       image: UIImage(systemName: "person")?.withTintColor(UIColor(named: "LabelColor") ?? .black),
                       selectedImage: UIImage(systemName: "person.fill")?.withTintColor(UIColor(named: "TabbarSelectedColor") ?? .selectedTabbarColor),
                       isEnable: true)
    }
}
