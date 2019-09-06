//
//  BaseResult.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/4/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import ObjectMapper

enum BaseResult<T: Mappable> {
    case success(T?)
    case failure(error: BaseError?)
}
