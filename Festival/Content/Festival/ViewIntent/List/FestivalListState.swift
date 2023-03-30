//
// Created by Tom Sartori on 3/22/23.
//

import Foundation

enum FestivalListState: CustomStringConvertible, Equatable {

    case ready
    case loading
    case loaded([FestivalModelDto])

    var description: String {
        switch self {
            case .ready:
                return "FestivalListState: Ready"
            case .loading:
                return "FestivalListState: Loading"
            case .loaded:
                return "FestivalListState: loaded"
        }
    }

    static func ==(lhs: FestivalListState, rhs: FestivalListState) -> Bool {
        switch (lhs, rhs) {
            case (.ready, .ready):
                return true
            case (.loading, .loading):
                return true
            case (.loaded(let festivalListModel1), .loaded(let festivalListModel2)):
                return festivalListModel1.elementsEqual(festivalListModel2)
            default:
                return false
        }
    }
}

