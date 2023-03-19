//
//  UITableView + Extension.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 19.03.2023.
//

import Foundation
import UIKit

extension UITableView {

    func registerNib<T>(withClassAndIdentifier: T.Type) {
        let classAndIdentifier = String(describing: withClassAndIdentifier.self)
        let nib = UINib.init(nibName: classAndIdentifier,
                             bundle: nil)
        self.register(nib,
                      forCellReuseIdentifier: classAndIdentifier)
    }

    func registerNibs<T>(withClassesAndIdentifiers: [T.Type]) {
        withClassesAndIdentifiers.forEach { registerNib(withClassAndIdentifier: $0) }
    }

    func dequeueCell<T: UITableViewCell>(_: T.Type,
                                              forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}
