//
//  HomeRequest.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/3/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

final class HomeRequest: BaseRequest {
    required init(url: String, kind: String, limit: Int) {
        let body: [String: Any] = ["kind": kind,
                                   "genre": "soundcloud:genres:all-music",
                                   "limit": limit]
        super.init(url: url, requestType: .get, body: body)
    }
}
