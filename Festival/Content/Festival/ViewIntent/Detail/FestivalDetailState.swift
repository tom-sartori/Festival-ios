//
// Created by Tom Sartori on 3/27/23.
//

import Foundation

enum FestivalDetailState: CustomStringConvertible, Hashable {

    case ready
    case loading
    case update(FestivalModel)

    var description: String {
        switch self {
            case .ready:
                return "FestivalDetailState: Ready"
            case .loading:
                return "FestivalDetailState: Loading"
            case .update:
                return "FestivalDetailState: Update"
        }
    }

    static func == (lhs: FestivalDetailState, rhs: FestivalDetailState) -> Bool {
        switch (lhs, rhs) {
        case (.ready, .ready):
            return true
        case (.loading, .loading):
            return true
        case (.update(let festivalModel1), .update(let festivalModel2)):
            return festivalModel1 == festivalModel2
        default:
            return false
        }
    }
}
