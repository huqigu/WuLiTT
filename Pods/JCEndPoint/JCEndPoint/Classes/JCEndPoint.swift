//
//  JCEndPoint.swift
//  JCEndPoint_Example
//
//  Created by yellow on 2019/2/22.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Alamofire
import NVActivityIndicatorView
import SwiftyJSON
import UIKit

// 请求响应状态
//
// - success: 响应成功
// - unusual: 响应异常
// - failure: 请求错误
public enum ResponseStatus: Int {
    case success = 0
    case unusual = 1
    case failure = 2
}

/// 网络请求回调闭包 status:响应状态 result:JSON tipString:提示信息
public typealias JCNetworkFinished = (_ status: ResponseStatus, _ result: JSON?, _ tipString: String?) -> Void

open class JCEndPoint: NSObject {
    var logEnable = false

    var baseParams: Dictionary<String, Any> = Dictionary()

    var baseHeader: Dictionary<String, String> = Dictionary()

    var baseUrl: String = ""

    // loading样式
    let activityData = ActivityData(type: .circleStrokeSpin)

    public static let sharedInstance = JCEndPoint()

    public func setBaseParams(baseParams: Dictionary<String, Any>) {
        JCEndPoint.sharedInstance.baseParams = baseParams
    }

    func getBaseParams() -> Dictionary<String, Any> {
        return JCEndPoint.sharedInstance.baseParams
    }

    public func setBaseHeader(baseHeader: Dictionary<String, String>) {
        JCEndPoint.sharedInstance.baseHeader = baseHeader
    }

    func getBaseHeader() -> Dictionary<String, String> {
        return JCEndPoint.sharedInstance.baseHeader
    }

    public func setBaseUrl(baseUrl: String) {
        JCEndPoint.sharedInstance.baseUrl = baseUrl
    }

    func getBaseUrl() -> String {
        return JCEndPoint.sharedInstance.baseUrl
    }
}

// MARK: - 基础请求方法

extension JCEndPoint {
    /**
     GET请求
     - parameter URLString:  urlString
     - parameter parameters: 参数
     - parameter finished:   完成回调
     */
    public func get(_ APIString: String, parameters: [String: Any]?, needLoading: Bool = false, logEnable: Bool = false, finished: @escaping JCNetworkFinished) {
        self.logEnable = logEnable

        if self.logEnable {
            print("JCRequest ------ \r\n  🚀 URL : \(getBaseUrl() + APIString) \r\n  🚀 Method : get \r\n  🚀 Body --- : \r\n \(getJSONStringFromDictionary(dictionary: parameters)) \r\n")
        }

        if needLoading {
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
        }

        Alamofire.request(getBaseUrl() + APIString, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: getBaseHeader()).responseJSON { response in
            self.handle(response: response, needLoading: needLoading, finished: finished)
        }
    }

    /**
     POST请求
     - parameter URLString:  urlString
     - parameter parameters: 参数
     - parameter finished:   完成回调
     */
    public func post(_ APIString: String, parameters: [String: Any]?, needLoading: Bool = false, finished: @escaping JCNetworkFinished) {
        // MARK: Todo   needLoading ：弹出loading

        if logEnable {
            print("JCRequest ------ \r\n  🚀 URL : \(getBaseUrl() + APIString) \r\n  🚀 Method : get \r\n  🚀 Body --- : \r\n \(getJSONStringFromDictionary(dictionary: parameters)) \r\n")
        }

        if needLoading {
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
        }

        Alamofire.request(getBaseUrl() + APIString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: getBaseHeader()).responseJSON { response in
            self.handle(response: response, needLoading: needLoading, finished: finished)
        }
    }

    /// 处理响应结果
    ///
    /// - Parameters:
    ///   - response: 响应对象
    ///   - finished: 完成回调
    public func handle(response: DataResponse<Any>, needLoading: Bool, finished: @escaping JCNetworkFinished) {
        // MARK: Todo   needLoading ：取消loading

        switch response.result {
        case let .success(value):
            let json = JSON(value)

            if logEnable {
                print("JCResponse ------ \n ✅ URL:\((response.request?.url)!) \r\n ✅ Body -- :\r\n \(json) \r\n")
            }

            if needLoading {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            }

            if json["code"].string == "10000" {
                finished(.success, json, json["message"].string)
            } else {
                finished(.unusual, json, json["message"].string)
            }
        case let .failure(error):

            if logEnable {
                print("JCResponse ------ \n ❌ URL:\((response.request?.url)!) \r\n ❌ error -- :\r\n \(error.localizedDescription) \r\n")
            }

            // MARK: Todo   enablelog

            finished(.failure, nil, error.localizedDescription)
        }
    }

    // MARK: - TODO 使用其他pod库

    // convert Dictionary to JsonString
    func getJSONStringFromDictionary(dictionary: Dictionary<String, Any>?) -> String {
        if !JSONSerialization.isValidJSONObject(dictionary as Any) {
            return "{}"
        }
        let data: NSData! = try? JSONSerialization.data(withJSONObject: dictionary as Any, options: []) as NSData
        let JSONString = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
}
