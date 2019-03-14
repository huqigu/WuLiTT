//
//  JCRequestPlugin.swift
//  WuLiTT
//
//  Created by yellow on 2019/3/12.
//  Copyright © 2019 yellow. All rights reserved.
//

import Foundation
import Moya
import NVActivityIndicatorView
import Result

let netWorkActivityPlugin = NetworkActivityPlugin { (_ change: NetworkActivityChangeType, _: TargetType) -> Void in

    switch change {
    case .ended:
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    case .began:
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(type: .circleStrokeSpin), nil)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
}

public final class JCRequestPlugin: PluginType {
    /// Called immediately before a request is sent over the network (or stubbed).
    public func willSend(_: RequestType, target _: TargetType) {}

    public func didReceive(_ result: Result<Response, MoyaError>, target _: TargetType) {
        switch result {
        case let .success(response):
//            let json: Dictionary? = try! JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as! [String: Any]
//            print(json as Any)
            JCProgressHUD.showSuccess("加载成功")
        case .failure:
            JCProgressHUD.showError("加载失败")
            break
        }
    }
}
