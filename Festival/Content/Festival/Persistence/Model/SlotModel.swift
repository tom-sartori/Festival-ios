//
// Created by Tom Sartori on 3/22/23.
//

import Foundation

class SlotModel: Equatable, Hashable, ObservableObject {

    @Published public var id: UUID = UUID()
    @Published public var startHour: Date
    @Published public var endHour: Date
    @Published public var zones: [ZoneModel]
    @Published public var state: FestivalSlotState = .ready {
        didSet {
            switch state {
                case .ready:
                    debugPrint("SlotModel : ready. ")
                case .loading:
                    debugPrint("SlotModel : loading. ")
                case .update(let data):
                    debugPrint("SlotModel : update. ")
                    self.startHour = data.startHour
                    self.endHour = data.endHour
                    self.zones = data.zones
                    state = .ready
            }
        }
    }

    init(slotDto: SlotModelDto) {
        self.startHour = slotDto.startHour.toISODate()!
        self.endHour = slotDto.endHour.toISODate()!
        self.zones = []
        for zoneDto in slotDto.zones {
            self.zones.append(ZoneModel(zoneDto: zoneDto))
        }
    }

    init() {
        self.startHour = Date()
        self.endHour = Date()
        self.zones = []
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type(of: self)))
        hasher.combine(id)
    }

    static func ==(lhs: SlotModel, rhs: SlotModel) -> Bool {
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
