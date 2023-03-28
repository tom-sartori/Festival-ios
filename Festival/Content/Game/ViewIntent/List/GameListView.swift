//
//  GameListView.swift
//  Festival
//
//  Created by Tom Sartori on 3/8/23.
//

import SwiftUI

struct GameListView: View {
    
    @ObservedObject public var gameListModel: GameListModel
    @State private var intent: GameListIntent
        
    
    init() {
        let gameListModel = GameListModel()
        
        self.gameListModel = gameListModel
        self.intent = GameListIntent(gameListModel: gameListModel)
    }
    
    
    var body: some View {
        NavigationStack {
            ProgressView().isVisible(isLoading())
            
            List {
                ForEach(gameListModel, id:\.self) { game in
                    NavigationLink(destination: GameUpdateView(game: game)) {
                        Text(game.name)
                    }
                }
                .onDelete { (indexSet: IndexSet) in
                    gameListModel.remove(atOffsets: indexSet)
                }
            }
            .refreshable() {
                self.intent.load()
            }
            .navigationTitle("Nos jeux")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: GameUpdateView()) {
                        Text("Add")
                    }
                }
            }
        }
        .onAppear() {
            self.intent.load()
        }
        /// TODO: If the list is empty.
    }
    
    private func isLoading() -> Bool {
        gameListModel.state == .loading
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
    }
}
