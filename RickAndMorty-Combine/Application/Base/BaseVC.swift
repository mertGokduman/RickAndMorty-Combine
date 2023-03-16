//
//  BaseVC.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 14.03.2023.
//

import UIKit
import Combine

class BaseVC<VM>: UIViewController where VM: BaseViewModel  {

    lazy var viewModel: VM = VM()

    var cancelables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func btnAddHide() {
        if let tabbarController = self.tabBarController as? BaseTabbarController {
            tabbarController.btnHome.isHidden = true
        }
    }

    func btnAddShow() {
        if let tabbarController = self.tabBarController as? BaseTabbarController {
            tabbarController.btnHome.isHidden = false
        }
    }
}
