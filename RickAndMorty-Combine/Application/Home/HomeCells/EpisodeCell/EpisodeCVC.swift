//
//  EpisodeCVC.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 15.03.2023.
//

import UIKit

protocol EpisodeCVCDelegate: AnyObject {
    func viewAllTapped()
}

class EpisodeCVC: UICollectionViewCell {

    weak var delegate: EpisodeCVCDelegate?

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionViewFlowLayout.itemSize = CGSize(width: 180,
                                                       height: 150)
            collectionViewFlowLayout.minimumLineSpacing = 15
            collectionViewFlowLayout.minimumInteritemSpacing = 10
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerNib(withClassAndIdentifier: SingleEpisodeCVC.self)
        }
    }

    lazy var episodeArray: [Episode] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self

        btnViewAll.addTarget(self,
                             action: #selector(btnViewAllTapped),
                             for: .touchUpInside)
    }

    func fillCell(with model: Any?,
                  title: String) {
        lblTitle.text = title
        if let episodes = model as? [Episode] {
            self.episodeArray = Array(episodes.prefix(5))
            collectionView.reloadData()
        }
    }

    @objc private func btnViewAllTapped() {
        delegate?.viewAllTapped()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - UICollectionViewDataSource
extension EpisodeCVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return episodeArray.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleEpisodeCVC",
                                                            for: indexPath) as? SingleEpisodeCVC else { return UICollectionViewCell() }
        cell.fillCell(with: episodeArray[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension EpisodeCVC: UICollectionViewDelegate {

}
