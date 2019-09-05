//
//  HomeTrackResponse.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/4/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import ObjectMapper

final class HomeResponse: Mappable {
    var trackCollection = [TrackCollection]()

    required init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        trackCollection <- map["collection"]
    }
}
