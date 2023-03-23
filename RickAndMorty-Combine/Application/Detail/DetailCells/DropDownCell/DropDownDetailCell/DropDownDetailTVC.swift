//
//  DropDownDetailTVC.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 21.03.2023.
//

import UIKit

class DropDownDetailTVC: UITableViewCell {

    static let identifier = "DropDownDetailTVC"
    static let rowHeight: CGFloat = 50

    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fillCell(with title: String?) {
        lblTitle.text = title
    }
}
