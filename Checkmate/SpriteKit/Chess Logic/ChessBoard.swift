//
//  ChessBoard.swift
//  Checkmate
//
//  Created by Paul Scott on 11/11/20.
//

import Foundation
import SpriteKit

typealias Tile = (Int, Int)

class ChessBoard {
    var board: [[ChessPiece?]] = []
    var player1King: ChessPiece?
    var player2King: ChessPiece?
    var enPassantPiece: ChessPiece?
    
    var boardValue: Int {
        let allPieces = piecesOnBoardForPlayer(.player1) + piecesOnBoardForPlayer(.player2)
        var boardValue = 0
        for piece in allPieces {
            boardValue += piece.value
        }
        return boardValue
    }

    init() { resetBoard() }
    
    func copy() -> ChessBoard {
        let boardCopy = ChessBoard()
        for row in 0..<board.count {
            for column in 0..<board[row].count {
                boardCopy.board[row][column] = self.board[row][column]?.copy()
            }
        }
        boardCopy.player1King = self.player1King?.copy()
        boardCopy.player2King = self.player2King?.copy()
        boardCopy.enPassantPiece = self.enPassantPiece?.copy()
        return boardCopy
    }
    
    func resetBoard() {
        var newBoard: [[ChessPiece?]] = []
        for row in SKConstants.boardRange {
            newBoard.append([])
            for _ in SKConstants.boardRange {
                newBoard[row].append(nil)
            }
        }
        board = newBoard
    }
    
    func addPiece(_ piece: ChessPiece, tile: Tile) {
        board[tile.0][tile.1] = piece
    }
    
    func movePiece(from: Tile, to: Tile, chessScene: ChessScene? = nil) {
        let piece = board[from.0][from.1]
        let takenPiece = board[to.0][to.1]
        piece?.moveCount += 1
        if takenPiece?.player == piece?.player {
            takenPiece!.moveCount += 1
            castling(fromPiece: piece!, at: from, toPiece: takenPiece!, at: to, chessScene: chessScene)
        } else {
            board[from.0][from.1] = nil
            if chessScene != nil {
                takenPiece?.sprite.removeFromParent()
            }
            board[to.0][to.1] = piece
            if (to.0 == 7 || to.0 == 0) && piece!.type == .pawn {
                pawnToQueen(oldPiece: piece!, to: to, chessScene: chessScene)
            }
            let enPassantTile = (to.0 + (piece!.player == .player1 ? -1 : 1), to.1)
            let enPassantPiece = pieceFromTile(enPassantTile)
            if enPassantPiece != nil && enPassantPiece!.canTakeEnPassant {
                board[enPassantTile.0][enPassantTile.1] = nil
                if chessScene != nil {
                    enPassantPiece!.sprite.removeFromParent()
                }
            }
        }
        resetEnPassantStatus()
        setEnPassantStatus(for: piece!, from: from, to: to)
    }
    
    private func castling(fromPiece: ChessPiece, at fromPieceTile: Tile, toPiece: ChessPiece, at toPieceTile: Tile, chessScene: ChessScene?) {
        board[fromPieceTile.0][fromPieceTile.1] = nil
        board[toPieceTile.0][toPieceTile.1] = nil
        if fromPieceTile.1 == 0 || toPieceTile.1 == 0 {
            board[toPieceTile.0][3] = fromPiece.type == .rook ? fromPiece : toPiece
            board[toPieceTile.0][2] = fromPiece.type == .rook ? toPiece : fromPiece
            if chessScene != nil {
                chessScene!.toTile = (toPieceTile.0, fromPiece.type == .rook ? 3 : 2)
                chessScene!.animateMove(piece: toPiece, to: (toPieceTile.0, fromPiece.type == .rook ? 2 : 3)) {}
            }
        } else {
            board[toPieceTile.0][5] = fromPiece.type == .rook ? fromPiece : toPiece
            board[toPieceTile.0][6] = fromPiece.type == .rook ? toPiece : fromPiece
            if chessScene != nil {
                chessScene!.toTile = (toPieceTile.0, fromPiece.type == .rook ? 5 : 6)
                chessScene!.animateMove(piece: toPiece, to: (toPieceTile.0, fromPiece.type == .rook ? 6 : 5)) {}
            }
        }
    }
    
    private func pawnToQueen(oldPiece: ChessPiece, to tile: Tile, chessScene: ChessScene?) {
        board[tile.0][tile.1] = ChessPiece(belongsTo: oldPiece.player, type: .queen)
        if chessScene != nil {
            oldPiece.sprite.removeFromParent()
            board[tile.0][tile.1]!.sprite.position = oldPiece.sprite.position
            chessScene?.addChild(board[tile.0][tile.1]!.sprite)
            chessScene?.selectedPiece = board[tile.0][tile.1]
        }
    }
    
    private func setEnPassantStatus(for piece: ChessPiece, from: Tile, to: Tile) {
        if piece.type == .pawn && abs(from.0 - to.0) == 2 {
            piece.canTakeEnPassant = true
            enPassantPiece = piece
        }
    }
    
    private func resetEnPassantStatus() {
        enPassantPiece?.canTakeEnPassant = false
    }
    
    func tileFromPiece(_ chessPiece: ChessPiece) -> Tile {
        for row in SKConstants.boardRange {
            for column in SKConstants.boardRange {
                if chessPiece == board[row][column] {
                    return (row, column)
                }
            }
        }
        return SKConstants.invalidTile
    }
    
    func pieceFromTile(_ tile: Tile) -> ChessPiece? {
        return SharedFunctions.tileInBounds(tile) ? board[tile.0][tile.1] : nil
    }
    
    func piecesOnBoardForPlayer(_ player: PlayerID) -> [ChessPiece] {
        var pieces: [ChessPiece] = []
        for row in board {
            for piece in row {
                if piece != nil && piece!.player == player {
                    pieces.append(piece!)
                }
            }
        }
        return pieces
    }
    
    func kingForPlayer(_ player: PlayerID) -> ChessPiece {
        return player == .player1 ? player1King! : player2King!
    }
    
    func rooksForPlayer(_ player: PlayerID) -> [ChessPiece] {
        let piecesForPlayer = piecesOnBoardForPlayer(player)
        var rooks: [ChessPiece] = []
        for piece in piecesForPlayer {
            if piece.type == .rook {
                rooks.append(piece)
            }
        }
        return rooks
    }
}
