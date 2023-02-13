//
// Created by Tom Sartori on 2/13/23.
//

import SwiftUI

struct TrackDetailView: View {

	@ObservedObject public var track: TrackViewModel
	@State private var newTrackName: String

	init(track: TrackViewModel) {
		self.track = track
		_newTrackName = State(initialValue: track.trackName)
	}

	var body: some View {
		VStack {
			Text("Nom du morceau : " + track.trackName)
			Text("Nom du l'auteur : " + track.model.artistName)
			Text("Nom du l'album : " + track.model.collectionName)
		}

		VStack {
			TextField(
				"Nom du morceau",
				text: $newTrackName
			)
				.padding()
				.textFieldStyle(.roundedBorder)
				.onSubmit {
					track.trackName = newTrackName
					newTrackName = ""
				}
		}
	}
}
