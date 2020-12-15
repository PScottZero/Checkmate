//
//  GameButtons.swift
//  Checkmate
//
//  Created by Paul Scott on 12/8/20.
//

import SwiftUI

struct GameButtons: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var gameSettings: GameSettings
    @ObservedObject var chessScene: ChessScene
    let player1Time: Int
    let player2Time: Int
    @Binding var shouldShowChessView: Bool
    
    private var disableExit: Bool {
        return chessScene.aiTurn == chessScene.turn && !chessScene.gameOver && chessScene.playingWithAI
    }
    
    private var gameImage: Data {
        chessScene.drawChessGrid(forImage: true)
        let image = chessScene.view?.texture(from: chessScene.scene!)?.cgImage()
        chessScene.drawChessGrid()
        return UIImage(cgImage: image!).jpegData(compressionQuality: 75)!
    }
    
    var formattedTime: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    var disableSaveAndGiveUp: Bool {
        disableExit || chessScene.gameOver || chessScene.isFirstMove
    }

    var body: some View {
        HStack {
            RoundedAlertButton(
                "Give Up",
                message: "Are you sure you want to give up?",
                actionText: "Give Up",
                disabled: disableSaveAndGiveUp
            ) {
                giveUp()
                shouldShowChessView = false
            }
            RoundedButton("Save", disabled: disableSaveAndGiveUp) {
                saveGame()
                shouldShowChessView = false
            }
            RoundedAlertButton(
                "Exit",
                message: "Are you sure you want to exit this game?",
                actionText: "Exit",
                disabled: disableExit
            ) {
                if chessScene.gameOver {
                    adjustRatings()
                }
                shouldShowChessView = false
            }
        }
    }
    
    private func saveGame() {
        let gameSave = gameSettings.selectedSave ?? GameSave(context: viewContext)
        gameSave.isPlayer1Turn = chessScene.turn == .player1
        gameSave.time = formattedTime
        gameSave.timeLimit = Int16(gameSettings.timeLimit)
        gameSave.player1 = gameSettings.player1!
        gameSave.playingWithAI = gameSettings.playerCount == 1
        gameSave.image = gameImage
        if gameSettings.playerCount == 1 {
            gameSave.playerIsFirst = gameSettings.playerSide == .player1
            gameSave.aiDifficulty = gameSettings.aiDifficulty.rawValue
        } else {
            gameSave.player2 = gameSettings.player2
            gameSave.player1TimeLeft = Int16(player1Time)
            gameSave.player2TimeLeft = Int16(player2Time)
        }
        for piece in Array(gameSave.pieces) {
            Delete.piece(piece)
        }
        let allPieces = chessScene.board.piecesForPlayer(.player1) + chessScene.board.piecesForPlayer(.player2)
        for piece in allPieces {
            let pieceMO = Piece(context: viewContext)
            pieceMO.row = Int16(piece.tile.0)
            pieceMO.column = Int16(piece.tile.1)
            pieceMO.moveCount = Int16(piece.moveCount)
            pieceMO.canTakeEnPassant = piece.canTakeEnPassant
            pieceMO.type = piece.type.rawValue
            pieceMO.belongsToPlayer1 = piece.player == .player1
            gameSave.addToPieces(pieceMO)
        }
    }
    
    private func adjustRatings() {
        if !chessScene.playingWithAI {
            if chessScene.turn.opposite() == .player1 {
                player1Won()
            } else {
                player2Won()
            }
        } else {
            if chessScene.turn.opposite() == gameSettings.playerSide {
                player1Won()
            } else {
                player2Won()
            }
        }
    }
    
    private func giveUp() {
        if chessScene.playingWithAI {
            player2Won()
        } else {
            if chessScene.turn == .player1 {
                player2Won()
            } else {
                player1Won()
            }
        }
    }
    
    private func player1Won() {
        gameSettings.player1?.wins += 1
        gameSettings.player1?.rating += 10
        if !chessScene.playingWithAI {
            gameSettings.player2?.losses += 1
            gameSettings.player2?.rating -= 10
        }
    }
    
    private func player2Won() {
        if !chessScene.playingWithAI {
            gameSettings.player2?.wins += 1
            gameSettings.player2?.rating += 10
        }
        gameSettings.player1?.losses += 1
        gameSettings.player1?.rating -= 10
    }
}
