//
//  SingleCharacterCVC.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 15.03.2023.
//

import UIKit
import Kingfisher

class SingleCharacterCVC: UICollectionViewCell {

    @IBOutlet weak var imgCharacter: UIImageView! {
        didSet {
            imgCharacter.layer.cornerRadius = 10
            imgCharacter.clipsToBounds = true
        }
    }
    @IBOutlet weak var gradientView: UIView! {
        didSet {
            gradientView.layer.cornerRadius = 10
            gradientView.clipsToBounds = true
        }
    }
    @IBOutlet weak var lblCharacter: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        setupGradientView()
    }

    private func setupGradientView() {

        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.clear.cgColor,
                           UIColor.black.withAlphaComponent(0.15).cgColor,
                           UIColor.black.withAlphaComponent(0.65).cgColor,
                           UIColor.black.cgColor]
        gradient.locations = [0, 0.1, 0.9, 1]
        gradientView.layer.addSublayer(gradient)
        gradientView.bringSubviewToFront(lblCharacter)
    }

    func fillCell(with item: Any) {
        if let character = item as? Character {
            lblCharacter.text = character.name
            if let imageURL = URL(string: character.image~) {
                imgCharacter.kf.setImage(with: imageURL)
            }
        } else if let location = item as? Location {
            lblCharacter.text = location.name
            imgCharacter.image = UIImage(named: "locationBG")
        }
    }
}
