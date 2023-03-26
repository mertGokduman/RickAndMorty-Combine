//
//  DetailViewModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 21.03.2023.
//

import Foundation
import Combine

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

    var episodeArray: [String] = []
    var characters: [String] = []
    @Published var characterEpisodes: [String]?
    @Published var charactersNames: [String]?

    var count: Int? {
        switch viewType {
        case .character:
            return character?.episode?.count
        case .episode:
            return episode?.characters?.count
        case .location:
            return location?.residents?.count
        default:
            return 0
        }
    }

    func getData() {
        switch viewType {
        case .character(let id):
            self.getCharacterDetail(id: id,
                                    forCharacterOnly: false)
        case .episode(let id):
            self.getEpisodeDetail(id: id,
                                  forCharacterEpisodes: false)
        case .location(let id):
            self.getLocationDetail(id: id)
        default:
            break
        }
    }

    // MARK: - Character
    private func getCharacterDetail(id: Int,
                                    forCharacterOnly: Bool) {
        let request = SingleCharacterRequestModel(characterID: id)
        NetworkManager.shared.sendRequest(request: request,
                                          type: Character.self)
        .sink { _ in

        } receiveValue: { [weak self] character in
            guard let self = self else { return }
            if forCharacterOnly {
                self.characters.append(character.name~)
                self.charactersNames = self.characters
            } else {
                self.character = character
            }
        }.store(in: &cancelables)
    }

    func getCharacterEpispdes(character: Character?) {
        if let episodes = character?.episode {
            for item in episodes {
                let id = Int.parse(from: item)
                self.getEpisodeDetail(id: id~,
                                      forCharacterEpisodes: true)
            }
        }
    }

    // MARK: - Episode
    private func getEpisodeDetail(id: Int,
                                  forCharacterEpisodes: Bool) {
        let request = SingleEpisodeRequestModel(episodeID: id)
        NetworkManager.shared.sendRequest(request: request,
                                          type: Episode.self)
        .sink { _ in
        } receiveValue: { [weak self] episode in
            guard let self = self else { return }
            if forCharacterEpisodes {
                self.episodeArray.append(episode.name~ + "-" + episode.episode~)
                self.characterEpisodes = self.episodeArray
            } else {
                self.episode = episode
            }
        }.store(in: &cancelables)
    }

    func getEpisodeCharacters(episode: Episode?) {
        if let characters = episode?.characters {
            for item in characters {
                let id = Int.parse(from: item)
                self.getCharacterDetail(id: id~,
                                        forCharacterOnly: true)
            }
        }
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

    func getLocationResidents(location: Location?) {
        if let characters = location?.residents {
            for item in characters {
                let id = Int.parse(from: item)
                self.getCharacterDetail(id: id~,
                                        forCharacterOnly: true)
            }
        }
    }
}
