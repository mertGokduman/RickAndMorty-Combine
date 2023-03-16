//
//  UICollectionView + Extensions.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 14.03.2023.
//

import Foundation
import UIKit

extension UICollectionView {

    func registerNib<T>(withClassAndIdentifier: T.Type) {
        let classAndIdentifier = String(describing: withClassAndIdentifier.self)
        let nib = UINib.init(nibName: classAndIdentifier,
                             bundle: nil)
        self.register(nib,
                      forCellWithReuseIdentifier: classAndIdentifier)
    }

    func registerNibs<T>(withClassesAndIdentifiers: [T.Type]) {
        withClassesAndIdentifiers.forEach { registerNib(withClassAndIdentifier: $0) }
    }

    func dequeueCell<T: UICollectionViewCell>(_: T.Type,
                                              forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }

        return cell
    }

    func dequeueReusableView<T: UICollectionReusableView>(_: T.Type,
                                                          kind: String,
                                                          indexPath: IndexPath) -> T {
        guard let reusableView = dequeueReusableSupplementaryView(ofKind: kind,
                                                                  withReuseIdentifier: T.defaultReuseIdentifier,
                                                                  for: indexPath) as? T else {
            fatalError("Could not dequeue reusable view with identifier: \(T.defaultReuseIdentifier)")
        }

        return reusableView
    }
}
