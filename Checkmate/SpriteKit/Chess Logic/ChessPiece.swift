//
//  ChessPiece.swift
//  Checkmate
//
//  Created by Paul Scott on 11/11/20.
//

import Foundation
import SpriteKit

enum ChessPieceType: String {
    case pawn, rook, knight, bishop, king, queen
}

class ChessPiece: Equatable, Identifiable {
    static func == (lhs: ChessPiece, rhs: ChessPiece) -> Bool {
        lhs.sprite == rhs.sprite
    }
    
    var moveCount: Int = 0
    var type: ChessPieceType
    var sprite: SKSpriteNode
    var player: PlayerID
    var value: Int = 0
    var canTakeEnPassant: Bool = false
    var tile: Tile
    
    init(
        belongsTo player: PlayerID,
        type: ChessPieceType,
        tile: Tile
    ) {
        self.type = type
        sprite = SKSpriteNode(imageNamed: "\(type.rawValue)_\(player == .player1 ? "white" : "black")")
        sprite.zPosition = SKConstants.pieceZPosition
        sprite.size = SKConstants.spriteSize
        self.player = player
        self.tile = tile
        value = pieceValue(type: type, player: player)
    }
    
    init(_ existingPiece: ChessPiece) {
        type = existingPiece.type
        sprite = existingPiece.sprite
        player = existingPiece.player
        value = existingPiece.value
        tile = existingPiece.tile
    }
    
    func copy() -> ChessPiece { ChessPiece(self) }
    
    private func pieceValue(type: ChessPieceType, player: PlayerID) -> Int {
        let value: Int
        switch type {
        case .pawn:
            value = 1
        case .knight, .bishop:
            value = 3
        case .rook:
            value = 5
        case .queen:
            value = 9
        case .king:
            value = 999
        }
        return player == .player1 ? value : -value
    }
}
