//
// Created by Tom Sartori on 3/27/23.
//

import Foundation

struct ZoneModelDto : Codable {
    private(set) var name: String
    private(set) var nbVolunteerNeeded: Int
    private(set) var volunteers: [UserModelDto]

    init(zoneModel: ZoneModel) {
        self.name = zoneModel.name
        self.nbVolunteerNeeded = zoneModel.nbVolunteerNeeded
        self.volunteers = []
        for userModel in zoneModel.volunteers {
            self.volunteers.append(UserModelDto(userModel: userModel))
        }
    }
}
