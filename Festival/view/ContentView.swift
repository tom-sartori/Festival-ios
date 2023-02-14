//
//  ContentView.swift
//  Festival
//
//  Created by Tom Sartori on 2/6/23.
//
//

import SwiftUI

struct ContentView: View {

	@StateObject var trackListViewModel = TrackListViewModel(trackViewModelList: [
		TrackViewModel(trackName: "That's Life", artistName: "James Brown", collectionName: "Gettin' Down to It", releaseDate: "1969-05-01T12:00:00Z"),
		TrackViewModel(trackName: "Shoot the Moon", artistName: "Norah Jones", collectionName: "Come Away With Me (Deluxe Edition)", releaseDate: "2002-02-26T08:00:00Z"),
		TrackViewModel(trackName: "Kozmic Blues", artistName: "Janis Joplin", collectionName: "I Got Dem Ol' Kozmic  Blues Again Mama!", releaseDate: "1969-09-11T07:00:00Z"),
		TrackViewModel(trackName: "You Found Another Lover (I Lost Another Friend)", artistName: "Ben Harper & Charlie Musselwhite", collectionName: "Get Up! (Deluxe Version)", releaseDate: "2013-01-29T12:00:00Z")
	])


	var body: some View {
		VStack {
			NavigationStack {
				List {
					ForEach(trackListViewModel, id: \.self) {
						item in
						NavigationLink(destination: TrackDetailView(track: item)) {
							Text(item.trackName)
						}
					}
						.onDelete {
							indexSet in
							trackListViewModel.remove(atOffsets: indexSet)
						}
						.onMove {
							indexSet, index in
							trackListViewModel.move(fromOffsets: indexSet, toOffset: index)
						}
				}
					.navigationTitle("Track List")
					.toolbar {
						EditButton()
					}
			}
		}
	}
}

class ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}

	#if DEBUG
	@objc class func injected() {
		let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
		windowScene?.windows.first?.rootViewController = UIHostingController(rootView: ContentView())
	}
	#endif
}
