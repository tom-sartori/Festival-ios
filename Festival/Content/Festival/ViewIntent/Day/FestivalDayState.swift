//
// Created by Tom Sartori on 3/29/23.
//

import Foundation

enum FestivalDayState: CustomStringConvertible, Hashable{
    case ready
    case loading
    case update(DayModel)

    var description: String {
        switch self {
            case .ready:
                return "DayState: Ready"
            case .loading:
                return "DayState: Loading"
            case .update:
                return "DayState: Update"
        }
    }

    static func == (lhs: FestivalDayState, rhs: FestivalDayState) -> Bool {
        switch (lhs, rhs) {
        case (.ready, .ready):
            return true
        case (.loading, .loading):
            return true
        case (.update(let dayModel1), .update(let dayModel2)):
            return dayModel1 == dayModel2
        default:
            return false
        }
    }
}
