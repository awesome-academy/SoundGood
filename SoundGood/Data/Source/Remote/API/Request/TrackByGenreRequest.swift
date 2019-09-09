//
//  TrackByGenreRequest.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/5/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

final class TrackByGenreRequest: BaseRequest {
    required init(url: String, genre: String, limit: Int) {
        let body: [String: Any] = ["kind": "top",
                                   "genre": genre,
                                   "limit": limit]
        super.init(url: url, requestType: .get, body: body)
    }
}
