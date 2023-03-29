//
// Created by Tom Sartori on 3/22/23.
//

import Foundation
import SwiftUI

class DayModel: Equatable, Hashable {

    @Published public var name: String
    @Published public var startHour: Date
    @Published public var endHour: Date
    @Published public var slots: [SlotModel]

    init() {
        self.name = "";
        self.startHour = "2023-03-29T06:00:00.397Z".toISODate()!
        self.endHour = "2023-03-29T16:00:00.397Z".toISODate()!
        self.slots = []
    }

    init(name: String, startHour: Date, endHour: Date, slots: [SlotModel]) {
        self.name = name
        self.startHour = startHour
        self.endHour = endHour
        self.slots = slots
    }

    init(dayDto: DayModelDto) {
        self.name = dayDto.name
        self.startHour = dayDto.startHour.toISODate()!
        self.endHour = dayDto.endHour.toISODate()!
        self.slots = []
        for slotDto in dayDto.slots {
            self.slots.append(SlotModel(slotDto: slotDto))
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type(of: self)))
        hasher.combine(name)
        hasher.combine(startHour)
        hasher.combine(endHour)
    }

    static func ==(lhs: DayModel, rhs: DayModel) -> Bool {
        if lhs === rhs {
            return true
        }
        if type(of: lhs) != type(of: rhs) {
            return false
        }
        if lhs.name != rhs.name {
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

