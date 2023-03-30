//
//  GameListState.swift
//  Festival
//
//  Created by Tom Sartori on 3/13/23.
//

import Foundation

enum GameListState: CustomStringConvertible, Equatable {

    case ready
    case load
    case loading
    case loaded([GameModel])
    case error(GameListIntentError)
    
    var description: String {
        switch self {
        case .ready:
            return "Ready"
        case .load:
            return "Load"
        case .loading:
            return "Loading"
        case .loaded(_):
            return "Game list model has been fetched. "
        case .error(let error):
            return "Error: \(error)"
        }
    }
    
    static func == (lhs: GameListState, rhs: GameListState) -> Bool {
        switch (lhs, rhs) {
        case (.ready, .ready):
            return true
        case (.load, .load):
            return true
        case (.loading, .loading):
            return true
        case (.loaded(let gameListModel1), .loaded(let gameListModel2)):
            return gameListModel1.elementsEqual(gameListModel2)
        default:
            return false
        }
    }
}
