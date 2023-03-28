//
// Created by Tom Sartori on 3/20/23.
//

import Foundation

enum HttpError: Error {
    case badRequest
    case unauthorized
    case notFound
    case methodNotAllowed
    case notAcceptable
    case conflict
    case serverError
    case wrongUrl
    case decodingError

    init(status: Int) {
        switch status {
            case 400:
                self = .badRequest
            case 401:
                self = .unauthorized
            case 404:
                self = .notFound
            case 405:
                self = .methodNotAllowed
            case 406:
                self = .notAcceptable
            case 409:
                self = .conflict
            default:
                self = .serverError
        }
    }
}
