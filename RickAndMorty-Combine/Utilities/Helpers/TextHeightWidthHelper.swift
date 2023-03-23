//
//  TextHeightWidthHelper.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 23.03.2023.
//

import Foundation
import UIKit

protocol TextRequiredHeightWidthCalculaterProtocol {

}

extension TextRequiredHeightWidthCalculaterProtocol {

    func calculateTextRequiredHeight(text: String?,
                                     labelWidth: CGFloat,
                                     font: UIFont,
                                     alignment: NSTextAlignment? = nil ) -> CGFloat {
        var height = CGFloat(0)
        guard text != nil && text != ""  else { return height }
        let size = CGSize(width: labelWidth, height: .greatestFiniteMagnitude)
        var attributes: [NSAttributedString.Key : NSObject]

        if let _alignment = alignment {
            let style = NSMutableParagraphStyle()
            style.alignment = _alignment
            attributes = [NSAttributedString.Key.font: font, .paragraphStyle: style]
        } else {
            attributes = [NSAttributedString.Key.font: font]
        }

        let estimatedLabelFrame = NSString(string: text~).boundingRect(with: size,
                                                                      options: .usesLineFragmentOrigin,
                                                                      attributes: attributes,
                                                                      context: nil)

        height = estimatedLabelFrame.height.rounded(.up)
        return height
    }

    func calculateTextRequiredWidth(text: String?,
                                    font: UIFont) -> CGFloat {
        var width = CGFloat(0)
        guard text != nil || text != ""  else { return width }
        let attributes = [NSAttributedString.Key.font: font]
        let estimatedTextWidth = NSAttributedString(string: text!, attributes: attributes)
        width = ceil(estimatedTextWidth.size().width)
        return width
    }
}
