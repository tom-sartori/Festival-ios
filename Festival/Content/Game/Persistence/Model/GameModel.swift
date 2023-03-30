//
// Created by Tom Sartori on 3/6/23.
//

import Foundation

class GameModel: Equatable, Hashable, ObservableObject, Codable {
    
    @Published public var id: String
    @Published public var name: String
    @Published public var type: String
    
    @Published var state: GameState = .ready {
        didSet {
            switch state {
            case .ready:
                debugPrint("GameModel : ready. ")
            case .creating:
                debugPrint("GameModel : creating. ")
            case .updating:
                debugPrint("GameModel : updating. ")
            case .deleting:
                debugPrint("GameModel : deleting. ")
            case .error(_):
                debugPrint("GameModel : error. ")
//            default:
//                break
            }
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
    }
    
    init(id: String, name: String, type: String) {
        self.id = id
        self.name = name
        self.type = type
    }
    
    init(name: String, type: String) {
        self.id = "";
        self.name = name
        self.type = type
    }
    
    init() {
        self.id = ""
        self.name = ""
        self.type = ""
    }
    
    /**
     Equatable function to compare two GameModel objects.
     Function must be implemented for Equatable and Hashable to work.
     
     - Parameters:
     - lhs: left hand side of the comparison.
     - rhs: right hand side of the comparison.
     
     - Returns: true if the two objects are equal, false otherwise.
     */
    static func ==(lhs: GameModel, rhs: GameModel) -> Bool {
        lhs.id == rhs.id
    }
    
    /**
     Hashes the id into the given hasher.
     Function must be implemented for Equatable and Hashable to work.
     
     - Parameter hasher: The hasher to use when combining the components of this value.>
     */
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
