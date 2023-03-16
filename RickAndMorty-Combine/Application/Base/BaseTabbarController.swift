//
//  BaseTabbarController.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 14.03.2023.
//

import UIKit

protocol TabBarItemable {
    var tabItem: TabItem { get }
}

class TabItem {
    var title: String = ""
    var image: UIImage?
    var selectedImage: UIImage?
    var isEnable: Bool?

    init(title: String,
         image: UIImage?,
         selectedImage: UIImage?,
         isEnable: Bool?) {
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
        self.isEnable = isEnable
    }
}

class BaseTabbarController: UITabBarController {

    override var selectedIndex: Int {
        didSet {
            tabChangedTo(selectedIndex: selectedIndex)
        }
    }

    override var selectedViewController: UIViewController? {
        didSet {
            tabChangedTo(selectedIndex: selectedIndex)
        }
    }

    lazy var btnHome: UIButton = {
        let width: CGFloat?
        if getScreenSize().height < 800 {
            width = 55
        } else if getScreenSize().height < 850 {
            width = 60
        } else if getScreenSize().height < 900 {
            width = 65
        } else {
            width = 70
        }
        let btnAdd = UIButton()
        btnAdd.frame = CGRect(x: 0, y: 0, width: width!, height: width!)
        btnAdd.center = CGPoint(x: view.frame.width / 2, y: view.frame.maxY - self.tabBar.frame.height - (width! / 2.75))
        btnAdd.setImage(UIImage(named: "homeButton"), for: .normal)
        btnAdd.layer.shadowColor = UIColor.black.cgColor
        btnAdd.layer.shadowRadius = 5
        btnAdd.layer.shadowOpacity = 0.3
        btnAdd.layer.shadowOffset = CGSize(width: 0, height: 2)
        return btnAdd
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(tabChildren: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        var viewControllers: [UIViewController] = []
        for tabChild in tabChildren {
            guard let tabItem = getTabBarItemable(from: tabChild)?.tabItem else { return }
            tabChild.tabBarItem.image = tabItem.image?.withRenderingMode(.alwaysOriginal)
            tabChild.tabBarItem.selectedImage = tabItem.selectedImage?.withRenderingMode(.alwaysOriginal)
            tabChild.tabBarItem.isAccessibilityElement = true
            tabChild.tabBarItem.title = tabItem.title
            tabChild.tabBarItem.isEnabled = tabItem.isEnable~
            viewControllers.append(tabChild)
        }
        self.viewControllers = viewControllers
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.selectedIndex = 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        applyStyles()
    }

    private func getTabBarItemable(from viewController: UIViewController) -> TabBarItemable? {
        if let tabBarItemable = viewController as? TabBarItemable {
            return tabBarItemable
        } else if let tabBarItemable = (viewController as? UINavigationController)?.viewControllers.first as? TabBarItemable {
            return tabBarItemable
        }
        return nil
    }

    // MARK: - Tabbar UI
    private func applyStyles() {
        selectedIndex = 1
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .red
        let tabbarItemAppearance = UITabBarItemAppearance()
        appearance.shadowColor = .black
        tabbarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                                                           NSAttributedString.Key.foregroundColor: UIColor.white]
        tabbarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                                                             NSAttributedString.Key.foregroundColor: UIColor.red]
        tabbarItemAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        tabbarItemAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        appearance.stackedLayoutAppearance = tabbarItemAppearance
        self.tabBarItem.image?.withAlignmentRectInsets(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        self.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            self.tabBarItem.image?.withAlignmentRectInsets(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
            self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
            self.tabBar.itemPositioning = .centered
        }
    }

    // MARK: - ADD MIDDLE BUTTON
    private func addAddButton() {
        view.addSubview(btnHome)
        view.bringSubviewToFront(btnHome)
        btnHome.layer.zPosition = 1
        btnHome.addTarget(self,
                         action: #selector(btnAddTapped),
                         for: .touchUpInside)
    }

    @objc private func btnAddTapped() {
        self.selectedIndex = 1
    }

    func tabChangedTo(selectedIndex: Int) {
        if selectedIndex == 1 {
            btnHome.setImage(UIImage(named: "homeButton2"),
                            for: .normal)
        } else {
            btnHome.setImage(UIImage(named: "homeButton"),
                            for: .normal)
        }
    }
}
