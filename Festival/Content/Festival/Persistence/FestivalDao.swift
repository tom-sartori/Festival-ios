//
// Created by Tom Sartori on 3/22/23.
//

import Foundation

class FestivalDao: Dao<FestivalModelDto> {

    override init() {
        super.init()
    }

    func create(festival: FestivalModelDto) async throws {
        try await super.create(url: "/festival", object: festival)
    }

    public func read() async throws -> [FestivalModelDto] {
        try await super.read(url: "/festival")
    }

    public func update(id: String, festivalModelDto: FestivalModelDto) async throws -> Void {
        try await super.update(url: "/festival", id: id, object: festivalModelDto)
    }

    func delete(id: String) async throws {
        try await super.delete(url: "/festival", id: id)
    }
}
