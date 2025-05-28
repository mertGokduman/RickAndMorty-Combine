//
//  ProfilePhotoCVC.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 16.03.2023.
//

import UIKit

protocol ProfilePhotoDelegate: AnyObject {
    func btnEditPressed()
}

class ProfilePhotoCVC: UICollectionViewCell {

    weak var delegate: ProfilePhotoDelegate?

    @IBOutlet weak var profileView: UIView! {
        didSet {
            profileView.layer.cornerRadius = 20
            profileView.layer.masksToBounds = true
            profileView.layer.shadowColor = UIColor.lightGray.cgColor
            profileView.layer.shadowOpacity = 0.8
            profileView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            profileView.layer.shadowRadius = 6.0
            profileView.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var imgUser: UIImageView! {
        didSet {
            imgUser.layer.cornerRadius = 100
            imgUser.layer.borderWidth = 2
            imgUser.layer.borderColor = UIColor.lightGray.cgColor
            imgUser.clipsToBounds = true
        }
    }
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var bioLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        btnEdit.addTarget(self,
                          action: #selector(btnEditTapped),
                          for: .touchUpInside)
    }

    func fillCell(with image: UIImage?,
                  userName: String?,
                  bioText: String?) {
        lblUserName.text = userName
        bioLabel.text = bioText
        if let image = image {
            imgUser.image = image
        } else {
            imgUser.image = UIImage(named: "user")
        }
    }

    @objc private func btnEditTapped() {
        delegate?.btnEditPressed()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
