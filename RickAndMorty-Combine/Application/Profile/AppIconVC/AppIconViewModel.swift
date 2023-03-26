//
//  AppIconViewModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 26.03.2023.
//

import Foundation

struct AppIconModel {

    var name: String
    var imgName: String
    var type: AppIcons
    var value: String? {
        switch type {
        case .orange:
            return nil
        default:
            return type.rawValue
        }
    }
}

final class AppIconViewModel: BaseViewModel {

    lazy var appIconArray: [AppIconModel] = [AppIconModel(name: "Orange",
                                                          imgName: "appIcon1",
                                                          type: .orange),
                                             AppIconModel(name: "Blue",
                                                          imgName: "appIcon2",
                                                          type: .blue),
                                             AppIconModel(name: "Green",
                                                          imgName: "appIcon3",
                                                          type: .green),
                                             AppIconModel(name: "Red",
                                                          imgName: "appIcon4",
                                                          type: .red),
                                             AppIconModel(name: "Purple",
                                                          imgName: "appIcon5",
                                                          type: .purple)]
}
