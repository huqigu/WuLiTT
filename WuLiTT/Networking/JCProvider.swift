//
//  JCProvider.swift
//  WuLiTT
//
//  Created by yellow on 2019/3/14.
//  Copyright © 2019 yellow. All rights reserved.
//

import Moya
import Moya_ObjectMapper
import ObjectMapper
import RxSwift

// 与数据相关的错误类型
enum DataError: Error {
    case customError // 其它错误
}

struct defaultModelList<T: BaseMappable>: Mappable {
    var code: String?
    var data: [T]?
    var message: String?

    init?(map _: Map) {}
    init() {}

    mutating func mapping(map: Map) {
        code <- map["code"]
        data <- map["data"]
        message <- map["message"]
    }
}

struct defaultModel<T: BaseMappable>: Mappable {
    var code: String?
    var data: T?
    var message: String?

    init?(map _: Map) {}
    init() {}

    mutating func mapping(map: Map) {
        code <- map["code"]
        data <- map["data"]
        message <- map["message"]
    }
}

extension MoyaProvider {
    public func requestModelList<T: Mappable>(_ target: Target, _: T.Type) -> Single<[T]> {
        return Single<[T]>.create(subscribe: { (single) -> Disposable in

            let request = self.rx.request(target).filterSuccessfulStatusCodes().mapObject(defaultModelList<T>.self).subscribe(onSuccess: { result in

                // 根据code值 来实现不同的操作
                if result.code == "10000" { // 成功 //返回deta中的模型
                    single(.success(result.data!))

                } else { // 提示msg
                    JCProgressHUD.showError(result.message!)
                    single(.error(DataError.customError))
                }

            }, onError: { _ in
                JCProgressHUD.showError("网络请求超时，请检查网络状态！")
            })

            return Disposables.create([request])

        })
    }

    public func requestModel<T: Mappable>(_ target: Target, _: T.Type) -> Single<T> {
        return Single<T>.create(subscribe: { (single) -> Disposable in

            let request = self.rx.request(target).filterSuccessfulStatusCodes().mapObject(defaultModel<T>.self).subscribe(onSuccess: { result in

                // 根据code值 来实现不同的操作
                if result.code == "10000" { // 成功 //返回deta中的模型
                    single(.success(result.data!))

                } else { // 提示msg
                    JCProgressHUD.showError(result.message!)
                    single(.error(DataError.customError))
                }

            }, onError: { _ in
                JCProgressHUD.showError("网络请求超时，请检查网络状态！")
            })

            return Disposables.create([request])

        })
    }
}
