//
// Created by Tom Sartori on 3/23/23.
//

import Foundation
import SwiftUI

struct FestivalDetailIntent {

    @ObservedObject private var festival: FestivalModel

    init(festival: FestivalModel) {
        self.festival = festival
    }

    func update(festivalModel: FestivalModel) -> Void {
        festival.state = .loading
        Task {
            do {
                try await FestivalDao().update(id: festivalModel.id, festivalModelDto: FestivalModelDto(festivalModel: festivalModel))
                festival.state = .ready
            }
            catch (let error) {
                print(error)
            }
        }
    }
}
