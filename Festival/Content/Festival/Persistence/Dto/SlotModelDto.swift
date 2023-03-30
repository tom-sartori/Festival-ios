//
// Created by Tom Sartori on 3/27/23.
//

import Foundation

struct SlotModelDto : Codable {
    private(set) var startHour: String
    private(set) var endHour: String
    private(set) var zones: [ZoneModelDto]

    init(slotModel: SlotModel) {
        self.startHour = slotModel.startHour.toISOString()
        self.endHour = slotModel.endHour.toISOString()
        self.zones = []
        for zoneModel in slotModel.zones {
            self.zones.append(ZoneModelDto(zoneModel: zoneModel))
        }
    }
}
