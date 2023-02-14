//
// Created by Tom Sartori on 2/13/23.
//

import SwiftUI

struct TrackDetailView: View {

	@ObservedObject public var track: TrackViewModel

	@State private var newTrackName: String
	private var intent: TrackIntent

	init(track: TrackViewModel) {
		self.track = track
		intent = TrackIntent(track: track)
		_newTrackName = State(initialValue: track.trackName)
	}

	var body: some View {
		VStack {
			Text("Nom du morceau : " + track.trackName)
			Text("Nom de l'auteur : " + track.artistName)
			Text("Nom de l'album : " + track.collectionName)
		}
			.padding()
			.onChange(of: track.trackName) {
				newValue in
				intent.change(name: newValue)
			}

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
