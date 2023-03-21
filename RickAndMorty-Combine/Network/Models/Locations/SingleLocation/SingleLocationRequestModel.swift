//
//  SingleLocationRequestMolde.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 21.03.2023.
//

import Foundation

final class SingleLocationRequestModel: RequestModel {

    var locationID: Int?

    override var path: String {
        if let locationID = locationID {
            return ServiceConstants.LocationPaths.location + "/\(locationID)"
        } else {
            return ServiceConstants.LocationPaths.location
        }
    }

    init(locationID: Int?) {

        self.locationID = locationID
    }
}
