//
//  SingleCharacterRequestModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 21.03.2023.
//

import Foundation

final class SingleCharacterRequestModel: RequestModel {

    var characterID: Int?

    override var path: String {
        if let characterID = characterID {
            return ServiceConstants.CharacterPath.character + "/\(characterID)"
        } else {
            return ServiceConstants.CharacterPath.character
        }
    }

    init(characterID: Int?) {

        self.characterID = characterID
    }
}
