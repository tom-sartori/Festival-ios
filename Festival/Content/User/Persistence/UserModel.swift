//
//  UserModel.swift
//  Festival
//
//  Created by Tom Sartori on 3/12/23.
//

import Foundation

class UserModel : Codable, Hashable {
    public var id: String?
    private(set) var firstName: String?
    private(set) var lastName: String?
    public var email: String
    public var password: String?
    public var token: String?
    public var admin: Bool?
    
    init(id: String, firstName: String, lastName: String, email: String, password: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
    
    init(email : String, password : String){
        self.email = email
        self.password = password
    }

    init(id: String) {
        self.id = id
        self.email = ""
    }

    init(firstName: String?, lastName: String?, email: String, password: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }

    init(userDto: UserModelDto) {
        self.id = userDto.id
        self.firstName = userDto.firstName
        self.lastName = userDto.lastName
        self.email = userDto.email
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type(of: self)))
        hasher.combine(id)
    }

    static func ==(lhs: UserModel, rhs: UserModel) -> Bool {
        if lhs === rhs {
            return true
        }
        if type(of: lhs) != type(of: rhs) {
            return false
        }
        if lhs.id != rhs.id {
            return false
        }
        return true
    }
}
