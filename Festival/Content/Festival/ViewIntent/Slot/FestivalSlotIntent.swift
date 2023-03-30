//
// Created by Tom Sartori on 3/30/23.
//

import Foundation
import SwiftUI

struct FestivalSlotIntent {

    public var festivalDayIntent: FestivalDayIntent
    @ObservedObject private var slot: SlotModel

    init(festivalDayIntent: FestivalDayIntent, slot: SlotModel) {
        self.festivalDayIntent = festivalDayIntent
        self.slot = slot
    }

    func update() -> Void {
        slot.state = .loading
        festivalDayIntent.update(slotModel: slot)
        slot.state = .ready
    }

    func delete(at: IndexSet) -> Void {
        slot.state = .loading
        slot.zones.remove(atOffsets: at)
        update()
        slot.state = .ready
    }

    func update(zoneModel: ZoneModel) {
        if let index = slot.zones.firstIndex(of: zoneModel) {
            slot.zones[index] = zoneModel
            update()
        }
    }
}
