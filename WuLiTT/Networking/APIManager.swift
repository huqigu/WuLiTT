//
//  APIManager.swift
//  WuLiTT
//
//  Created by yellow on 2019/3/12.
//  Copyright © 2019 yellow. All rights reserved.
//

import Foundation
import Moya
import Moya_ObjectMapper
import ObjectMapper
import RxSwift

private func endpointMapping<Target: TargetType>(target: Target) -> Endpoint {
    print(" 🚀 URL：\(target.baseURL)\(target.path) \n 🚀 Method：\(target.method)\n 🚀 Parameters：\(String(describing: target.task)) ")

    return MoyaProvider.defaultEndpointMapping(for: target)
}

let provider = MoyaProvider<APIManager>(endpointClosure: endpointMapping, plugins: [JCRequestPlugin(), netWorkActivityPlugin])

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

    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    public var task: Task {
        switch self {
        case let .getHomeList(channelId, timestamp, slipType):
            return .requestParameters(parameters: ["channelId": channelId, "cursor": timestamp, "slipType": slipType], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
}
