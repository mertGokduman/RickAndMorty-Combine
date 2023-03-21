//
//  EpisodeRequestModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 14.03.2023.
//

import Foundation

final class EpisodeRequestModel: RequestModel {

    var page: Int?

    override var path: String {
        if let page = page {
            return ServiceConstants.EpisodePaths.episode + ServiceConstants.QueryPaths.page + String(page)
        } else {
            return ServiceConstants.EpisodePaths.episode
        }
    }

    init(page: Int? = nil) {

        self.page = page
    }
}
