//
// Created by Tom Sartori on 3/30/23.
//

import Foundation
import SwiftUI

struct FestivalZoneIntent {

    private var slotIntent: FestivalSlotIntent
    @ObservedObject private var zone: ZoneModel

    init(slotIntent: FestivalSlotIntent, zone: ZoneModel) {
        self.slotIntent = slotIntent
        self.zone = zone
    }

    func update() -> Void {
        zone.state = .loading
        slotIntent.update(zoneModel: zone)
        zone.state = .ready
    }

    func delete(at: IndexSet) -> Void {
        zone.state = .loading
        zone.volunteers.remove(atOffsets: at)
        slotIntent.update(zoneModel: zone)
        zone.state = .ready
    }
}
