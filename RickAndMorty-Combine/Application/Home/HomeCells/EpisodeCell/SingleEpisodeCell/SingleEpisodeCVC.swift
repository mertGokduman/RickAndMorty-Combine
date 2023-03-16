//
//  SingleEpisodeCVC.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 15.03.2023.
//

import UIKit

class SingleEpisodeCVC: UICollectionViewCell {

    @IBOutlet weak var imgEpisode: UIImageView! {
        didSet {
            imgEpisode.layer.cornerRadius = 10
            imgEpisode.clipsToBounds = true
        }
    }
    @IBOutlet weak var gradientView: UIView! {
        didSet {
            gradientView.layer.cornerRadius = 10
            gradientView.clipsToBounds = true
        }
    }
    @IBOutlet weak var lblEpisode: UILabel!

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
        gradientView.bringSubviewToFront(lblEpisode)
    }

    func fillCell(with item: Any) {
        if let episode = item as? Episode {
            lblEpisode.text = episode.name~ + "(" + episode.episode~ + ")"
        }
    }
}
