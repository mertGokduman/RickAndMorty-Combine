//
//  LocationRequestModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 14.03.2023.
//

import Foundation

final class LocationRequestModel: RequestModel {

    var page: Int?

    override var path: String {
        if let page = page {
            return ServiceConstants.LocationPaths.location + ServiceConstants.QueryPaths.page + String(page)
        } else {
            return ServiceConstants.LocationPaths.location
        }
    }

    init(page: Int? = nil) {

        self.page = page
    }
}
