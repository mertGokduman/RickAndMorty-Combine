//
//  CharacterViewModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 16.03.2023.
//

import Foundation
import Combine

final class CharacterViewModel: BaseViewModel {

    @Published var characters: [Character]?
    var count: Int = 0
    var page: Int = 1

    func getCharacters(isPagination: Bool) {
        if isPagination {
            page += 1
        }
        let request = CharactersRequestModel(page: page)
        NetworkManager.shared.sendRequest(request: request,
                                          type: CharactersResponseModel.self)
        .sink { _ in

        } receiveValue: { [weak self] result in
            guard let self = self else { return }
            if isPagination {
                self.characters?.append(contentsOf: result.results~)
            } else {
                self.characters = result.results
                self.count = result.info?.count ?? 0
            }
        }.store(in: &cancelables)
    }

    func searchCharacter(searchText: String) {
        let request = SearchCharactersRequestModel(name: searchText)
        NetworkManager.shared.sendRequest(request: request,
                                          type: CharactersResponseModel.self)
        .sink { _ in

        } receiveValue: { [weak self] result in
            guard let self = self else { return }
            self.characters = result.results
        }.store(in: &cancelables)
    }
}
