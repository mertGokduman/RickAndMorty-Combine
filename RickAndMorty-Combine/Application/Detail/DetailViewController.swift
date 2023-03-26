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
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
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
    lazy var height: CGFloat = 0

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.startLoading()
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
            .sink { [weak self] character in
                guard let self = self else { return }
                self.viewModel.getCharacterEpispdes(character: character)
            }.store(in: &cancelables)

        viewModel.$characterEpisodes
            .sink { [weak self] dataArray in
                guard let self = self else { return }
                self.height = self.getTableViewHeight(dataArray: dataArray)
                self.collectionView.reloadData()
                self.stopLoading()
            }.store(in: &cancelables)

        viewModel.$episode
            .sink { [weak self] episode in
                guard let self = self else { return }
                self.viewModel.getEpisodeCharacters(episode: episode)
            }.store(in: &cancelables)

        viewModel.$location
            .sink { [weak self] location in
                guard let self = self else { return }
                self.viewModel.getLocationResidents(location: location)
            }.store(in: &cancelables)

        viewModel.$charactersNames
            .sink { [weak self] dataArray in
                guard let self = self else { return }
                self.height = self.getTableViewHeight(dataArray: dataArray)
                self.collectionView.reloadData()
                self.stopLoading()
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
            switch viewModel.viewType {
            case .character:
                cell.fillCell(with: viewModel.character)
            case .episode:
                cell.fillCell(with: viewModel.episode)
            case .location:
                cell.fillCell(with: viewModel.location)
            default:
                break
            }
            return cell
        case .dropDown:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DropDownCVC",
                                                                for: indexPath) as? DropDownCVC else { return UICollectionViewCell() }
            switch viewModel.viewType {
            case .character:
                cell.fillCell(with: viewModel.characterEpisodes~,
                              title: "Episodes")
            case .episode:
                cell.fillCell(with: viewModel.charactersNames~,
                              title: "Characters")
            case .location:
                cell.fillCell(with: viewModel.charactersNames~,
                              title: "Characters")
            default:
                break
            }
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
            return setupDetailSectionSize()
        case .dropDown:
            return CGSize(width: getScreenSize().width,
                          height: self.height)
        }
    }

    private func setupDetailSectionSize() -> CGSize {
        switch viewModel.viewType {
        case .character:
            return CGSize(width: getScreenSize().width,
                          height: 440)
        case .episode:
            return CGSize(width: getScreenSize().width,
                          height: 380)
        case .location:
            return CGSize(width: getScreenSize().width,
                          height: 380)
        default:
            return .zero
        }
    }
}

// MARK: - TextRequiredHeightWidthCalculaterProtocol
extension DetailViewController: TextRequiredHeightWidthCalculaterProtocol {

    private func getTableViewHeight(dataArray: [String]?) -> CGFloat {
        guard let dataArray = dataArray else { return .zero }
        var height: CGFloat = 0
        for item in dataArray {
            let requiredHeight = calculateTextRequiredHeight(text: item,
                                                             labelWidth: getScreenSize().width - 60,
                                                             font: .systemFont(ofSize: 14,
                                                                               weight: .semibold)) + 20
            let minHeight: CGFloat = 50
            let lastHeight = max(requiredHeight, minHeight)
            height += lastHeight
        }
        return height + 25
    }
}

// MARK: - UICollectionViewDelegate
extension DetailViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
    }
}
