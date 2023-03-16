//
//  NetworkManager.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 14.03.2023.
//

import Foundation
import Combine

class NetworkManager {

    static let shared = NetworkManager()

    public var baseURL: String = "https://rickandmortyapi.com/api/"

    public var responseCode: Int = 0

    func sendRequest<T: Codable>(request: RequestModel, type: T.Type) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request.urlRequest())
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap ({ data, response in
                if let httpResponse = response as? HTTPURLResponse {
                    self.responseCode = httpResponse.statusCode
                    print("response code: \(self.responseCode)")
                }

                return data
            })
            .receive(on: DispatchQueue.main)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                print("Error here: \(error.localizedDescription)")
                return error
            }
            .eraseToAnyPublisher()
    }
}
