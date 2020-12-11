//
//  LoadView.swift
//  Checkmate
//
//  Created by Paul Scott on 12/6/20.
//

import SwiftUI

struct LoadView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \GameSave.time, ascending: false)],
        animation: .default
    ) private var allSaves: FetchedResults<GameSave>
    
    @ObservedObject var gameSettings: GameSettings
    @Binding var shouldShowLoadView: Bool
    @Binding var shouldShowChessView: Bool
    @Binding var shouldHideNavBar: Bool
    
    var body: some View {
        VStack {
            if allSaves.count > 0 {
                List {
                    ForEach(allSaves) { gameSave in
                        Button(action: {
                            selectSave(save: gameSave)
                            shouldShowLoadView = false
                            shouldShowChessView = true
                        }) {
                            SaveListItem(gameSave: gameSave, selectedSave: $gameSettings.selectedSave)
                        }
                    }
                }
            } else {
                Text("No Saves")
                    .font(.system(size: ViewConstants.mediumFont))
            }
        }
        .navigationTitle("Load Game")
        .onAppear {
            shouldHideNavBar = false
        }
    }
    
    private func selectSave(save: GameSave) {
        gameSettings.selectedSave = save
        gameSettings.player1 = save.player1
        gameSettings.player2 = save.player2
        if save.playingWithAI {
            gameSettings.playerCount = 1
            gameSettings.playerSide = save.playerIsFirst ? .player1 : .player2
            gameSettings.aiDifficulty = AIDifficulty(rawValue: save.aiDifficulty!)!
        } else {
            gameSettings.playerCount = 2
            gameSettings.timeLimit = Int(save.timeLimit)
        }
    }
}
