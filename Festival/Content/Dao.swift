//
// Created by Tom Sartori on 3/20/23.
//

import Foundation

import Foundation
import SwiftUI

class Dao<T: Codable> {

    public let apiUrl = "http://localhost:8080"
//    public let apiUrl = "https://teewvds053.execute-api.eu-west-3.amazonaws.com"

    @AppStorage("token") var token: String?

    public init() {}

    public func create(url: String, object: T) async throws -> Void {
        let encoded = try! JSONEncoder().encode(object)

        guard let url = URL(string: "\(apiUrl)\(url)") else {
            throw HttpError.wrongUrl
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"

        let (_, response) = try! await URLSession.shared.upload(for: request, from: encoded)

        guard let resp = response as? HTTPURLResponse else {
            throw HttpError.serverError
        }

        if resp.statusCode >= 400 {
            throw HttpError(status: resp.statusCode)
        }
    }

    func read(url: String) async throws -> [T] {
        guard let url = URL(string: "\(apiUrl)\(url)") else {
            throw HttpError.wrongUrl
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let result: [T] = await JSONHelper.decode(data: data) else {
                throw HttpError.decodingError
            }
            return result
        }
    }

    public func update(url: String, id: String, object: T) async throws {
        let encoded = try! JSONEncoder().encode(object)

        guard let url = URL(string: "\(apiUrl)\(url)/\(id)") else {
            throw HttpError.wrongUrl
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "PUT"

        let (_, response) = try! await URLSession.shared.upload(for: request, from: encoded)

        let httpresponse = response as! HTTPURLResponse
        if httpresponse.statusCode >= 400 {
            throw HttpError(status: httpresponse.statusCode)
        }
    }

    public func delete(url: String, id: String) async throws {
        guard let url = URL(string: "\(apiUrl)\(url)/\(id)") else {
            throw HttpError.wrongUrl
        }

        var request = URLRequest(url: url)

//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")    /// TODO
        request.httpMethod = "DELETE"

        let (_, response) = try! await URLSession.shared.data(for: request)

        guard let resp = response as? HTTPURLResponse else {
            throw HttpError.serverError
        }

        if resp.statusCode >= 400 {
            throw HttpError(status: resp.statusCode)
        }
    }
}
