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
//			TextField("Nom du morceau : " + track.trackName)
			TextField("Nom du morceau", text: $newTrackName)
				.onSubmit {
					track.trackName = newTrackName
				}
			Text("Nom de l'auteur : " + track.model.artistName)
			Text("Nom de l'album : " + track.model.collectionName)
		}
			.padding()

		VStack {
			TextField(
				"Nom du morceau",
				text: $newTrackName
			)
				.textFieldStyle(.roundedBorder)
				.onSubmit {
					track.trackName = newTrackName
					newTrackName = ""
				}
		}
			.padding()
	}
}
