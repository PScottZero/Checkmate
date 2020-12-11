//
//  ChessSettings.swift
//  Checkmate
//
//  Created by Paul Scott on 12/8/20.
//

import SwiftUI

struct ChessSettings: View {
    @ObservedObject var gameSettings: GameSettings
    @Binding var shouldHideNavBar: Bool
    
    var body: some View {
        PlayerCountPicker(playerCount: $gameSettings.playerCount)
        if gameSettings.playerCount == 2 {
            TimeLimitPicker(minutes: $gameSettings.timeLimit)
        } else {
            AIDifficultyPicker(aiDifficulty: $gameSettings.aiDifficulty)
            PieceColorPicker(playerSide: $gameSettings.playerSide)
        }
        UserSelector(
            selectedPlayer: $gameSettings.player1,
            playerNo: ViewConstants.player1,
            shouldHideNavBar: $shouldHideNavBar
        )
        if gameSettings.playerCount == 2 {
            UserSelector(
                selectedPlayer: $gameSettings.player2,
                playerNo: ViewConstants.player2,
                shouldHideNavBar: $shouldHideNavBar
            )
        }
    }
}
