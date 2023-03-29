//
// Created by Tom Sartori on 3/22/23.
//

import Foundation
import SwiftUI

struct FestivalListIntent {

    @ObservedObject private var festivalList: FestivalListModel

    init(festivalList: FestivalListModel) {
        self.festivalList = festivalList
    }

    func load() -> Void {
        festivalList.state = .loading
        Task {
            festivalList.state = .loaded(await loadAux())
        }
    }

    func loadAux() async -> [FestivalModelDto] {
        do {
            return try await FestivalDao().read()
        }
        catch (let error) {
            print(error)
        }
        return []
    }

    func create(festival: FestivalModel) -> Void {
        festivalList.state = .loading
        Task {
            do {
                try await FestivalDao().create(festival: FestivalModelDto(festivalModel: festival))
                festivalList.state = .loaded(await loadAux())
            }
            catch (let error) {
                print(error)    /// TODO
            }
        }
    }

    func delete(at: IndexSet) {
        let id = festivalList[at.first!].id
        festivalList.remove(atOffsets: at)
        festivalList.state = .loading
        Task {
            do {
                try await FestivalDao().delete(id: id)
                festivalList.state = .loaded(await loadAux())
            }
            catch (let error) {
                print(error)    /// TODO
            }
        }
    }
}
