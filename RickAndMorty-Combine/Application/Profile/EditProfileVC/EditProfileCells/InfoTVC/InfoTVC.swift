//
//  InfoTVC.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 19.03.2023.
//

import UIKit

class InfoTVC: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tfInput: UITextField! {
        didSet {
            tfInput.textColor = UIColor(named: "LabelColor")
            tfInput.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    func fillCell(with infoModel: InfoModel) {
        lblTitle.text = infoModel.title
        tfInput.attributedPlaceholder = NSAttributedString(string: infoModel.placeholder,
                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        if let text = infoModel.value {
            tfInput.text = text
        }
    }

    func getTextFieldText() -> String {
        if let text = tfInput.text {
            return text
        } else {
            return ""
        }
    }
}
