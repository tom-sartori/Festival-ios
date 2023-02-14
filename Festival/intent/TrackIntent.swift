//
// Created by Tom Sartori on 2/14/23.
//

import Foundation
import SwiftUI

struct TrackIntent {

	@ObservedObject private var model: TrackViewModel

	init(track: TrackViewModel) {
		model = track
	}

	// intent to change name of ViewModel
	func change(name: String) {
		let newName = name.trimmingCharacters(in: .whitespacesAndNewlines)
		if newName.count < 4 {
			model.state = .error(.tooShortName(newName))
		}
		else {
			model.state = .changingName(name)
		}
		// les observateurs ont été prévenus du résultat → .ready
		model.state = .ready
	}
}
