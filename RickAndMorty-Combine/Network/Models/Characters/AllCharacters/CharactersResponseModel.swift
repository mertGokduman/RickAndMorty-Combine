//
//  CharactersResponseModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 14.03.2023.
//

import Foundation

struct CharactersResponseModel: Codable {

    var info: Info?
    var results: [Character]?

    enum CodingKeys: String, CodingKey {
        case info, results
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        info = try? values.decode(Info.self, forKey: .info)
        results = try? values.decode([Character].self, forKey: .results)
    }
}

struct Info: Codable {

    var count: Int?
    var pages: Int?

    enum CodingKeys: String, CodingKey {
        case count, pages
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try? values.decode(Int.self, forKey: .count)
        pages = try? values.decode(Int.self, forKey: .pages)
    }
}

struct Character: Codable {

    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var gender: String?
    var origin, location: CharacterInfos?
    var image: String?
    var episode: [String]?

    enum CodingKeys: String, CodingKey {
        case id, name, status, species
        case gender, origin, location, image
        case episode
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decode(Int.self, forKey: .id)
        name = try? values.decode(String.self, forKey: .name)
        status = try? values.decode(String.self, forKey: .status)
        species = try? values.decode(String.self, forKey: .species)
        gender = try? values.decode(String.self, forKey: .gender)
        origin = try? values.decode(CharacterInfos.self, forKey: .origin)
        location = try? values.decode(CharacterInfos.self, forKey: .location)
        image = try? values.decode(String.self, forKey: .image)
        episode = try? values.decode([String].self, forKey: .episode)
    }
}

struct CharacterInfos: Codable {

    var name: String?

    enum CodingKeys: String, CodingKey {
        case name
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try? values.decode(String.self, forKey: .name)
    }
}
