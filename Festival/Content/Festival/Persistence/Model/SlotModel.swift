//
// Created by Tom Sartori on 3/22/23.
//

import Foundation

class SlotModel: Equatable, Hashable {

    @Published public var startHour: String
    @Published public var endHour: String
    @Published public var zones: [ZoneModel]

    init(slotDto: SlotModelDto) {
        self.startHour = slotDto.startHour
        self.endHour = slotDto.endHour
        self.zones = []
        for zoneDto in slotDto.zones {
            self.zones.append(ZoneModel(zoneDto: zoneDto))
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type(of: self)))
        hasher.combine(startHour)
        hasher.combine(endHour)
    }

    static func ==(lhs: SlotModel, rhs: SlotModel) -> Bool {
        if lhs === rhs {
            return true
        }
        if type(of: lhs) != type(of: rhs) {
            return false
        }
        if lhs.startHour != rhs.startHour {
            return false
        }
        if lhs.endHour != rhs.endHour {
            return false
        }
        return true
    }
}
