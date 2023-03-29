//
// Created by Tom Sartori on 3/27/23.
//

import Foundation

struct DayModelDto: Codable {

    public var name: String
    public var startHour: String
    public var endHour: String
    private(set) var slots: [SlotModelDto]

    init(dayModel: DayModel) {
        self.name = dayModel.name
        self.startHour = dayModel.startHour.toISOString()
        self.endHour = dayModel.endHour.toISOString()
        self.slots = []
        for slotModel in dayModel.slots {
            self.slots.append(SlotModelDto(slotModel: slotModel))
        }
    }
}
