//
//  ProfilePhotoCVC.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 16.03.2023.
//

import UIKit

class ProfilePhotoCVC: UICollectionViewCell {

    @IBOutlet weak var profileView: UIView! {
        didSet {
            profileView.layer.cornerRadius = 20
            profileView.layer.masksToBounds = true;
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
