//
//  UIView + Extension.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 23.03.2023.
//

import UIKit

extension UIView {

    //BLUR BACKGROUND
    func createBlurBackgroundView(color: UIColor) {
        guard !UIAccessibility.isReduceTransparencyEnabled else { return }

        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.backgroundColor = color
        blurView.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(blurView, at: 0)

        blurView.frame = self.frame

        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        blurView.contentView.addSubview(vibrancyView)

        vibrancyView.frame = blurView.frame
    }
}
