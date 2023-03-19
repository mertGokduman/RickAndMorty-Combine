//
//  PhotoTVC.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 19.03.2023.
//

import UIKit

protocol PhotoTVCDelegate: AnyObject {
    func btnPhotoAddPressed()
}

class PhotoTVC: UITableViewCell {

    weak var delegate: PhotoTVCDelegate?

    @IBOutlet weak var btnPhoto: UIButton! {
        didSet {
            btnPhoto.layer.cornerRadius = 75
            btnPhoto.clipsToBounds = true
        }
    }

    @IBOutlet weak var btnAddPhoto: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let btnAddAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold),
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]

        let btnAddAttributeString = NSMutableAttributedString(string: "Add Profile Picture",
                                                              attributes: btnAddAttributes)
        btnAddPhoto.setAttributedTitle(btnAddAttributeString,
                                       for: .normal)

        btnPhoto.addTarget(self,
                           action: #selector(btnPhotoAddTapped),
                           for: .touchUpInside)
        btnAddPhoto.addTarget(self,
                              action: #selector(btnPhotoAddTapped),
                              for: .touchUpInside)
    }

    func fillCell(with image: UIImage?) {
        if let image = image {
            btnPhoto.setImage(image,
                              for: .normal)
        }
    }

    @objc private func btnPhotoAddTapped() {
        delegate?.btnPhotoAddPressed()
    }
}
