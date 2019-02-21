//
//  JCTabBarController.swift
//  WuLiTT
//
//  Created by yellow on 2019/2/13.
//  Copyright © 2019 yellow. All rights reserved.
//

import UIKit

class JCTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addChildViewControllers()

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.gray], for: .normal)

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: yellowColor], for: .selected)
    }
}

// MARK: - addChildViewController

extension JCTabBarController {
    func addChildViewControllers() {
        let vc1 = JCHomeViewController()

        let vc2 = JCMomentsViewController()

        let vc3 = JCTaskViewController()

        let vc4 = JCMineViewController()

        addChildViewController(createChildViewController(vc: vc1, title: "首页", imageName: "ic_tab_home_29x29_", selectedImageName: "ic_tab_chosenhome_29x29_"))
        addChildViewController(createChildViewController(vc: vc2, title: "喵圈", imageName: "ic_tab_play_29x29_", selectedImageName: "ic_tab_chosenplay_29x29_"))
        addChildViewController(createChildViewController(vc: vc3, title: "任务", imageName: "ic_tab_message_29x29_", selectedImageName: "ic_tab_chosenMessage_29x29_"))
        addChildViewController(createChildViewController(vc: vc4, title: "我的", imageName: "ic_tab_mine_29x29_", selectedImageName: "ic_tab_chosenmine_29x29_"))
    }

    func createChildViewController(vc: JCViewController, title: String, imageName: String, selectedImageName: String) -> JCNavigationController {
        vc.title = title

        vc.tabBarItem.image = UIImage(named: imageName)

        vc.tabBarItem.selectedImage = UIImage(named: selectedImageName)

        return JCNavigationController(rootViewController: vc)
    }
}
