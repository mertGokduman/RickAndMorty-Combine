//
//  EpisodesViewController.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 16.03.2023.
//

import UIKit

class EpisodesViewController: BaseVC<EpisodeViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BGColor")
        self.navigationController?.title = "Episodes"
    }
}

// MARK: - TabBarItemable
extension EpisodesViewController: TabBarItemable {
    var tabItem: TabItem {
        return TabItem(title: "Episodes",
                       image: UIImage(systemName: "popcorn")?.withTintColor(UIColor(named: "LabelColor") ?? .black),
                       selectedImage: UIImage(systemName: "popcorn.fill")?.withTintColor(UIColor(named: "TabbarSelectedColor") ?? .selectedTabbarColor),
                       isEnable: true)
    }
}
