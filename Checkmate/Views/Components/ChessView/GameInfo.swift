//
//  GameInfo.swift
//  Checkmate
//
//  Created by Paul Scott on 12/8/20.
//

import SwiftUI

struct GameInfo: View {
    @ObservedObject var gameSettings: GameSettings
    @ObservedObject var chessScene: ChessScene
    @Binding var player1Time: Int
    @Binding var player2Time: Int
    @Binding var player1PauseTimer: Bool
    @Binding var player2PauseTimer: Bool
    
    var body: some View {
        GameStatus(gameSettings: gameSettings, chessScene: chessScene)
        HStack {
            if !chessScene.playingWithAI && gameSettings.player2 != nil {
                PlayerInfoAndTimer(
                    player: $gameSettings.player1,
                    image: gameSettings.player1?.image,
                    playerNumber: .player1,
                    timeLeft: $player1Time,
                    timeLimit: gameSettings.timeLimit,
                    pause: $player1PauseTimer,
                    gameOver: $chessScene.gameOver
                )
                Spacer()
                PlayerInfoAndTimer(
                    player: $gameSettings.player2,
                    image: gameSettings.player2?.image,
                    playerNumber: .player2,
                    timeLeft: $player2Time,
                    timeLimit: gameSettings.timeLimit,
                    pause: $player2PauseTimer,
                    gameOver: $chessScene.gameOver
                )
            }
        }
        .onReceive(chessScene.$turn) { _ in
            player1PauseTimer.toggle()
            player2PauseTimer.toggle()
        }
    }
}
