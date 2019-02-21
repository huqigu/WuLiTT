//
//  JCEndPoint.swift
//  WuLiTT
//
//  Created by yellow on 2019/2/13.
//  Copyright © 2019 yellow. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

/// 请求响应状态
///
/// - success: 响应成功
/// - unusual: 响应异常
/// - failure: 请求错误
enum ResponseStatus: Int {
    case success = 0
    case unusual = 1
    case failure = 3
}

/// 网络请求回调闭包 status:响应状态 result:JSON tipString:提示信息
typealias JCNetworkFinished = (_ status: ResponseStatus, _ result: JSON?, _ tipString: String?) -> Void

class JCEndPoint: NSObject {
    var logEnable = false

    var baseParams: Dictionary<String, Any> = Dictionary()

    var baseHeader: String = ""

    static let sharedInstance = JCEndPoint()

    func setBaseParams(baseParams: Dictionary<String, Any>) {
        JCEndPoint.sharedInstance.baseParams = baseParams
    }

    func setBaseHeader(baseHeader: String) {
        JCEndPoint.sharedInstance.baseHeader = baseHeader
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
    func get(_ APIString: String, parameters: [String: Any]?, needHeaders: Bool = true, needLoading: Bool = false, finished: @escaping JCNetworkFinished) {
        // MARK: Todo   needLoading ：弹出loading

        let headers = needHeaders ? JCEndPoint.sharedInstance.baseHeader : nil

        // MARK: Todo   enablelog

        print("\n🚀🚀🚀\nRequest: \nURL: \(kHostUrl + APIString)\nMethod: get\nHeaders:\(String(describing: headers))\nParameters: \(String(describing: parameters))\n🚀🚀🚀")

        Alamofire.request(kHostUrl + APIString, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            handle(response: response, finished: finished, needLoading: needLoading)
        }

        /**
         POST请求

         - parameter URLString:  urlString
         - parameter parameters: 参数
         - parameter finished:   完成回调
         */
        func post(_ APIString: String, parameters: [String: Any]?, needHeaders: Bool = true, needLoading: Bool = false, finished: @escaping JCNetworkFinished) {
            // MARK: Todo   needLoading ：弹出loading

            let headers = needHeaders ? JCEndPoint.sharedInstance.baseHeader : nil

            // MARK: Todo   enablelog

            print("\n🚀🚀🚀\nRequest: \nURL: \(kHostUrl + APIString)\nMethod: get\nHeaders:\(String(describing: headers))\nParameters: \(String(describing: parameters))\n🚀🚀🚀")

            Alamofire.request(kHostUrl + APIString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                handle(response: response, finished: finished, needLoading: needLoading)
            }
        }

        /// 处理响应结果
        ///
        /// - Parameters:
        ///   - response: 响应对象
        ///   - finished: 完成回调
        func handle(response: DataResponse<Any>, finished: @escaping JCNetworkFinished, needLoading _: Bool) {
            // MARK: Todo   needLoading ：取消loading

            switch response.result {
            case let .success(value):
                let json = JSON(value)

                // MARK: Todo   enablelog

                if json["code"].string == "10000" {
                    finished(.success, json, json["message"].string)
                } else {
                    finished(.unusual, json, json["message"].string)
                }
            case let .failure(error):

                // MARK: Todo   enablelog

                finished(.failure, nil, error.localizedDescription)
            }
        }
    }
}
