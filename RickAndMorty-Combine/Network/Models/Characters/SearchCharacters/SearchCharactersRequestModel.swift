//
//  SearchCharactersRequestModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 20.03.2023.
//

import Foundation

final class SearchCharactersRequestModel: RequestModel {

    var name: String?

    override var path: String {
        if let name = name {
            return ServiceConstants.CharacterPath.character + ServiceConstants.QueryPaths.name + name
        } else {
            return ServiceConstants.CharacterPath.character
        }   
    }

    init(name: String) {

        self.name = name
    }
}
