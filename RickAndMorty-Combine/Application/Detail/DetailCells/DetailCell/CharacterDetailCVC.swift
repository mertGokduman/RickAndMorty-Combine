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
            imgDetail.contentMode = .scaleAspectFill
            imgDetail.layer.cornerRadius = 20
            imgDetail.clipsToBounds = true
        }
    }
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var mainStack: UIStackView! {
        didSet {
            mainStack.layer.borderColor = UIColor(named: "LabelColor")?.withAlphaComponent(0.25).cgColor
            mainStack.layer.borderWidth = 2
            mainStack.layer.cornerRadius = 20
            mainStack.clipsToBounds = true
        }
    }

    @IBOutlet weak var topStack: UIStackView!
    @IBOutlet weak var genderView: DetailDataView!
    @IBOutlet weak var speciesView: DetailDataView!
    @IBOutlet weak var statusView: DetailDataView!

    @IBOutlet weak var bottomStack: UIStackView!
    @IBOutlet weak var originView: DetailDataView!
    @IBOutlet weak var locationView: DetailDataView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillCell(with model: Any?) {
        if let character = model as? Character {
            lblName.text = character.name
            if let imageUrl = URL(string: character.image ?? "") {
                imgDetail.kf.setImage(with: imageUrl)
            }
            fillCharacterDetails(character: character)
        } else if let episode = model as? Episode {
            imgDetail.image = UIImage(named: "episodeBG")
            lblName.text = episode.name
            fillEpisodeDetails(episode: episode)
        } else if let location = model as? Location {
            lblName.text = location.name
            imgDetail.image = UIImage(named: "locationBG")
            fillLocationDetail(location: location)
        }
    }

    // MARK: - Character Details
    private func fillCharacterDetails(character: Character) {
        topStack.isHidden = false
        genderView.fillView(with: "Gender",
                            value: character.gender)
        speciesView.fillView(with: "Species",
                             value: character.species)
        statusView.fillView(with: "Status",
                            value: character.status)
        originView.fillView(with: "Origin",
                            value: character.origin?.name)
        locationView.fillView(with: "Location",
                              value: character.location?.name)
    }

    // MARK: - Episode Details
    private func fillEpisodeDetails(episode: Episode) {
        topStack.isHidden = true
        originView.fillView(with: "Episode",
                            value: episode.episode)
        locationView.fillView(with: "Air Date",
                              value: episode.airDate)
    }

    // MARK: - Location Details
    private func fillLocationDetail(location: Location) {
        topStack.isHidden = true
        originView.fillView(with: "Type",
                            value: location.type)
        locationView.fillView(with: "Dimension",
                              value: location.dimension)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
