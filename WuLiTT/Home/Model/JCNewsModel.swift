//
//  JCNewsModel.swift
//  WuLiTT
//
//  Created by yellow on 2019/3/14.
//  Copyright © 2019 yellow. All rights reserved.
//

import ObjectMapper
import UIKit

struct JCNewsModel: Mappable {
    var newsId: String?
    var newsType: String?
    var title: String?
    var newsImageList: [JCNewsImageModel]?
    var origin: String?
    var originLink: String?

    init?(map _: Map) {}

    mutating func mapping(map: Map) {
        newsId <- map["newsId"]
        newsType <- map["newsType"]
        title <- map["title"]
        newsImageList <- map["newsImageInfoList"]
        origin <- map["origin"]
        originLink <- map["originLink"]
    }
}

struct JCNewsImageModel: Mappable {
    var url: String?
    var small: String?
    var src: String?
    var width: Int?
    var height: Int?
    var gifStatus: Int?
    var hasVideo: Bool?
    var videoUrl: String?
    var key: String?
    var coverEnable: Int?
    var gif: Bool?
    var gifFormat: Bool?

    init?(map _: Map) {}

    mutating func mapping(map: Map) {
        url <- map["url"]
        small <- map["small"]
        src <- map["src"]
        width <- map["width"]
        height <- map["height"]
        gifStatus <- map["gifStatus"]
        hasVideo <- map["hasVideo"]
        videoUrl <- map["videoUrl"]
        key <- map["key"]
        coverEnable <- map["coverEnable"]
        gif <- map["gif"]
        gifFormat <- map["gifFormat"]
    }
}
