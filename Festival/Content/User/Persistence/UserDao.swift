//
//  UserDao.swift
//  Festival
//
//  Created by Tom Sartori on 3/12/23.
//

import Foundation
import SwiftUI

class UserDAO : Dao<UserModel> {

    @AppStorage("isAdmin") var isAdmin: Bool = false

    func login(email : String, password : String) async {
        let user : UserModel = UserModel(email: email, password : password)
        guard let url = URL(string: "\(apiUrl)/user/login") else {
            print("bad GoRest URL")
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
                print("GoRest: pb encodage")
                return
            }
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            let sdata = String(data: data, encoding: .utf8)!
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 200 {
                print("GoRest Result: \(sdata)")
                guard let decoded: UserModel = await JSONHelper.decode(data: data) else {
                    print("GoRest: mauvaise récupération de données")
                    return
                }

                UserDefaults.standard.set(decoded.token ?? nil, forKey: "token")
                UserDefaults.standard.set(decoded.admin ?? false, forKey: "isAdmin")
                print("Loggedin. ")
            }
            else {
                print("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
//                let responseData = String(data: data, encoding: NSUTF8StringEncoding)
                print(response)
            }
        }
        catch {
            print("GoRest: bad request")
        }
    }

    func register(firstName : String, lastName : String, email : String, password : String) async {
        let user : UserModel = UserModel(firstName: firstName, lastName: lastName, email: email, password : password)
        guard let url = URL(string: "\(apiUrl)/user/register") else {
            print("bad GoRest URL")
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
                print("GoRest: pb encodage")
                return
            }
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            let sdata = String(data: data, encoding: .utf8)!
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 201 {
                print("GoRest Result: \(sdata)")
                guard let decoded: UserModel = await JSONHelper.decode(data: data) else {
                    print("GoRest: mauvaise récupération de données")
                    return
                }
                print(decoded)
            }
            else{
                print("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
//                let responseData = String(data: data, encoding: NSUTF8StringEncoding)
                print(response)
            }
        }
        catch{
            print("GoRest: bad request")
        }
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
