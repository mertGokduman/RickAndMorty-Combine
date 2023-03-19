//
//  LocationsViewController.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 16.03.2023.
//

import UIKit

class LocationsViewController: BaseVC<BaseViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BGColor")
        self.navigationController?.title = "Locations"
    }
}

// MARK: - TabBarItemable
extension LocationsViewController: TabBarItemable {
    var tabItem: TabItem {
        return TabItem(title: "Locations",
                       image: UIImage(systemName: "location.square")?.withTintColor(UIColor(named: "LabelColor") ?? .black),
                       selectedImage: UIImage(systemName: "location.square.fill")?.withTintColor(UIColor(named: "TabbarSelectedColor") ?? .selectedTabbarColor),
                       isEnable: true)
    }
}
