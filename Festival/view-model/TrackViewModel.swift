//
// Created by Tom Sartori on 2/7/23.
//

import Foundation

class TrackViewModel: Equatable, Hashable, TrackModelObserver {

    public var id: UUID
    public var model: TrackModel

    private var observers: [TrackViewModelObserver]

    init(model: TrackModel) {
        id = UUID()
        self.model = model
        trackName = model.trackName
        observers = []
    }

    static func == (lhs: TrackViewModel, rhs: TrackViewModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    @Published var trackName: String {
        didSet {
            if trackName != model.trackName {
                model.trackName = trackName
                notifyAll()
            }
        }
    }

    func trackNameChanged(newName: String) {
        if newName != model.trackName {
            model.trackName = newName
            notifyAll()
        }
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
