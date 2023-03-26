//
//  CharacterViewController.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 16.03.2023.
//

import UIKit

class CharacterViewController: BaseVC<CharacterViewModel> {

    private lazy var searchBar: SearchView = {
        let view = SearchView()
        view.backgroundColor = .clear
        view.setupSearchTF(placeholder: "Search characters...")
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

        self.startLoading()
        self.tabBarController?.tabBar.isHidden = false
        self.btnAddShow()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BGColor")
        self.navigationItem.title = "Characters"

        setupUI()
        bind()
        viewModel.getCharacters(isPagination: false)
        makeViewDismissKeyboard(cancelsTouchesInView: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.stopLoading()
    }

    // MARK: - BIND
    private func bind() {

        viewModel.$characters
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.collectionView.reloadData()
                self.stopLoading()
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

    private func routeToDetailVC(characterID: Int?) {
        let vc = DetailViewController()
        vc.viewModel.viewType = .character(characterID~)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension CharacterViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.characters?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleCharacterCVC",
                                                            for: indexPath) as? SingleCharacterCVC else { return UICollectionViewCell() }
        if let characters = viewModel.characters {
            cell.fillCell(with: characters[indexPath.row])
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CharacterViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.routeToDetailVC(characterID: viewModel.characters?[indexPath.row].id)
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.characters?.count ?? 0) - 1 && (viewModel.characters?.count ?? 0) < viewModel.count && !isSearching {
            viewModel.getCharacters(isPagination: true)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CharacterViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (getScreenSize().width - 45) / 2
        return CGSize(width: width,
                      height: 270)
    }
}

// MARK: - SearchViewDelegate
extension CharacterViewController: SearchViewDelegate {

    func beginEditing(text: String) {
        if text != "" {
            self.isSearching = true
            viewModel.searchCharacter(searchText: text)
        } else {
            self.isSearching = false
            viewModel.page = 1
            viewModel.getCharacters(isPagination: false)
        }
    }
}

// MARK: - TabBarItemable
extension CharacterViewController: TabBarItemable {
    var tabItem: TabItem {
        return TabItem(title: "Characters",
                       image: UIImage(systemName: "person.3")?.withTintColor(UIColor(named: "LabelColor") ?? .black),
                       selectedImage: UIImage(systemName: "person.3.fill")?.withTintColor(UIColor(named: "TabbarSelectedColor") ?? .selectedTabbarColor),
                       isEnable: true)
    }
}
