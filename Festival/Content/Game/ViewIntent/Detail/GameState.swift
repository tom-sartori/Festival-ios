//
// Created by Tom Sartori on 3/6/23.
//

import Foundation

enum GameState: CustomStringConvertible, Equatable {
    
    case ready
    case creating
    case updating
    case deleting
    case error(GameIntentError)
    
    
    var description: String {
        switch self {
        case .ready:
            return "Ready"
        case .creating:
            return "Creating a game. "
        case .updating:
            return "Updating a game. "
        case .deleting:
            return "Deleting a game. "
        case .error(let error):
            return "Error: \(error)"
        }
    }
    
    static func ==(lhs: GameState, rhs: GameState) -> Bool {
        /// TODO
        switch (lhs, rhs) {
        case (.ready, .ready):
            return true
        default:
            return false
        }
    }
}
