//
// Created by Tom Sartori on 3/22/23.
//

import Foundation

class FestivalListModel: RandomAccessCollection, ObservableObject {

    @Published private var festivals: [FestivalModel]

    @Published public var state: FestivalListState = .ready {
        didSet {
            switch state {
                case .ready:
                    print("FestivalListModel : ready")
                case .loading:
                    print("FestivalListModel : load")
                case .loaded(let data):
                    print("FestivalListModel : loaded")
                    festivals = mapFromDto(festivalDtoList: data)
                    state = .ready
            }
        }
    }

    init(festivals: [FestivalModel]) {
        self.festivals = festivals
    }

    private func mapFromDto(festivalDtoList: [FestivalModelDto]) -> [FestivalModel] {
        var festivals: [FestivalModel] = []
        for festivalDto in festivalDtoList {
            festivals.append(FestivalModel(festivalDto: festivalDto))
        }
        return festivals
    }

    subscript(index: Int) -> FestivalModel {
        get {
            festivals[index]
        }
        set {
            festivals[index] = newValue
        }
    }

    var startIndex: Int {
        festivals.startIndex
    }

    var endIndex: Int {
        festivals.endIndex
    }

    func index(after i: Int) -> Int {
        festivals.index(after: i)
    }

    func remove(atOffsets: IndexSet) {
        festivals.remove(atOffsets: atOffsets)
    }

    func append(_ festival: FestivalModel) {
        festivals.append(festival)
    }
}
