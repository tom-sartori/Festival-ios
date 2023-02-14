//
// Created by Tom Sartori on 2/14/23.
//

import Foundation

enum TrackState: CustomStringConvertible, Equatable {
	case ready
	case changingName(String)
	case error(TrackIntentError)

	var description: String {
		switch self {
		case .ready:
			return "Ready"
		case .changingName(let newName):
			return "Changing name to \(newName)"
		case .error(let error):
			return "Error: \(error)"
		}
	}

	static func ==(lhs: TrackState, rhs: TrackState) -> Bool {
		switch (lhs, rhs) {
			case (.ready, .ready):
				return true
			case (.changingName(let name1), .changingName(let name2)):
				return name1 == name2
			default:
				return false
		}
	}
}
