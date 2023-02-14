//
// Created by Tom Sartori on 2/7/23.
//

import Foundation

class TrackViewModel: Equatable, Hashable, ObservableObject {

	public var id: UUID
	@Published public var trackName: String
	public var artistName: String
	public var collectionName: String
	public var releaseDate: String

	@Published var state: TrackState = .ready {
		didSet {
			switch state {
				case .changingName(let newTrackName):
					debugPrint("TrackViewModel: ", newTrackName, " changed")
					// si le nom convient :
					trackName = newTrackName
				// sinon on fait passer le state en .error
				case .ready:
					debugPrint("TrackViewModel: ready state")
					debugPrint("--------------------------------------")
					notifyAll()
				default:
					break
			}
		}
	}

	private var observers: [TrackViewModelObserver]


	init(trackName: String, artistName: String, collectionName: String, releaseDate: String) {
		id = UUID()
		self.trackName = trackName
		self.artistName = artistName
		self.collectionName = collectionName
		self.releaseDate = releaseDate
		observers = []
	}

	static func ==(lhs: TrackViewModel, rhs: TrackViewModel) -> Bool {
		lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}

	func notifyAll() {
		for observer in observers {
			observer.updated()
		}
	}

	func register(observer: TrackViewModelObserver) {
		observers.append(observer)
	}
}
