//
//  SearchRequest.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/4/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

final class SearchRequest: BaseRequest {
    required init(url: String, keyword: String, limit: Int) {
        let body: [String: Any] = ["q": keyword,
                                   "limit": limit]
        super.init(url: url, requestType: .get, body: body)
    }
}
