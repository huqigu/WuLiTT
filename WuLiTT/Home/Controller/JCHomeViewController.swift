//
//  JCHomeViewController.swift
//  唔哩头条
//
//  Created by yellow on 2019/1/2.
//  Copyright © 2019 yellow. All rights reserved.
//

import Moya
import RxSwift
import UIKit

class JCHomeViewController: JCViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true

        let navigationBar = HomeNavigationView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kNavigationBarHeight))

        view.addSubview(navigationBar)

//        let parameters: Dictionary = ["channelId": "30", "cursor": "\(getCurrentTimes())", "slipType": "UP"]

        MoyaProvider<APIManager>(plugins: [JCRequestPlugin(), netWorkActivityPlugin]).request(.getHomeList(channelId: 30, timestamp: getCurrentTimes(), slipType: "UP")) { result in

            print("moyaRequest == " + result.result.debugDescription)
        }
    }

    // 获取时间戳
    func getCurrentTimes() -> Int {
        // 获取当前时间
        let now = NSDate()

        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"

        // 当前时间的时间戳
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        return Int(timeInterval)
    }
}
