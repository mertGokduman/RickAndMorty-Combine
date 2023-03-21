//
//  SingleEpisodeRequestModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 21.03.2023.
//

import Foundation

final class SingleEpisodeRequestModel: RequestModel {

    var episodeID: Int?

    override var path: String {
        if let episodeID = episodeID {
            return ServiceConstants.EpisodePaths.episode + "/\(episodeID)"
        } else {
            return ServiceConstants.EpisodePaths.episode
        }
    }

    init(episodeID: Int?) {
        self.episodeID = episodeID
    }
}
