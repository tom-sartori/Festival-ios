//
// Created by Tom Sartori on 3/22/23.
//

import Foundation

class ZoneModel: Equatable, Hashable {

    @Published public var name: String
    @Published public var nbVolunteerNeeded: Int
    @Published public var volunteers: [UserModel]

    init(zoneDto: ZoneModelDto) {
        self.name = zoneDto.name
        self.nbVolunteerNeeded = zoneDto.nbVolunteerNeeded
        self.volunteers = []
        for volunteerDto in zoneDto.volunteers {
            self.volunteers.append(UserModel(userDto: volunteerDto))
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type(of: self)))
        hasher.combine(name)
        hasher.combine(nbVolunteerNeeded)
    }

    static func ==(lhs: ZoneModel, rhs: ZoneModel) -> Bool {
        if lhs === rhs {
            return true
        }
        if type(of: lhs) != type(of: rhs) {
            return false
        }
        if lhs.name != rhs.name {
            return false
        }
        if lhs.nbVolunteerNeeded != rhs.nbVolunteerNeeded {
            return false
        }
        return true
    }
}
