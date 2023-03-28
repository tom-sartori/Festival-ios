//
// Created by Tom Sartori on 3/6/23.
//

import Foundation
import SwiftUI

struct GameIntent {

    @ObservedObject private var game: GameModel

    init(game: GameModel) {
        self.game = game
    }
    
    public func create(game: GameModel) {
        game.state = .creating
        Task {
            let result: Bool = await GameDao().create(game: game)
            if result {
                game.state = .ready
            }
            else {
                game.state = .error(.error("Error while creating. "))
            }
        }
    }
    
    public func update(id: String, game: GameModel) {
        game.state = .updating
        Task {
            let result: Bool = await GameDao().update(id: id, game: game)
            if result {
                game.state = .ready
            }
            else {
                game.state = .error(.error("Error while updating. "))
            }
        }
    }
    
    public func delete(id: String) -> Void {
        game.state = .deleting
        Task {
            await GameDao().delete(id: id)
            game.state = .ready
        }
    }
}
