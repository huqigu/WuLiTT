//
//  JCNavigationController.swift
//  WuLiTT
//
//  Created by yellow on 2019/2/13.
//  Copyright © 2019 yellow. All rights reserved.
//

import UIKit

class JCNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func pushViewController(_ viewController: UIViewController, animated _: Bool) {
        if childViewControllers.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
}
