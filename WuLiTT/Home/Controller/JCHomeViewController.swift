//
//  JCHomeViewController.swift
//  唔哩头条
//
//  Created by yellow on 2019/1/2.
//  Copyright © 2019 yellow. All rights reserved.
//

import Alamofire
import JCEndPoint
import SwiftyJSON
import UIKit

class JCHomeViewController: JCViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true

        let navigationBar = HomeNavigationView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kNavigationBarHeight))

        view.addSubview(navigationBar)

        let parameters: Dictionary = ["channelId": "30", "cursor": "\(getCurrentTimes())", "slipType": "UP"]

        JCEndPoint().get("message/list", parameters: parameters, needLoading: true, logEnable: true) { _, _, _ in
        }
    }

    // 获取时间戳
    func getCurrentTimes() -> Int {
        // 获取当前时间
        let now = NSDate()

        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        print("当前日期时间：\(dformatter.string(from: now as Date))")

        // 当前时间的时间戳
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        return Int(timeInterval)
    }
}
