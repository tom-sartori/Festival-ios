//
// Created by Tom Sartori on 2/7/23.
//

import Foundation

class TrackListViewModel: RandomAccessCollection, ObservableObject, TrackViewModelObserver {

    @Published public var trackListViewModel: [TrackViewModel];

    init(trackModelList: [TrackModel]) {
        trackListViewModel = []

        for model in trackModelList {
            let trackViewModel = TrackViewModel(model: model)
            trackViewModel.register(observer: self)
            trackListViewModel.append(trackViewModel)
        }
    }

    subscript(index: Int) -> TrackViewModel {
        get {
            trackListViewModel[index]
        }
        set {
            trackListViewModel[index] = newValue
        }
    }

    var startIndex: Int {
        trackListViewModel.startIndex
    }

    var endIndex: Int {
        trackListViewModel.endIndex
    }

    func index(after i: Int) -> Int {
        trackListViewModel.index(after: i)
    }

    func remove(atOffsets: IndexSet) {
        trackListViewModel.remove(atOffsets: atOffsets)
    }

    func move(fromOffsets: IndexSet, toOffset: Int) {
        trackListViewModel.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }

    func updated() {
        objectWillChange.send()
    }
}
