//
//  EpisodeResponseModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 14.03.2023.
//

import Foundation

struct EpisodeResponseModel: Codable {

    var info: Info?
    var results: [Episode]?

    enum CodingKeys: String, CodingKey {
        case info, results
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        info = try? values.decode(Info.self, forKey: .info)
        results = try? values.decode([Episode].self, forKey: .results)
    }
}

struct Episode: Codable {

    var id: Int?
    var name: String?
    var airDate: String?
    var episode: String?
    var characters: [String]?

    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters
        case airDate = "air_date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decode(Int.self, forKey: .id)
        name = try? values.decode(String.self, forKey: .name)
        airDate = try? values.decode(String.self, forKey: .airDate)
        episode = try? values.decode(String.self, forKey: .episode)
        characters = try? values.decode([String].self, forKey: .characters)
    }
}
