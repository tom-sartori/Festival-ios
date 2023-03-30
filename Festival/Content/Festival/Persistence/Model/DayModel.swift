//
// Created by Tom Sartori on 3/22/23.
//

import Foundation
import SwiftUI

class DayModel: Equatable, Hashable, ObservableObject {

    @Published public var id: UUID = UUID()
    @Published public var name: String
    @Published public var startHour: Date
    @Published public var endHour: Date
    @Published public var slots: [SlotModel]

    @Published public var state: FestivalDayState = .ready {
        didSet {
            switch state {
                case .ready:
                    debugPrint("DayModel : ready. ")
                case .loading:
                    debugPrint("DayModel : loading. ")
                case .update(let data):
                    debugPrint("DayModel : update. ")
                    self.name = data.name
                    self.startHour = data.startHour
                    self.endHour = data.endHour
                    self.slots = data.slots
                    state = .ready
            }
        }
    }

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
        hasher.combine(id)
    }

    static func ==(lhs: DayModel, rhs: DayModel) -> Bool {
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

