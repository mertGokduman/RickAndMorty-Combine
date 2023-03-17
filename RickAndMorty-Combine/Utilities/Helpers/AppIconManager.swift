//
//  AppIconManager.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 17.03.2023.
//

import Foundation
import UIKit

enum AppIcons: String {
    case orange = "AppIcon"
    case blue = "AppIcon2"
    case green = "AppIcon3"
    case red = "AppIcon4"
    case purple = "AppIcon5"
}

final class AppIconManager {

    static let shared = AppIconManager()

    func changeAppIcon(to appIcon: String?) {
        UIApplication.shared.setAlternateIconName(appIcon)
    }

    func getSelectedAppIcon() -> String? {
        let appIconName = UIApplication.shared.alternateIconName
        return appIconName
    }
}
