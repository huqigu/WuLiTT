//
//  JCViewController.swift
//  WuLiTT
//
//  Created by yellow on 2019/2/13.
//  Copyright © 2019 yellow. All rights reserved.
//

import UIKit

class JCViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false

        //   test spacecommander ----------

//        hidesBottomBarWhenPushed = true

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        for subViews in (tabBarController?.tabBar.subviews)! {
            if subViews.isKind(of: NSClassFromString("UITabBarButton")!) {
                subViews.removeFromSuperview()
            }

            if subViews.isKind(of: NSClassFromString("_UIBarBackground")!) {
                subViews.isHidden = true
            }
        }
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
