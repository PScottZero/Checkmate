//
//  PieceSet.swift
//  Checkmate
//
//  Created by Paul Scott on 11/11/20.
//

import Foundation
import SpriteKit

struct PieceSet {
    var king: ChessPiece // direct access to king piece
    
    init(belongsTo player: PlayerID, isOnBoard board: ChessBoard) {
        
        // add king and queen
        let row = player == .player1 ? 0 : 7
        king = ChessPiece(belongsTo: player, type: .king)
        board.addPiece(ChessPiece(belongsTo: player, type: .queen), tile: (row, 3))
        board.addPiece(king, tile: (row, 4))

        // add bishops, knights, and rooks
        let bishopLocations = [2, 5]
        let knightLocations = [1, 6]
        let rookLocations = [0, 7]
        for index in 0..<2 {
            board.addPiece(ChessPiece(belongsTo: player, type: .knight), tile: (row, knightLocations[index]))
            board.addPiece(ChessPiece(belongsTo: player, type: .bishop), tile: (row, bishopLocations[index]))
            board.addPiece(ChessPiece(belongsTo: player, type: .rook), tile: (row, rookLocations[index]))
        }
        
        // add pawns
        let pawnRow = player == .player1 ? 1 : 6
        for index in 0..<8 {
            board.addPiece(ChessPiece(belongsTo: player, type: .pawn), tile: (pawnRow, index))
        }
    }
}
