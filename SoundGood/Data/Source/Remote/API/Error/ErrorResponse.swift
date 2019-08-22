//
//  ErrorResponse.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/22/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import Foundation
import ObjectMapper

struct ErrorResponse: Mappable {

    var message: String?

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
    }
}
