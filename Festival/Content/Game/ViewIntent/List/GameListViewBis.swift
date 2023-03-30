//
//  GameListViewBis.swift
//  Festival
//
//  Created by Tom Sartori on 3/8/23.
//

import SwiftUI

struct GameListViewBis: View {
    
    @ObservedObject public var gameListModel: GameListModel
    @State private var gamePopover: GameModel?
    @State private var intent: GameListIntent
    
    @State private var showingPopoverCreate = false
    @State private var showingPopoverUpdate = false
    
    @State private var searchText = ""
    
    
    init() {
        let gameListModel = GameListModel()
        
        self.gameListModel = gameListModel
        self.intent = GameListIntent(gameListModel: gameListModel)
    }
    
    
    var body: some View {
        //        ProgressView().isVisible(isLoading())
        NavigationStack {
            List {
                ForEach(gameListModel, id:\.self) { game in
                    Button(game.name) {
                        self.gamePopover = game
                        self.showingPopoverUpdate = true
                    }
                }
            }
            .refreshable() {
                self.intent.load()
            }
            .navigationTitle("Nos jeux")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Add") {
                        showingPopoverCreate = true
                    }
                    .popover(isPresented: $showingPopoverCreate) {
                        GameUpdateView()
                            .padding()
                            .background(Color(UIColor.systemGroupedBackground))
                    }
                }
            }
        }
        .onAppear() {
            self.intent.load()
        }
        .popover(isPresented: $showingPopoverUpdate) {
            if gamePopover != nil {
                GameUpdateView(game: gamePopover!)
                    .padding()
                    .background(Color(UIColor.systemGroupedBackground))
            }
        }
        .searchable(text: $searchText) {
            if searchResults.isEmpty {
                Text("Aucun résultat")
            }
            else {
                ForEach(searchResults, id:\.self) { game in
                    Button(game.name) {
                        self.gamePopover = game
                        self.showingPopoverUpdate = true
                    }
                }
            }
        }
        
        //            .onReceive(gameListModel.$gameModelList, perform: { _ in
        //                debugPrint("UPDATING")
        //                intent.load()
        //            })
    }
    
    private func isLoading() -> Bool {
        gameListModel.state == .loading
    }
    
    var searchResults: [GameModel] {
        if searchText.isEmpty {
            return gameListModel.gameModelList
        } else {
            return gameListModel.gameModelList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct GameListViewBis_Previews: PreviewProvider {
    static var previews: some View {
        GameListViewBis()
    }
}
