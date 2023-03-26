//
//  Date + Extension.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 26.03.2023.
//

import Foundation

extension Date {

    func formatDate() -> String {

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd MMMM yyyy"
        dateFormatterGet.locale = Locale(identifier: "en")
        let dateString = dateFormatterGet.string(from: self)
        return dateString
    }
}
