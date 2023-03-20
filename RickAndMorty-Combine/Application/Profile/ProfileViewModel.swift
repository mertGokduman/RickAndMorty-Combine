//
//  ProfileViewModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 16.03.2023.
//

import Foundation
import Combine
import UIKit

final class ProfileViewModel: BaseViewModel {

    @Published var profilePicture: UIImage?
    var name: String = ""
    var surname: String = ""
    @Published var fullName: String?
    @Published var isDarkModeOn: Bool?
    @Published var appIconName: String?

    func setupProfilePicture() {
        guard let data = UserDefaults.standard.data(forKey: AppConstants.UserDefaultsConstants.profilePicture) else { return }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        let image = UIImage(data: decoded)
        self.profilePicture = image
    }

    func getUserDatas() {

        self.setupProfilePicture()

        //Name
        if let name = UserDefaults.standard.string(forKey: AppConstants.UserDefaultsConstants.firstname) {
            self.name = name
        }

        //Surname
        if let surname = UserDefaults.standard.string(forKey: AppConstants.UserDefaultsConstants.surname) {
            self.surname = surname
        }

        //Full Name
        self.fullName = name + " " + surname

        //Appearance
        self.isDarkModeOn = UserDefaults.standard.bool(forKey: AppConstants.UserDefaultsConstants.appearance)

        //AppIcon
        appIconName = AppIconManager.shared.getSelectedAppIcon()?.firstLowercased
    }
}
