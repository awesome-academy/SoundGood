//
//  SoundCloundService.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/3/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

struct ApiService {
    static let shared = ApiService()
    private var alamofireManager: Alamofire.SessionManager

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
    }

    func request<T: Mappable>(input: BaseRequest, completion: @escaping (_ value: T?, _ error: Error?) -> Void) {
        let queue = DispatchQueue(label: "com.sun.SoundGood.response-queue", qos: .utility, attributes: [.concurrent])
        alamofireManager.request(input.url, method: input.requestType, parameters: input.body, encoding: input.encoding)
            .validate(statusCode: 200..<500)
            .responseObject(queue: queue) { (response: DataResponse<T>) in
                switch response.result {
                case .failure(let error):
                    completion(nil, error)
                case .success(let value):
                    guard let statusCode = response.response?.statusCode else {
                        completion(nil, BaseError.unexpectedError)
                        return
                    }
                    if statusCode == 200 {
                        completion(value, nil)
                    } else {
                        completion(nil, BaseError.httpError(httpCode: statusCode))
                    }
                }
        }
    }
}
