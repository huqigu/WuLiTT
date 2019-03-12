//
//  Configs.swift
//  WuLiTT
//
//  Created by yellow on 2019/3/12.
//  Copyright © 2019 yellow. All rights reserved.
//

import UIKit

let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height

let kNavigationBarHeight = CommonTool.navigationBarHeight
let kBottomSafeHeight = CommonTool.bottomSafeHeight

struct Configs {
    struct Network {
        static let baseUrl = "https://api.5wuli.com/v2/"
    }

    struct App {
        static let yellowColor = UIColor(red: 254.0 / 255.0, green: 213.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0)
    }
}
