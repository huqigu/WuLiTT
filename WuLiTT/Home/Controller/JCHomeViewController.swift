//
//  JCHomeViewController.swift
//  唔哩头条
//
//  Created by yellow on 2019/1/2.
//  Copyright © 2019 yellow. All rights reserved.
//

import UIKit

class JCHomeViewController: JCViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        let navigationBar = HomeNavigationView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kNavigationBarHeight))
        
        self.view.addSubview(navigationBar)
    }

    

}
