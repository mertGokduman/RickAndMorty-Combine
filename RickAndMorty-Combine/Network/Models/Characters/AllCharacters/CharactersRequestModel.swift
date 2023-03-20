//
//  CharactersRequestModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 14.03.2023.
//

import Foundation

final class CharactersRequestModel: RequestModel {

    var page: Int?
    var characterID: Int?

    override var path: String {
        if let page = page {
            return ServiceConstants.CharacterPath.character + ServiceConstants.QueryPaths.page + String(page)
        } else if let characterID = characterID {
            return ServiceConstants.CharacterPath.character + "/\(characterID)"
        } else {
            return ServiceConstants.CharacterPath.character
        }
    }

    init(page: Int? = nil,
         characterID: Int? = nil) {

        self.page = page
        self.characterID = characterID
    }
}
