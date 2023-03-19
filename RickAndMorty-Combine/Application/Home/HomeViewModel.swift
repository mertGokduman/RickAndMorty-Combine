//
//  HomeViewModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 14.03.2023.
//

import Foundation
import Combine
import UIKit

final class HomeViewModel: BaseViewModel {

    @Published var profilePicture: UIImage?
    @Published var name: String?
    @Published var characters: [Character]?
    @Published var episodes: [Episode]?
    @Published var locations: [Location]?

    func getDatas() {
        self.setupProfilePicture()
        self.getUserFirstName()
        self.getCharacters()
        self.getEpisode()
        self.getLocation()
    }

    private func setupProfilePicture() {
        guard let data = UserDefaults.standard.data(forKey: AppConstants.UserDefaultsConstants.profilePicture) else { return }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        let image = UIImage(data: decoded)
        self.profilePicture = image
    }

    private func getUserFirstName() {
        if let name = UserDefaults.standard.string(forKey: AppConstants.UserDefaultsConstants.firstname) {
            self.name = name
        }
    }

    private func getCharacters() {
        let request = CharactersRequestModel(page: 1)
        NetworkManager.shared.sendRequest(request: request,
                                          type: CharactersResponseModel.self)
        .sink { _ in

        } receiveValue: { [weak self] result in
            guard let self = self else { return }
            self.characters = result.results
        }.store(in: &cancelables)
    }

    private func getEpisode() {
        let request = EpisodeRequestModel(page: 1)
        NetworkManager.shared.sendRequest(request: request,
                                          type: EpisodeResponseModel.self)
        .sink { _ in

        } receiveValue: { [weak self] result in
            guard let self = self else { return }
            self.episodes = result.results
        }.store(in: &cancelables)
    }

    private func getLocation() {
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
