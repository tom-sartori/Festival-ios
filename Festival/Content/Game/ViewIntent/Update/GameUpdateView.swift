//
//  GameDetailView.swift
//  Festival
//
//  Created by Tom Sartori on 3/8/23.
//

import SwiftUI

struct GameUpdateView: View {
    
    private var isCreating: Bool
    private var isUpdating: Bool
    
    @State public var game: GameModel
    @State private var intent: GameIntent
    
    init() {
        self.isCreating = true
        self.isUpdating = false
        
        let game: GameModel = GameModel()
        
        self.game = game
        self.intent = GameIntent(game: game)
    }
    
    init(game: GameModel) {
        self.isCreating = false
        self.isUpdating = true
        
        self.game = game
        self.intent = GameIntent(game: game)
    }
    
    var body: some View {
        VStack {
            Text(isCreating ? "Création" : "Mise à jour")
            Form {
                Section {
                    TextField("Nom du jeu", text: $game.name)
                    TextField("Type de jeu", text: $game.type)
                }
                Section {
                    Button("Créer", action: create).isVisible(isCreating)
                    
                    Button("Valider", action: update).isVisible(isUpdating)
                }
                Section {
                    Button("Supprimer", action: delete)
                }.isVisible(isUpdating)
            }
        }
    }
    
    private func create() {
        /// TODO : Refactor.
        //        var game: GameModel = GameModel(name: game.name, type: game.type)
        self.intent.create(game: self.game)
    }
    
    private func update() {
        /// TODO : Refactor.
        //        var game: GameModel = GameModel(name: game.name, type: game.type)
        self.intent.update(id: self.game.id, game: self.game)
    }
    
    private func delete() {
        self.intent.delete(id: self.game.id)
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameUpdateView()
    }
}
