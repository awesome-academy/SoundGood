//
//  BaseError.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/22/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

enum BaseError: Error {

    case networkError
    case httpError(httpCode: Int)
    case unexpectedError
    case apiFailure(error: ErrorResponse?)

    public var errorMessage: String? {
        switch self {
        case .networkError:
            return "Network Error"
        case .httpError(let code):
            return getHttpErrorMessage(httpCode: code)
        case .apiFailure(let error):
            if let error = error {
                return error.message
            }
            return "Error"
        default:
            return "Unexpected Error"
        }
    }

    private func getHttpErrorMessage(httpCode: Int) -> String? {
        switch httpCode {
        case 300...308:
            return "It was transferred to a different URL. I'm sorry for causing you trouble"
        case 400...451:
            return "An error occurred on the application side. Please try again later!"
        case 500...511:
            return "A server error occurred. Please try again later!"
        default:
            return "An error occurred. Please try again later!"
        }
    }
}
