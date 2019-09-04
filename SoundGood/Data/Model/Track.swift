//
//  Track.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/3/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import ObjectMapper

struct Track: BaseModel {

    var trackId: Int?
    var title: String?
    var artist: String?
    var artWorkUrl: String?
    var streamUrl: String?
    var fullDuration: Int?
    var policy: String?
    private var uri: String?

    init() {
    }

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        trackId <- map["id"]
        title <- map["title"]
        artist <- map["user.username"]
        artWorkUrl <- map["artwork_url"]
        uri <- map["uri"]
        streamUrl = uri ?? "" + "/stream"
        fullDuration <- map["full_duration"]
        policy <- map["policy"]
    }
}
