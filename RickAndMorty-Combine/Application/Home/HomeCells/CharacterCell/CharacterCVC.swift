//
//  CharacterCVC.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 15.03.2023.
//

import UIKit

protocol CharacterCVCDelegate: AnyObject {
    func viewAllTapped(type: CharacterCVCType)
}

enum CharacterCVCType {
    case character
    case location
}

class CharacterCVC: UICollectionViewCell {

    weak var delegate: CharacterCVCDelegate?

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!

    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionViewFlowLayout.itemSize = CGSize(width: 180,
                                                       height: 270)
            collectionViewFlowLayout.minimumLineSpacing = 15
            collectionViewFlowLayout.minimumInteritemSpacing = 10
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerNib(withClassAndIdentifier: SingleCharacterCVC.self)
        }
    }

    lazy var type: CharacterCVCType = .character
    lazy var characterArray: [Any] = []
    
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
        if let characters = model as? [Character] {
            self.characterArray = Array(characters.prefix(5))
            self.type = .character
            collectionView.reloadData()
        } else if let locations = model as? [Location] {
            self.characterArray = Array(locations.prefix(5))
            self.type = .location
            collectionView.reloadData()
        }
    }

    @objc private func btnViewAllTapped() {
        delegate?.viewAllTapped(type: self.type)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - UICollectionViewDataSource
extension CharacterCVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return characterArray.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleCharacterCVC",
                                                            for: indexPath) as? SingleCharacterCVC else { return UICollectionViewCell() }
        cell.fillCell(with: characterArray[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CharacterCVC: UICollectionViewDelegate {

}
