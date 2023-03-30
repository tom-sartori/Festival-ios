//
// Created by Tom Sartori on 3/22/23.
//

import Foundation

class FestivalModel: Equatable, Hashable, ObservableObject {

    @Published public var id: String
    @Published public var name: String
    @Published public var startDate: Date
    @Published public var active: Bool
    @Published public var days: [DayModel]

    @Published public var state: FestivalDetailState = .ready {
        didSet {
            switch state {
                case .ready:
                    debugPrint("FestivalModel : ready. ")
                case .loading:
                    debugPrint("FestivalModel : loading. ")
                case .update(let data):
                    debugPrint("FestivalModel : update. ")
                    self.id = data.id
                    self.name = data.name
                    self.startDate = data.startDate
                    self.active = data.active
                    self.days = data.days
                    state = .ready
            }
        }
    }

    init() {
        self.id = ""
        self.name = ""
        self.startDate = Date()
        self.active = true
        self.days = []
    }

    init(id: String, name: String, startDate: Date, active: Bool, days: [DayModel]) {
        self.id = id
        self.name = name
        self.startDate = startDate
        self.active = active
        self.days = days
    }

    init(festivalDto: FestivalModelDto) {
        self.id = festivalDto.id
        self.name = festivalDto.name
        self.startDate = festivalDto.startDate.toISODate()!
        self.active = festivalDto.active
        self.days = []
        for dayDto in festivalDto.days {
            self.days.append(DayModel(dayDto: dayDto))
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type(of: self)))
        hasher.combine(id)
    }

    static func ==(lhs: FestivalModel, rhs: FestivalModel) -> Bool {
        if lhs === rhs {
            return true
        }
        if type(of: lhs) != type(of: rhs) {
            return false
        }
        if lhs.id != rhs.id {
            return false
        }

        return true
    }
}
