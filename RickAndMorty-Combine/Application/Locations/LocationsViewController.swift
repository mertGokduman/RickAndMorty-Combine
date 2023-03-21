//
//  LocationsViewController.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 16.03.2023.
//

import UIKit

class LocationsViewController: BaseVC<LocationsViewModel> {

    private lazy var searchBar: SearchView = {
        let view = SearchView()
        view.backgroundColor = .clear
        view.setupSearchTF(placeholder: "Search locations...")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 15
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tabBarController?.tabBar.isHidden = false
        self.btnAddShow()
        viewModel.getLocations(isPagination: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BGColor")
        self.navigationItem.title = "Locations"

        setupUI()
        bind()
    }

    // MARK: - BIND
    private func bind() {

        viewModel.$locations
            .sink { _ in
                self.collectionView.reloadData()
            }.store(in: &cancelables)
    }

    // MARK: - SETUP UI
    private func setupUI() {

        searchBar.delegate = self
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        self.setupCollectionView()

        self.collectionView.reloadData()
    }

    // MARK: - COLLECTIONVIEW SETUPS
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        self.registerCollectionView()
    }

    private func registerCollectionView() {
        let nibs = [SingleCharacterCVC.self]
        collectionView.registerNibs(withClassesAndIdentifiers: nibs)
    }
}

// MARK: - UICollectionViewDataSource
extension LocationsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.locations?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleCharacterCVC",
                                                            for: indexPath) as? SingleCharacterCVC else { return UICollectionViewCell() }
        if let locations = viewModel.locations {
            cell.fillCell(with: locations[indexPath.row])
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension LocationsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

    }

//    func collectionView(_ collectionView: UICollectionView,
//                        willDisplay cell: UICollectionViewCell,
//                        forItemAt indexPath: IndexPath) {
//        if indexPath.row == (viewModel.locations?.count ?? 0) - 1 && (viewModel.locations?.count ?? 0) < viewModel.count {
//            viewModel.getLocations(isPagination: true)
//        }
//    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LocationsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (getScreenSize().width - 45) / 2
        return CGSize(width: width,
                      height: 270)
    }
}

// MARK: - SearchViewDelegate
extension LocationsViewController: SearchViewDelegate {

    func beginEditing(text: String) {
        if text != "" {
            viewModel.searchlocations(searchText: text)
        } else {
            viewModel.page = 1
            viewModel.getLocations(isPagination: false)
        }
    }
}

// MARK: - TabBarItemable
extension LocationsViewController: TabBarItemable {
    var tabItem: TabItem {
        return TabItem(title: "Locations",
                       image: UIImage(systemName: "location.square")?.withTintColor(UIColor(named: "LabelColor") ?? .black),
                       selectedImage: UIImage(systemName: "location.square.fill")?.withTintColor(UIColor(named: "TabbarSelectedColor") ?? .selectedTabbarColor),
                       isEnable: true)
    }
}
