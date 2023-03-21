//
//  DetailViewModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 21.03.2023.
//

import Foundation

enum DetailViewType {
    case character(Int)
    case episode(Int)
    case location(Int)
}

final class DetailViewModel: BaseViewModel {

    var viewType: DetailViewType?
    @Published var character: Character?
    @Published var episode: Episode?
    @Published var location: Location?

    var count: Int? {
        switch viewType {
        case .character:
            return character?.episode?.count
        case .episode:
            return episode?.characters?.count
        case .location:
            return episode?.characters?.count
        default:
            return 0
        }
    }

    func getData() {
        switch viewType {
        case .character(let id):
            self.getCharacterDetail(id: id)
        case .episode(let id):
            self.getEpisodeDetail(id: id)
        case .location(let id):
            self.getLocationDetail(id: id)
        default:
            break
        }
    }

    // MARK: - Character
    private func getCharacterDetail(id: Int) {
        let request = SingleCharacterRequestModel(characterID: id)
        NetworkManager.shared.sendRequest(request: request,
                                          type: Character.self)
        .sink { _ in

        } receiveValue: { [weak self] character in
            guard let self = self else { return }
            self.character = character
        }.store(in: &cancelables)
    }

    // MARK: - Episode
    private func getEpisodeDetail(id: Int) {
        let request = SingleEpisodeRequestModel(episodeID: id)
        NetworkManager.shared.sendRequest(request: request,
                                          type: Episode.self)
        .sink { _ in

        } receiveValue: { [weak self] episode in
            guard let self = self else { return }
            self.episode = episode
        }.store(in: &cancelables)
    }

    // MARK: - Location
    private func getLocationDetail(id: Int) {
        let request = SingleLocationRequestModel(locationID: id)
        NetworkManager.shared.sendRequest(request: request,
                                          type: Location.self)
        .sink { _ in

        } receiveValue: { [weak self] location in
            guard let self = self else { return }
            self.location = location
        }.store(in: &cancelables)
    }
}
