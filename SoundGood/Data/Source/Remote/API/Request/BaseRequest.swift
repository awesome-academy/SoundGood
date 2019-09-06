//
//  BaseRequest.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/22/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import Foundation
import Alamofire

class BaseRequest {
    var url = ""
    var requestType = Alamofire.HTTPMethod.get
    var body: [String: Any]?
    var encoding: ParameterEncoding {
        switch requestType {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    init(url: String, requestType: Alamofire.HTTPMethod) {
        self.url = url
        self.requestType = requestType
    }

    init(url: String, requestType: Alamofire.HTTPMethod, body: [String: Any]) {
        self.url = url
        self.requestType = requestType
        self.body = body
        self.body?["client_id"] = ApiKey.apiKey
    }
}
