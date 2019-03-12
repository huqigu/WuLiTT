//
//  JCProgressHud.swift
//  WuLiTT
//
//  Created by yellow on 2019/3/12.
//  Copyright © 2019 yellow. All rights reserved.
//

import SVProgressHUD
import UIKit

enum HUDType {
    case success
    case error
    case loading
    case info
    case progress
}

class JCProgressHUD: NSObject {
    class func initJCProgressHUD() {
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 14.0))
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
    }

    class func showSuccess(_ status: String) {
        showJCProgressHUD(type: .success, status: status)
    }

    class func showError(_ status: String) {
        showJCProgressHUD(type: .error, status: status)
    }

    class func showLoading(_ status: String) {
        showJCProgressHUD(type: .loading, status: status)
    }

    class func showInfo(_ status: String) {
        showJCProgressHUD(type: .info, status: status)
    }

    class func showProgress(_ status: String, _ progress: CGFloat) {
        showJCProgressHUD(type: .success, status: status, progress: progress)
    }

    class func dismissHUD(_ delay: TimeInterval = 0) {
        SVProgressHUD.dismiss(withDelay: delay)
    }
}

extension JCProgressHUD {
    class func showJCProgressHUD(type: HUDType, status: String, progress: CGFloat = 0) {
        switch type {
        case .success:
            SVProgressHUD.showSuccess(withStatus: status)
        case .error:
            SVProgressHUD.showError(withStatus: status)
        case .loading:
            SVProgressHUD.show(withStatus: status)
        case .info:
            SVProgressHUD.showInfo(withStatus: status)
        case .progress:
            SVProgressHUD.showProgress(Float(progress), status: status)
        }
    }
}
