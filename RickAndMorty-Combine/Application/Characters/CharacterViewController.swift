//
//  CharacterViewController.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 16.03.2023.
//

import UIKit

class CharacterViewController: BaseVC<CharacterViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BGColor")
        self.navigationController?.title = "Characters"
    }
}

// MARK: - TabBarItemable
extension CharacterViewController: TabBarItemable {
    var tabItem: TabItem {
        return TabItem(title: "Characters",
                       image: UIImage(systemName: "person.3")?.withTintColor(UIColor(named: "LabelColor") ?? .black),
                       selectedImage: UIImage(systemName: "person.3.fill")?.withTintColor(UIColor(named: "TabbarSelectedColor") ?? .selectedTabbarColor),
                       isEnable: true)
    }
}
