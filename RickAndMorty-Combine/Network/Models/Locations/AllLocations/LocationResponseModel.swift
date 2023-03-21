//
//  LocationResponseModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 14.03.2023.
//

import Foundation

struct LocationResponseModel: Codable {

    var info: Info?
    var results: [Location]?

    enum CodingKeys: String, CodingKey {
        case info, results
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        info = try? values.decode(Info.self, forKey: .info)
        results = try? values.decode([Location].self, forKey: .results)
    }
}

struct Location: Codable {

    var id: Int?
    var name: String?
    var type: String?
    var dimension: String?
    var characters: [String]?

    enum CodingKeys: String, CodingKey {
        case id, name, type, dimension, characters
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decode(Int.self, forKey: .id)
        name = try? values.decode(String.self, forKey: .name)
        type = try? values.decode(String.self, forKey: .type)
        dimension = try? values.decode(String.self, forKey: .dimension)
        characters = try? values.decode([String].self, forKey: .characters)
    }
}
