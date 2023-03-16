//
//  BaseViewModel.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 14.03.2023.
//

import Foundation
import Combine

class BaseViewModel {

    var cancelables = Set<AnyCancellable>()

    required init() {
        // Intentionally unimplemented
    }
}
