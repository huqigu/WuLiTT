//
//  APIManager.swift
//  WuLiTT
//
//  Created by yellow on 2019/3/12.
//  Copyright © 2019 yellow. All rights reserved.
//

import Foundation
import Moya

enum APIManager {
    case getHomeList(channelId: Int, timestamp: Int, slipType: String) // 获取首页列表
}

extension APIManager: TargetType {
    var baseURL: URL {
        switch self {
        case .getHomeList:
            return URL(string: Configs.Network.baseUrl)!
        default:
            return URL(string: Configs.Network.baseUrl)!
        }
    }

    var path: String {
        switch self {
        case .getHomeList: return "message/list"

        default: return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .getHomeList:
            return .get

        default:
            return .get
        }
    }

    var headers: [String: String]? {
        return nil
    }

    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case let .getHomeList(channelId, timestamp, slipType):
            params["channelId"] = channelId
            params["cursor"] = timestamp
            params["slipType"] = slipType
        default: break
        }
        return params
    }

    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    public var task: Task {
        return .requestPlain
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
}
