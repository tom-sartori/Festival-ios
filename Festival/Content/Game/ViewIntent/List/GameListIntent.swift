//
//  GameListIntent.swift
//  Festival
//
//  Created by Tom Sartori on 3/13/23.
//

import Foundation
import SwiftUI

struct GameListIntent {
    
    @ObservedObject private var gameListModel: GameListModel
    
    
    init(gameListModel: GameListModel) {
        self.gameListModel = gameListModel
    }
    
    func load() -> Void {
        gameListModel.state = .loading
        Task {
            gameListModel.state = .loaded(await GameDao().read())
        }
    }
    
    func load(name: String) -> Void {
        gameListModel.state = .loading
        Task {
            gameListModel.state = .loaded(await GameDao().read(name: name))
        }
    }

    
    
//    func loaded() async -> Void {
//        gameListModel.state = .loading
//        gameListModel.state = .loaded(await GameDao().getGameList())
//    }
}
