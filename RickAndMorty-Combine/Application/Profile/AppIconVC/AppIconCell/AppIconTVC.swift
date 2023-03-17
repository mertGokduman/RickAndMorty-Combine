//
//  AppIconTVC.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 17.03.2023.
//

import UIKit

class AppIconTVC: UITableViewCell {

    @IBOutlet weak var lblIconName: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fillCell(with appIconModel: AppIconModel) {

        lblIconName.text = appIconModel.name
        imgIcon.image = UIImage(named: appIconModel.imgName)
    }
}
