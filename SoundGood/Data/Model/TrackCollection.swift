//
//  TrackCollection.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/4/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import ObjectMapper

class TrackCollection: BaseModel {
    var track = Track()

    required init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        track <- map["track"]
    }
}
