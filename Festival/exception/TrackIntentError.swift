//
// Created by Tom Sartori on 2/14/23.
//

import Foundation

enum TrackIntentError: CustomStringConvertible, Equatable {

	case tooShortName(String)

	var description: String {
		switch self {
			case .tooShortName:
				return "Too short name"
		}
	}

	static func ==(lhs: TrackIntentError, rhs: TrackIntentError) -> Bool {
		switch (lhs, rhs) {
			case (.tooShortName(let name1), .tooShortName(let name2)):
				return name1 == name2
		}
	}
}
