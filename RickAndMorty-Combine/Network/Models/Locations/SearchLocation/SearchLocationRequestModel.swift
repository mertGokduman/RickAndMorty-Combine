//
//  SearchLocationRequestModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 20.03.2023.
//

import Foundation

final class SearchLocationRequestModel: RequestModel {

    var name: String?

    override var path: String {
        if let name = name {
            return ServiceConstants.LocationPaths.location + ServiceConstants.QueryPaths.name + name
        } else {
            return ServiceConstants.LocationPaths.location
        }
    }

    init(name: String) {

        self.name = name
    }
}
