//
//  DetailCVC.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 21.03.2023.
//

import UIKit

class CharacterDetailCVC: UICollectionViewCell {

    static let identifier = "CharacterDetailCVC"

    @IBOutlet weak var imgDetail: UIImageView! {
        didSet {
            imgDetail.layer.cornerRadius = 20
            imgDetail.clipsToBounds = true
        }
    }
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var mainStack: UIStackView!

    @IBOutlet weak var topStack: UIStackView!
    @IBOutlet weak var genderView: DetailDataView!
    @IBOutlet weak var speciesView: DetailDataView!
    @IBOutlet weak var statusView: DetailDataView!

    @IBOutlet weak var bottomStack: UIStackView!
    @IBOutlet weak var originView: DetailDataView!
    @IBOutlet weak var LocationView: DetailDataView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillCell(with model: Any) {
        if let character = model as? Character {
            lblName.text = character.name
            if let imageUrl = URL(string: character.image ?? "") {
                imgDetail.kf.setImage(with: imageUrl)
            }
            fillCharacterDetails(character: character)
        } else if let episode = model as? Episode {
            imgDetail.image = UIImage(named: "episodeBG")
        } else if let location = model as? Location {
            imgDetail.image = UIImage(named: "locationBG")
        }
    }

    private func fillCharacterDetails(character: Character) {
        genderView.fillView(with: "Gender",
                            value: character.gender)
        speciesView.fillView(with: "Species",
                             value: character.species)
        statusView.fillView(with: "Status",
                            value: character.status)
        originView.fillView(with: "Origin",
                            value: character.origin?.name)
        LocationView.fillView(with: "Location",
                              value: character.location?.name)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
