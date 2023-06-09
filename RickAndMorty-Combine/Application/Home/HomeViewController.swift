//
//  HomeViewController.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 14.03.2023.
//

import UIKit
import Combine

enum HomeCollectionViewType {
    case characters
    case episodes
    case locations
}

class HomeViewController: BaseVC<HomeViewModel> {

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

    weak var headerView: WelcomeHeader?
    lazy var typeArray: [HomeCollectionViewType] = [.characters, .episodes, .locations]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = false
        self.btnAddShow()
        self.startLoading()
        viewModel.getDatas()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BGColor")
        setupUI()
        bind()
    }

    // MARK: - BINDING DATAS
    private func bind() {

        viewModel.isDataReady
            .receive(on: RunLoop.main)
            .sink { [weak self] isReady in
                guard let self = self else { return }
                if isReady {
                    self.collectionView.reloadData()
                    self.stopLoading()
                }
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
        (collectionView as UIScrollView).delegate = self
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionHeadersPinToVisibleBounds = true
        self.registerCollectionView()
    }

    private func registerCollectionView() {
        let nibs = [CharacterCVC.self, EpisodeCVC.self]
        collectionView.registerNibs(withClassesAndIdentifiers: nibs)
        collectionView.register(UINib(nibName: WelcomeHeader.nibName,
                                      bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: WelcomeHeader.identifier)
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return typeArray.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let section = typeArray[section]
        switch section {
        case .characters:
            return 1
        case .episodes:
            return 1
        case .locations:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = typeArray[indexPath.section]
        switch section {
        case .characters:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCVC",
                                                                for: indexPath) as? CharacterCVC else { return UICollectionViewCell() }
            cell.fillCell(with: viewModel.characters?.shuffled(),
                          title: "Characters")
            cell.delegate = self
            return cell
        case .episodes:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodeCVC",
                                                                for: indexPath) as? EpisodeCVC else { return UICollectionViewCell() }
            cell.delegate = self
            cell.fillCell(with: viewModel.episodes?.shuffled(),
                          title: "Episodes")
            return cell
        case .locations:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCVC",
                                                                for: indexPath) as? CharacterCVC else { return UICollectionViewCell() }
            cell.fillCell(with: viewModel.locations?.shuffled(),
                          title: "Locations")
            cell.delegate = self
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                               withReuseIdentifier: WelcomeHeader.identifier, for: indexPath) as? WelcomeHeader else { return UICollectionReusableView() }
        headerView.delegate = self
        headerView.layer.shadowColor = UIColor.clear.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0,
                                               height: 12)
        headerView.layer.shadowRadius = 8
        headerView.layer.shadowOpacity = 0.12
        headerView.clipsToBounds = false
        headerView.fillHeader(profilePicture: self.viewModel.profilePicture,
                              name: self.viewModel.name)
        self.headerView = headerView
        return headerView
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = typeArray[indexPath.section]
        switch section {
        case .characters:
            return CGSize(width: getScreenSize().width,
                          height: 320)
        case .episodes:
            return CGSize(width: getScreenSize().width,
                          height: 200)
        case .locations:
            return CGSize(width: getScreenSize().width,
                          height: 320)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let section = typeArray[section]
        switch section {
        case .characters:
            return CGSize(width: getScreenSize().width,
                          height: 80)
        default:
            return .zero
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate { }

// MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = collectionView.contentOffset.y
        if offset == 0 || offset < 0 {
            self.headerView?.layer.shadowColor = UIColor.clear.cgColor
        } else {
            self.headerView?.layer.shadowColor = UIColor.black.cgColor
        }
    }
}

// MARK: - WelcomeHeaderDelegate
extension HomeViewController: WelcomeHeaderDelegate {
    func profileImageTapped() {
        self.tabBarController?.selectedIndex = 4
    }
}

// MARK: - CharacterCVCDelegate
extension HomeViewController: CharacterCVCDelegate {

    func viewAllTapped(type: CharacterCVCType) {
        switch type {
        case .character:
            self.tabBarController?.selectedIndex = 0
        case .location:
            self.tabBarController?.selectedIndex = 3
        }
    }

    func characterTapped(characterID: Int?) {
        let vc = DetailViewController()
        vc.viewModel.viewType = .character(characterID~)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func locationTapped(locationId: Int?) {
        let vc = DetailViewController()
        vc.viewModel.viewType = .location(locationId~)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - EpisodeCVCDelegate
extension HomeViewController: EpisodeCVCDelegate {

    func viewAllTapped() {
        self.tabBarController?.selectedIndex = 1
    }
    func episodeTapped(episodeID: Int?) {
        let vc = DetailViewController()
        vc.viewModel.viewType = .episode(episodeID~)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - TabBarItemable
extension HomeViewController: TabBarItemable {
    var tabItem: TabItem {
        return TabItem(title: "",
                       image: nil,
                       selectedImage: nil,
                       isEnable: false)
    }
}
