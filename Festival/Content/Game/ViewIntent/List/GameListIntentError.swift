//
//  GameListIntentError.swift
//  Festival
//
//  Created by Tom Sartori on 3/13/23.
//

import Foundation

enum GameListIntentError: CustomStringConvertible, Equatable {
    
    case error(String)
    
    var description: String {
        switch self {
        case .error:
            return "GameListIntentError error. "
        }
    }
    
    static func ==(lhs: GameListIntentError, rhs: GameListIntentError) -> Bool {
        switch (lhs, rhs) {
            case (.error(let message1), .error(let message2)):
                return message1 == message2
        }
    }
}
