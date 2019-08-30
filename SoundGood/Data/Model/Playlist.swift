//
//  Playlist.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/3/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import ObjectMapper

struct Playlist: BaseModel {

    var name: String?
    var tracks: [Track]?

    init(name: String, tracks: [Track]) {
        self.name = name
        self.tracks = tracks
    }

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

    }
}
