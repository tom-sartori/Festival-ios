//
// Created by Tom Sartori on 3/6/23.
//

import Foundation

class GameListModel: RandomAccessCollection, ObservableObject, Decodable {
    
    @Published public var gameModelList: [GameModel];
    
    @Published var state: GameListState = .ready {
        didSet {
            switch state {
            case .ready:
                debugPrint("GameListModel : ready")
            case .load:
                debugPrint("GameListModel : load")
            case .loading:
                debugPrint("GameListModel : loading")
            case .loaded(let data):
                debugPrint("GameListModel : load")
                gameModelList = data
                state = .ready
            default:
                break
            }
        }
    }
    
    
    init() {
        self.gameModelList = []
    }
    
    private enum CodingKeys: String, CodingKey {
        case gameListModel
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        gameModelList = try container.decode([GameModel].self, forKey: .gameListModel)
    }
    
    subscript(index: Int) -> GameModel {
        get {
            gameModelList[index]
        }
        set {
            gameModelList[index] = newValue
        }
    }
    
    var startIndex: Int {
        gameModelList.startIndex
    }
    
    var endIndex: Int {
        gameModelList.endIndex
    }
    
    func index(after i: Int) -> Int {
        gameModelList.index(after: i)
    }
    
    func remove(atOffsets: IndexSet) {
        gameModelList.remove(atOffsets: atOffsets)
    }
    
    func move(fromOffsets: IndexSet, toOffset: Int) {
        gameModelList.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func updated() {
        objectWillChange.send()
    }
}
