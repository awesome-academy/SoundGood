//
//  SearchResponse.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/5/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import ObjectMapper

final class SearchResponse: Mappable {
    var collection = [Track]()

    required init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        collection <- map["collection"]
    }
}
