//
//  EditProfileViewModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 19.03.2023.
//

import Foundation
import UIKit
import Combine

struct InfoModel {
    var title: String
    var placeholder: String
    var value: String?
}

final class EditProfileViewModel: BaseViewModel {

    @Published var profilePicture: UIImage?
    @Published var infoArray: [InfoModel] = []

    func setupProfilePicture() {
        guard let data = UserDefaults.standard.data(forKey: AppConstants.UserDefaultsConstants.profilePicture) else { return }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        let image = UIImage(data: decoded)
        self.profilePicture = image
    }

    func setupInfoArray() {

        //Username
        if let username = UserDefaults.standard.string(forKey: AppConstants.UserDefaultsConstants.username) {
            infoArray.append(InfoModel(title: "Username",
                                       placeholder: "Please Enter Your Username",
                                       value: username))
        } else {
            infoArray.append(InfoModel(title: "Username",
                                       placeholder: "Please Enter Your Username"))
        }

        //Name
        if let name = UserDefaults.standard.string(forKey: AppConstants.UserDefaultsConstants.firstname) {
            infoArray.append(InfoModel(title: "Name",
                                       placeholder: "Please Enter Your Name",
                                       value: name))
        } else {
            infoArray.append(InfoModel(title: "Name",
                                       placeholder: "Please Enter Your Name"))
        }

        //Surname
        if let surname = UserDefaults.standard.string(forKey: AppConstants.UserDefaultsConstants.surname) {
            infoArray.append(InfoModel(title: "Surname",
                                       placeholder: "Please Enter Your Surname",
                                       value: surname))
        } else {
            infoArray.append(InfoModel(title: "Surname",
                                       placeholder: "Please Enter Your Surname"))
        }
    }
}
