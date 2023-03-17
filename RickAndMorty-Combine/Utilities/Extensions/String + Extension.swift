//
//  String + Extension.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 17.03.2023.
//

import Foundation

extension StringProtocol {

    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstLowercased: String { return prefix(1).lowercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}
