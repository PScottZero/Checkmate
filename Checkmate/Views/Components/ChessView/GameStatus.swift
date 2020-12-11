//
//  GameStatus.swift
//  Checkmate
//
//  Created by Paul Scott on 12/8/20.
//

import SwiftUI

struct GameStatus: View {
    @ObservedObject var gameSettings: GameSettings
    let chessScene: ChessScene
    
    private let ellipseTimer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State private var ellipseCount = 0
    
    private var winner: String {
        if chessScene.playingWithAI {
            return chessScene.turn.opposite() == gameSettings.playerSide ? "You Win!" : "You Lose :("
        } else {
            return chessScene.turn.opposite() == .player1 ?
                "\(gameSettings.player1!.name) Wins!" : "\(gameSettings.player2!.name) Wins!"
        }
    }
    
    private var status: String {
        if chessScene.playingWithAI {
            return chessScene.turn == chessScene.aiTurn ?
                "AI (\(gameSettings.aiDifficulty.rawValue.capitalized)) Is Thinking\(ellipse)" : "Your Turn"
        } else {
            return "\(currentPlayerName)'s Turn"
        }
    }
    
    private var ellipse: String {
        return String(repeating: ".", count: ellipseCount)
    }
    
    private var currentPlayerName: String {
        if gameSettings.player2 != nil {
            return chessScene.turn == .player1 ? gameSettings.player1!.name : gameSettings.player2!.name
        } else {
            return ""
        }
    }
    
    var body: some View {
        if chessScene.gameOver {
            Text(winner)
                .font(.system(size: ViewConstants.mediumFont))
                .foregroundColor(.white)
                .padding()
        } else {
            Text("\(status)")
                .font(.system(size: ViewConstants.mediumFont))
                .foregroundColor(.white)
                .padding()
                .onReceive(ellipseTimer) { _ in
                    adjustEllipseCount()
                }
        }
    }
    
    private func adjustEllipseCount() {
        ellipseCount += 1
        if ellipseCount > 3 {
            ellipseCount = 0
        }
    }
}
