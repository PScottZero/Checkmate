//
//  ChessView.swift
//  Checkmate
//
//  Created by Paul Scott on 11/10/20.
//

import SwiftUI
import SpriteKit
import Combine

struct ChessView: View {
    @ObservedObject var gameSettings: GameSettings
    @Binding var shouldShowChessView: Bool
    
    @ObservedObject var chessScene: ChessScene
    @State var player1Time: Int = 0
    @State var player2Time: Int = 0
    @State var player1PauseTimer: Bool = false
    @State var player2PauseTimer: Bool = true
    
    init(gameSettings: GameSettings, shouldShowChessView: Binding<Bool>) {
        self.gameSettings = gameSettings
        self._shouldShowChessView = shouldShowChessView
        self.chessScene = ChessScene(size: ViewConstants.chessSceneSize, gameSettings: gameSettings)
    }
    
    var body: some View {
        VStack {
            Spacer()
            SpriteView(scene: chessScene)
                .frame(width: ViewConstants.chessFrameSize, height: ViewConstants.chessFrameSize)
                .clipShape(RoundedRectangle(cornerRadius: ViewConstants.cornerRadius))
                .background(
                    RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
                        .stroke(Color.white, lineWidth: ViewConstants.largeLineWidth)
                )
                .shadow(radius: ViewConstants.largeShadow)
            GameInfo(
                gameSettings: gameSettings,
                chessScene: chessScene,
                player1Time: $player1Time,
                player2Time: $player2Time,
                player1PauseTimer: $player1PauseTimer,
                player2PauseTimer: $player2PauseTimer
            )
            Spacer()
            GameButtons(
                gameSettings: gameSettings, 
                chessScene: chessScene,
                player1Time: player1Time,
                player2Time: player2Time,
                shouldShowChessView: $shouldShowChessView
            )
        }
        .navigationBarHidden(true)
        .padding()
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
        .background(gameSettings.theme.backgroundColor)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .onAppear { reset() }
    }
    
    private func reset() {
        chessScene.resetGame()
        if gameSettings.selectedSave != nil {
            player1Time = Int(gameSettings.selectedSave!.player1TimeLeft)
            player2Time = Int(gameSettings.selectedSave!.player2TimeLeft)
            if gameSettings.selectedSave!.isPlayer1Turn {
                player1PauseTimer = false
                player2PauseTimer = true
            } else {
                player1PauseTimer = true
                player2PauseTimer = false
            }
        } else {
            player1Time = gameSettings.timeLimit * ViewConstants.timerMultiplier
            player2Time = gameSettings.timeLimit * ViewConstants.timerMultiplier
        }
    }
}
