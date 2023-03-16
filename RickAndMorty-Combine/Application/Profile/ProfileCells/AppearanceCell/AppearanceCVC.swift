//
//  AppearanceCVC.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 16.03.2023.
//

import UIKit

class AppearanceCVC: UICollectionViewCell {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!

    @IBOutlet weak var lblIconAppearance: UILabel!
    @IBOutlet weak var btnAppIcon: UIButton! {
        didSet {
            btnAppIcon.layer.cornerRadius = 4
            btnAppIcon.clipsToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
