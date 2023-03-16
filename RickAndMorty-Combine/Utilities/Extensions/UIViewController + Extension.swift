//
//  UIViewController + Extension.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 14.03.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func getScreenSize() -> CGRect{
        let screenSize: CGRect = UIScreen.main.bounds
        return screenSize
    }

    var isDarkMode: Bool {
        if #available(iOS 13.0, *) {
            return self.traitCollection.userInterfaceStyle == .dark
        } else {
            return false
        }
    }
}
