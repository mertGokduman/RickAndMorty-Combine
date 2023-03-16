//
//  WelcomeHeader.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 15.03.2023.
//

import UIKit

class WelcomeHeader: UICollectionReusableView {

    static let identifier = "WelcomeHeader"
    static let nibName = "WelcomeHeader"

    @IBOutlet weak var btnUser: UIButton! {
        didSet {
            btnUser.layer.cornerRadius = 20
            btnUser.clipsToBounds = true
        }
    }
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
}
