//
//  BaseVC.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 14.03.2023.
//

import UIKit
import Combine
import Lottie

class BaseVC<VM>: UIViewController where VM: BaseViewModel  {

    lazy var viewModel: VM = VM()
    var cancelables = Set<AnyCancellable>()

    private var lottieanimation: LottieAnimationView?
    private lazy var animationView: UIView = {
        let view = UIView()
        return view
    }()

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

// MARK: - LOTTIE ANIMATION
extension BaseVC {

    private func setupAnimation() {
        lottieanimation = LottieAnimationView(name: "loading")
        lottieanimation?.loopMode = .loop
        lottieanimation?.contentMode = .scaleAspectFit

        if let lottieanimation = lottieanimation {
            animationView.addSubview(lottieanimation)
            lottieanimation.frame = CGRect(x: 0,
                                           y: 0,
                                           width: animationView.frame.width / 2,
                                           height: animationView.frame.height / 2)
            lottieanimation.center = animationView.center
        }
    }

    func startLoading() {
        DispatchQueue.main.async {
            if let navBar = self.navigationController {
                navBar.view.addSubview(self.animationView)
            } else {
                self.view.addSubview(self.animationView)
            }
            self.animationView.frame = CGRect(x: 0,
                                              y: 0,
                                              width: self.view.frame.width,
                                              height: self.view.frame.height)
            self.animationView.backgroundColor = UIColor(named: "BGColor")?.withAlphaComponent(0.95)
            self.view.bringSubviewToFront(self.animationView)
            self.setupAnimation()
            self.lottieanimation?.play()
            self.view.isUserInteractionEnabled = false
        }
    }

    func stopLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.lottieanimation?.stop()
            self.lottieanimation?.removeFromSuperview()
            self.lottieanimation = nil
            self.animationView.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
        }
    }
}
