//
//  UserDao.swift
//  Festival
//
//  Created by Tom Sartori on 3/12/23.
//

import Foundation
import SwiftUI

class UserDAO : Dao<UserModelDto> {

    @AppStorage("isAdmin") var isAdmin: Bool = false

    func login(email : String, password : String) async -> Bool {
        let user : UserModel = UserModel(email: email, password : password)
        guard let url = URL(string: "\(apiUrl)/user/login") else {
            return false
        }
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            // append a value to a field
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // set (replace) a value to a field
            //        request.setValue("Bearer 1ccac66927c25f08de582f3919708e7aee6219352bb3f571e29566dd429ee0f0", forHTTPHeaderField: "Authorization")
            guard let encoded = await JSONHelper.encode(data: user) else {
                return false
            }
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            let sdata = String(data: data, encoding: .utf8)!
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 200 {
                guard let decoded: UserModel = await JSONHelper.decode(data: data) else {
                    return false
                }

                UserDefaults.standard.set(decoded.token ?? nil, forKey: "token")
                UserDefaults.standard.set(decoded.admin ?? false, forKey: "isAdmin")
                return true
            }
            else {
                return false
            }
        }
        catch {
        }
        return false
    }

    func register(firstName : String, lastName : String, email : String, password : String) async {
        let user : UserModel = UserModel(firstName: firstName, lastName: lastName, email: email, password : password)
        guard let url = URL(string: "\(apiUrl)/user/register") else {
            return
        }
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            // append a value to a field
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // set (replace) a value to a field
            //        request.setValue("Bearer 1ccac66927c25f08de582f3919708e7aee6219352bb3f571e29566dd429ee0f0", forHTTPHeaderField: "Authorization")
            guard let encoded = await JSONHelper.encode(data: user) else {
                return
            }
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            let sdata = String(data: data, encoding: .utf8)!
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 201 {
                guard let decoded: UserModel = await JSONHelper.decode(data: data) else {
                    return
                }
            }
            else{
//                let responseData = String(data: data, encoding: NSUTF8StringEncoding)
            }
        }
        catch{
        }
    }

    func read() async throws -> [UserModelDto] {
        try await super.read(url: "/user")
    }

    func logout() -> Void{
        UserDefaults.standard.set(nil, forKey: "token")
        UserDefaults.standard.set(false, forKey: "isAdmin")
    }

    func isLoggedIn() -> Bool {
        token != nil && token != ""
    }

    func isNotLoggedIn() -> Bool {
        !isLoggedIn()
    }
}
