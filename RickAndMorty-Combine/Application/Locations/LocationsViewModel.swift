//
//  LocationsViewModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 16.03.2023.
//

import Foundation
import Combine

final class LocationsViewModel: BaseViewModel {

    @Published var locations: [Location]?
    var count: Int = 0
    var page: Int = 1

    func getLocations(isPagination: Bool) {
        if isPagination {
            page += 1
        }
        let request = LocationRequestModel(page: page)
        NetworkManager.shared.sendRequest(request: request,
                                          type: LocationResponseModel.self)
        .sink { _ in

        } receiveValue: { [weak self] result in
            guard let self = self else { return }
            if isPagination {
                self.locations?.append(contentsOf: result.results ?? [])
            } else {
                self.locations = result.results
                self.count = result.info?.count ?? 0
            }
        }.store(in: &cancelables)
    }

    func searchlocations(searchText: String) {
        let request = SearchLocationRequestModel(name: searchText)
        NetworkManager.shared.sendRequest(request: request,
                                          type: LocationResponseModel.self)
        .sink { _ in

        } receiveValue: { [weak self] result in
            guard let self = self else { return }
            self.locations = result.results
        }.store(in: &cancelables)
    }
}
