//
//  HomeViewModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 14.03.2023.
//

import Foundation
import Combine

final class HomeViewModel: BaseViewModel {

    @Published var characters: [Character]?
    @Published var episodes: [Episode]?
    @Published var locations: [Location]?

    func getCharacters() {
        let request = CharactersRequestModel(page: 1)
        NetworkManager.shared.sendRequest(request: request,
                                          type: CharactersResponseModel.self)
        .sink { _ in

        } receiveValue: { [weak self] result in
            guard let self = self else { return }
            self.characters = result.results
        }.store(in: &cancelables)
    }

    func getEpisode() {
        let request = EpisodeRequestModel(page: 1)
        NetworkManager.shared.sendRequest(request: request,
                                          type: EpisodeResponseModel.self)
        .sink { _ in

        } receiveValue: { [weak self] result in
            guard let self = self else { return }
            self.episodes = result.results
        }.store(in: &cancelables)
    }

    func getLocation() {
        let request = LocationRequestModel(page: 1)
        NetworkManager.shared.sendRequest(request: request,
                                          type: LocationResponseModel.self)
        .sink { _ in

        } receiveValue: { [weak self] result in
            guard let self = self else { return }
            self.locations = result.results
        }.store(in: &cancelables)
    }
}
