//
//  EpisodeViewModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 16.03.2023.
//

import Foundation

final class EpisodeViewModel: BaseViewModel {

    @Published var episodes: [Episode]?
    var count: Int = 0
    var page: Int = 1

    func getEpisodes(isPagination: Bool) {
        if isPagination {
            page += 1
        }
        let request = EpisodeRequestModel(page: page)
        NetworkManager.shared.sendRequest(request: request,
                                          type: EpisodeResponseModel.self)
        .sink { _ in

        } receiveValue: { [weak self] result in
            guard let self = self else { return }
            if isPagination {
                self.episodes?.append(contentsOf: result.results ?? [])
            } else {
                self.episodes = result.results
                self.count = result.info?.count ?? 0
            }
        }.store(in: &cancelables)
    }

    func searchEpisodes(searchText: String) {
        let request = SearchEpisodesRequestModel(name: searchText)
        NetworkManager.shared.sendRequest(request: request,
                                          type: EpisodeResponseModel.self)
        .sink { _ in

        } receiveValue: { [weak self] result in
            guard let self = self else { return }
            self.episodes = result.results
        }.store(in: &cancelables)
    }
}
