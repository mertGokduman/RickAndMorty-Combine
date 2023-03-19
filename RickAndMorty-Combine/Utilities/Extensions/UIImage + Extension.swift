//
//  UIImage + Extension.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 19.03.2023.
//

import UIKit

extension UIImage {

    func saveImageToUserDefaults() {
        if let _ = UserDefaults.standard.data(forKey: AppConstants.UserDefaultsConstants.profilePicture) {
            UserDefaults.standard.removeObject(forKey: AppConstants.UserDefaultsConstants.profilePicture)
        }
        guard let data = self.pngData() else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: AppConstants.UserDefaultsConstants.profilePicture)
    }
}
