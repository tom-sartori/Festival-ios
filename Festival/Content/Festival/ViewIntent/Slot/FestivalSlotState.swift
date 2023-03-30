//
// Created by Tom Sartori on 3/30/23.
//

import Foundation

enum FestivalSlotState : CustomStringConvertible, Hashable{
    case ready
    case loading
    case update(SlotModel)

    var description: String {
        switch self {
            case .ready:
                return "FestivalSlotState: Ready"
            case .loading:
                return "FestivalSlotState: Loading"
            case .update:
                return "FestivalSlotState: Update"
        }
    }

    static func == (lhs: FestivalSlotState, rhs: FestivalSlotState) -> Bool {
        switch (lhs, rhs) {
        case (.ready, .ready):
            return true
        case (.loading, .loading):
            return true
        case (.update(let slotModel1), .update(let slotModel2)):
            return slotModel1 == slotModel2
        default:
            return false
        }
    }

}
