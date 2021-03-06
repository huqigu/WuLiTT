//
//  Common.swift
//  唔哩头条
//
//  Created by yellow on 2019/1/2.
//  Copyright © 2019 yellow. All rights reserved.
//

import RxSwift
import UIKit

class CommonTool {
    static var isFullScreen: Bool {
        if #available(iOS 11, *) {
            guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
                return false
            }

            if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
                return true
            }
        }
        return false
    }

    static var navigationBarHeight: CGFloat {
        // return UIApplication.shared.statusBarFrame.height == 44 ? 88 : 64
        return isFullScreen ? 88 : 64
    }

    static var bottomSafeHeight: CGFloat {
        // return UIApplication.shared.statusBarFrame.height == 44 ? 34 : 0
        return isFullScreen ? 34 : 0
    }
}

let disposeBag = DisposeBag()
