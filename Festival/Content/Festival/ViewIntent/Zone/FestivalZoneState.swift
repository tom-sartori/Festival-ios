//
// Created by Tom Sartori on 3/30/23.
//

import Foundation

enum FestivalZoneState: CustomStringConvertible, Hashable {

    case ready
    case loading
    case update(ZoneModel)

    var description: String {
        switch self {
            case .ready:
                return "FestivalZoneState: Ready"
            case .loading:
                return "FestivalZoneState: Loading"
            case .update:
                return "FestivalZoneState: Update"
        }
    }

    static func == (lhs: FestivalZoneState, rhs: FestivalZoneState) -> Bool {
        switch (lhs, rhs) {
        case (.ready, .ready):
            return true
        case (.loading, .loading):
            return true
        case (.update(let zoneModel1), .update(let zoneModel2)):
            return zoneModel1 == zoneModel2
        default:
            return false
        }
    }
}
