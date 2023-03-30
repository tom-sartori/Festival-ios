//
// Created by Tom Sartori on 3/6/23.
//

import Foundation

enum GameIntentError: CustomStringConvertible, Equatable {
    
    case tooShortName(String)
    case error(String)
    
    var description: String {
        switch self {
        case .tooShortName:
            return "Too short name. "
        case .error(let message):
            return "Error : \(message)"
        }
    }
    
    static func ==(lhs: GameIntentError, rhs: GameIntentError) -> Bool {
        switch (lhs, rhs) {
        case (.tooShortName(let name1), .tooShortName(let name2)):
            return name1 == name2
        default:
            return false
        }
    }
}
