//
//  EpisodesViewController.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 16.03.2023.
//

import UIKit

class EpisodesViewController: BaseVC<EpisodeViewModel> {

    private lazy var searchBar: SearchView = {
        let view = SearchView()
        view.backgroundColor = .clear
        view.setupSearchTF(placeholder: "Search episodes...")
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

    lazy var isSearching: Bool = false

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tabBarController?.tabBar.isHidden = false
        self.btnAddShow()
        viewModel.getEpisodes(isPagination: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BGColor")
        self.navigationItem.title = "Episodes"

        setupUI()
        bind()
        makeViewDismissKeyboard(cancelsTouchesInView: false)
    }

    // MARK: - BIND
    private func bind() {

        viewModel.$episodes
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
        let nibs = [SingleEpisodeCVC.self]
        collectionView.registerNibs(withClassesAndIdentifiers: nibs)
    }

    private func routeToDetailVC(episodeID: Int?) {
        let vc = DetailViewController()
        vc.viewModel.viewType = .episode(episodeID~)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension EpisodesViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.episodes?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleEpisodeCVC",
                                                            for: indexPath) as? SingleEpisodeCVC else { return UICollectionViewCell() }
        if let episodes = viewModel.episodes {
            cell.fillCell(with: episodes[indexPath.row])
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension EpisodesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.routeToDetailVC(episodeID: viewModel.episodes?[indexPath.row].id)
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.episodes?.count ?? 0) - 1 && (viewModel.episodes?.count ?? 0) < viewModel.count && !isSearching {
            viewModel.getEpisodes(isPagination: true)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension EpisodesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (getScreenSize().width - 45) / 2
        return CGSize(width: width,
                      height: 150)
    }
}

// MARK: - SearchViewDelegate
extension EpisodesViewController: SearchViewDelegate {

    func beginEditing(text: String) {
        if text != "" {
            self.isSearching = true
            viewModel.searchEpisodes(searchText: text)
        } else {
            self.isSearching = false
            viewModel.page = 1
            viewModel.getEpisodes(isPagination: false)
        }
    }
}

// MARK: - TabBarItemable
extension EpisodesViewController: TabBarItemable {
    var tabItem: TabItem {
        return TabItem(title: "Episodes",
                       image: UIImage(systemName: "popcorn")?.withTintColor(UIColor(named: "LabelColor") ?? .black),
                       selectedImage: UIImage(systemName: "popcorn.fill")?.withTintColor(UIColor(named: "TabbarSelectedColor") ?? .selectedTabbarColor),
                       isEnable: true)
    }
}
