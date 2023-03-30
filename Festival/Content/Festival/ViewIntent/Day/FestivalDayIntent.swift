//
// Created by Tom Sartori on 3/29/23.
//

import Foundation
import SwiftUI

struct FestivalDayIntent {

    public var festivalIntent: FestivalDetailIntent
    @ObservedObject private var day: DayModel

    init(festivalIntent: FestivalDetailIntent, day: DayModel) {
        self.festivalIntent = festivalIntent
        self.day = day
    }

    func update(dayModel: DayModel) -> Void {
        day.state = .loading
        festivalIntent.update(dayModel: dayModel)
        day.state = .ready
    }

    func update(slotModel: SlotModel) -> Void {
        day.state = .loading
        if let index = day.slots.firstIndex(of: slotModel) {
            day.slots[index] = slotModel
            update(dayModel: day)
        }
        day.state = .ready
    }

    func delete(at: IndexSet) -> Void {
        day.state = .loading
        day.slots.remove(atOffsets: at)
        festivalIntent.update(dayModel: day)
        day.state = .ready
    }
}
