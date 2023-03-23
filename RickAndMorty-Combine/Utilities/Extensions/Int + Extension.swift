//
//  Int + Extension.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 22.03.2023.
//

import UIKit

extension Int {

    static func parse(from string: String) -> Int? {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}
