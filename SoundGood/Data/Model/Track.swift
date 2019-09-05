//
//  Track.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/3/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import ObjectMapper

struct Track: BaseModel {

    var name: String = ""

    init(name: String) {
        self.name = name
    }

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

    }
}
