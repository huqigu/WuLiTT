//
//  Common.swift
//  唔哩头条
//
//  Created by yellow on 2019/1/2.
//  Copyright © 2019 yellow. All rights reserved.
//

import UIKit
import RxSwift

class CommonTool {
    
    static var isFullScreen: Bool {
        if #available(iOS 11, *) {
            guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
                return false
            }
            
            if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
                print(unwrapedWindow.safeAreaInsets)
                return true
            }
        }
        return false
    }
    
    
    static var navigationBarHeight: CGFloat {
        //return UIApplication.shared.statusBarFrame.height == 44 ? 88 : 64
        return isFullScreen ? 88 : 64
    }
    
    static var bottomSafeHeight: CGFloat {
        //return UIApplication.shared.statusBarFrame.height == 44 ? 34 : 0
        return isFullScreen ? 34 : 0
    }
    
}


let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height

let kNavigationBarHeight = CommonTool.navigationBarHeight
let kBottomSafeHeight = CommonTool.bottomSafeHeight

let yellowColor = UIColor(red: 254.0/255.0, green: 213.0/255.0, blue: 72.0/255.0, alpha: 1.0)

let disposeBag = DisposeBag()
