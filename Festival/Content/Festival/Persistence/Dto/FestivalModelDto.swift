//
// Created by Tom Sartori on 3/27/23.
//

import Foundation

struct FestivalModelDto: Codable, Equatable, Hashable {

    public var id: String
    public var name: String
    public var startDate: String
    public var active: Bool
    public var days: [DayModelDto]

    init() {
        self.id = ""
        self.name = ""
        self.startDate = Date().toISOString()
        self.active = true
        self.days = []
    }

    init(id: String, name: String, startDate: String, active: Bool, days: [DayModelDto]) {
        self.id = id
        self.name = name
        self.startDate = startDate
        self.active = active
        self.days = days
    }

    init(festivalModel: FestivalModel) {
        self.id = festivalModel.id
        self.name = festivalModel.name
        self.startDate = festivalModel.startDate.toISOString()
        self.active = festivalModel.active
        self.days = []
        for dayModel in festivalModel.days {
            self.days.append(DayModelDto(dayModel: dayModel))
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(startDate)
        hasher.combine(active)
    }

    static func ==(lhs: FestivalModelDto, rhs: FestivalModelDto) -> Bool {
        if lhs.id != rhs.id {
            return false
        }
        if lhs.name != rhs.name {
            return false
        }
        if lhs.startDate != rhs.startDate {
            return false
        }
        if lhs.active != rhs.active {
            return false
        }
        return true
    }
}
