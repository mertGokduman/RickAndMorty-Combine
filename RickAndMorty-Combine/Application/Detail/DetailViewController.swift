//
//  DetailViewController.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 21.03.2023.
//

import UIKit

enum DetailViewTypes {
    case details
    case dropDown
}

class DetailViewController: BaseVC<DetailViewModel> {

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

    lazy var typeArray: [DetailViewTypes] = [.details, .dropDown]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = true
        self.btnAddHide()
        viewModel.getData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BGColor")
        self.navigationItem.title = "Details"
        setupUI()
        bind()
    }

    func bind() {

        viewModel.$character
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.collectionView.reloadData()
            }.store(in: &cancelables)

        viewModel.$episode
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.collectionView.reloadData()
            }.store(in: &cancelables)

        viewModel.$location
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.collectionView.reloadData()
            }.store(in: &cancelables)
    }

    func setupUI() {

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
        let nibs = [CharacterDetailCVC.self, DropDownCVC.self]
        collectionView.registerNibs(withClassesAndIdentifiers: nibs)
    }
}

// MARK: - UICollectionViewDataSource
extension DetailViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return typeArray.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let section = typeArray[section]
        switch section {
        case .details:
            return 1
        case .dropDown:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = typeArray[indexPath.section]
        switch section {
        case .details:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterDetailCVC.identifier,
                                                                for: indexPath) as? CharacterDetailCVC else { return UICollectionViewCell() }
            if let character = viewModel.character {
                cell.fillCell(with: character)
            }
            return cell
        case .dropDown:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DropDownCVC.identifier,
                                                                for: indexPath) as? DropDownCVC else { return UICollectionViewCell() }
            cell.fillCell()
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = typeArray[indexPath.section]
        switch section {
        case .details:
            return CGSize(width: getScreenSize().width,
                          height: 440)
        case .dropDown:
//            let height = CGFloat(viewModel.count~ * 65) + 50
            let height = CGFloat(5*60) + 50
            return CGSize(width: getScreenSize().width,
                          height: height)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension DetailViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
    }
}
