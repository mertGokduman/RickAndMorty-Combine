//
//  SearchEpisodesRequestModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 20.03.2023.
//

import Foundation

final class SearchEpisodesRequestModel: RequestModel {

    var name: String?

    override var path: String {
        if let name = name {
            return ServiceConstants.EpisodePaths.episode + ServiceConstants.QueryPaths.name + name
        } else {
            return ServiceConstants.EpisodePaths.episode
        }
    }

    init(name: String) {

        self.name = name
    }
}
