//
// Created by Tom Sartori on 3/27/23.
//

import Foundation

struct UserModelDto : Codable {
    public var id: String
    public var firstName: String
    public var lastName: String
    public var email: String

    init(userModel: UserModel) {
        self.id = userModel.id!
        self.firstName = userModel.firstName ?? ""
        self.lastName = userModel.lastName ?? ""
        self.email = userModel.email
    }
}
