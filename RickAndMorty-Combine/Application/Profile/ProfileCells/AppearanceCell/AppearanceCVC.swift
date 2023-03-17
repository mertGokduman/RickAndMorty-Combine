//
//  AppearanceCVC.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 16.03.2023.
//

import UIKit

protocol AppearanceCellDelegate: AnyObject {
    func btnAppearancePressed()
    func switchChanged(isOn: Bool)
}

class AppearanceCVC: UICollectionViewCell {

    weak var delegate: AppearanceCellDelegate?

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

        darkModeSwitch.addTarget(self,
                                 action: #selector(darkModeSwitchChanged),
                                 for: .valueChanged)

        btnAppIcon.addTarget(self,
                             action: #selector(btnAppearanceTapped),
                             for: .touchUpInside)
    }

    func setAppIcon() {
        let appIconName = AppIconManager.shared.getSelectedAppIcon()?.firstLowercased
        btnAppIcon.setImage(UIImage(named: appIconName ?? "appIcon1"),
                            for: .normal)
    }

    // MARK: - APPEARANCE BUTTON FUNCTION
    @objc private func btnAppearanceTapped() {
        delegate?.btnAppearancePressed()
    }

    // MARK: - SWITCH FUNCTION
    @objc private func darkModeSwitchChanged() {
        delegate?.switchChanged(isOn: self.darkModeSwitch.isOn)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
