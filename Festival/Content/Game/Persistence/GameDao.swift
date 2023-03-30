//
//  GameDao.swift
//  Festival
//
//  Created by Tom Sartori on 3/12/23.
//

import Foundation

struct GameDao {
    
    func create(game: GameModel) async -> Bool {
        guard let url = URL(string: "https://nos4jpqp7a.execute-api.eu-west-3.amazonaws.com/game") else {
            print("bad GoRest URL")
            return false
        }
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            // append a value to a field
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // set (replace) a value to a field
            //        request.setValue("Bearer 1ccac66927c25f08de582f3919708e7aee6219352bb3f571e29566dd429ee0f0", forHTTPHeaderField: "Authorization")
            guard let encoded = await JSONHelper.encode(data: game) else {
                print("GoRest: pb encodage")
                return false
            }
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            let sdata = String(data: data, encoding: .utf8)!
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 201 {
                print("GoRest Result: \(sdata)")
                return true
            }
            else{
                print("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
            }
        }
        catch{
            print("GoRest: bad request")
        }
        return false
    }
    
    func read() async -> [GameModel] {
        guard let url = URL(string: "https://nos4jpqp7a.execute-api.eu-west-3.amazonaws.com/game") else {
            print("bad GoRest URL")
            return [] /// TODO
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            // let response = response as! HTTPURLResponse
            
            
            guard let gameModelList : [GameModel] = await JSONHelper.decode(data: data) else {
                print("GoRest pb décodage")
                return [] /// TODO
            }
            
            return gameModelList
        }
        catch{
            print("GoRest: bad request")
        }
        return [] /// TODO
    }
    
    func read(name: String) async -> [GameModel] {
        guard let url = URL(string: "https://nos4jpqp7a.execute-api.eu-west-3.amazonaws.com/game/name/\(name)") else {
            print("bad GoRest URL")
            return [] /// TODO
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            // let response = response as! HTTPURLResponse
            
            
            guard let gameModelList : [GameModel] = await JSONHelper.decode(data: data) else {
                print("GoRest pb décodage")
                return [] /// TODO
            }
            
            return gameModelList
        }
        catch{
            print("GoRest: bad request")
        }
        return [] /// TODO
    }

    
    func update(id: String, game: GameModel) async -> Bool {
        guard let url = URL(string: "https://nos4jpqp7a.execute-api.eu-west-3.amazonaws.com/game/\(id)") else {
            print("bad GoRest URL")
            return false
        }
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            // append a value to a field
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // set (replace) a value to a field
            //        request.setValue("Bearer 1ccac66927c25f08de582f3919708e7aee6219352bb3f571e29566dd429ee0f0", forHTTPHeaderField: "Authorization")
            guard let encoded = await JSONHelper.encode(data: game) else {
                print("GoRest: pb encodage")
                return false
            }
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            let sdata = String(data: data, encoding: .utf8)!
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 204 {
                print("GoRest Result: \(sdata)")
                return true
            }
            else{
                print("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
            }
        }
        catch{
            print("GoRest: bad request")
        }
        return false
    }
    
    func delete(id: String) async {
        guard let url = URL(string: "https://nos4jpqp7a.execute-api.eu-west-3.amazonaws.com/game/\(id)") else {
            print("bad GoRest URL")
            return
        }
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            // append a value to a field
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // set (replace) a value to a field
            //        request.setValue("Bearer 1ccac66927c25f08de582f3919708e7aee6219352bb3f571e29566dd429ee0f0", forHTTPHeaderField: "Authorization")
            
//            let (data, response) = try await URLSession.shared.data(from: url)
//            let sdata = String(data: data, encoding: .utf8)!
//            let httpresponse = response as! HTTPURLResponse
            
            URLSession.shared.dataTask(with: request) { data, response, error in
//                if httpresponse.statusCode == 204 {
//                    print("GoRest Result: \(sdata)")
//                }
//                else {
//                    print("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
                
            }
        }
    }
    
}
