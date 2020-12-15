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
    var player1Pieces: [ChessPiece] = []
    var player2Pieces: [ChessPiece] = []
    var player1King: ChessPiece?
    var player2King: ChessPiece?
    var enPassantPiece: ChessPiece?
    
    var boardValue: Int {
        let allPieces = piecesForPlayer(.player1) + piecesForPlayer(.player2)
        var boardValue = 0
        for piece in allPieces {
            boardValue += piece.value
        }
        return boardValue
    }

    init(initPieces: Bool = true) {
        initBoard()
        if initPieces {
            addPiecesFor(player: .player1)
            addPiecesFor(player: .player2)
        }
    }
    
    func copy() -> ChessBoard {
        let boardCopy = ChessBoard(initPieces: false)
        for piece in player1Pieces + player2Pieces {
            let pieceCopy = piece.copy()
            boardCopy.addPiece(pieceCopy, at: pieceCopy.tile)
            if pieceCopy.type == .king {
                if pieceCopy.player == .player1 {
                    boardCopy.player1King = pieceCopy
                } else {
                    boardCopy.player2King = pieceCopy
                }
            }
            if enPassantPiece != nil && enPassantPiece == pieceCopy {
                boardCopy.enPassantPiece = pieceCopy
            }
        }
        return boardCopy
    }
    
    func initBoard() {
        var newBoard: [[ChessPiece?]] = []
        for row in SKConstants.boardRange {
            newBoard.append([])
            for _ in SKConstants.boardRange {
                newBoard[row].append(nil)
            }
        }
        board = newBoard
    }

    func addPiecesFor(player: PlayerID) {
        let kingRowPieces: [ChessPieceType] = [.rook, .knight, .bishop, .queen, .king, .bishop, .knight, .rook]
        for index in 0..<8 {
            let pawn = ChessPiece(belongsTo: player, type: .pawn, tile: (player == .player1 ? 1 : 6, index))
            let piece = ChessPiece(belongsTo: player, type: kingRowPieces[index], tile: (player == .player1 ? 0 : 7, index))
            addPiece(pawn, at: pawn.tile)
            addPiece(piece, at: piece.tile)
            if kingRowPieces[index] == .king {
                if player == .player1 {
                    player1King = piece
                } else {
                    player2King = piece
                }
            }
        }
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
            removePiece(at: to)
            if chessScene != nil {
                takenPiece?.sprite.removeFromParent()
            }
            board[to.0][to.1] = piece
            board[to.0][to.1]?.tile = to
            if (to.0 == 7 || to.0 == 0) && piece!.type == .pawn {
                pawnToQueen(oldPiece: piece!, to: to, chessScene: chessScene)
            }
            let enPassantTile = (to.0 + (piece!.player == .player1 ? -1 : 1), to.1)
            let enPassantPiece = pieceFromTile(enPassantTile)
            if enPassantPiece != nil && enPassantPiece!.canTakeEnPassant {
                removePiece(at: enPassantTile)
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
            board[toPieceTile.0][3]?.tile = (toPieceTile.0, 3)
            board[toPieceTile.0][2]?.tile = (toPieceTile.0, 2)
            if chessScene != nil {
                chessScene!.toTile = (toPieceTile.0, fromPiece.type == .rook ? 3 : 2)
                chessScene!.animateMove(piece: toPiece, to: (toPieceTile.0, fromPiece.type == .rook ? 2 : 3)) {}
            }
        } else {
            board[toPieceTile.0][5] = fromPiece.type == .rook ? fromPiece : toPiece
            board[toPieceTile.0][6] = fromPiece.type == .rook ? toPiece : fromPiece
            board[toPieceTile.0][5]?.tile = (toPieceTile.0, 5)
            board[toPieceTile.0][6]?.tile = (toPieceTile.0, 6)
            if chessScene != nil {
                chessScene!.toTile = (toPieceTile.0, fromPiece.type == .rook ? 5 : 6)
                chessScene!.animateMove(piece: toPiece, to: (toPieceTile.0, fromPiece.type == .rook ? 6 : 5)) {}
            }
        }
    }
    
    private func pawnToQueen(oldPiece: ChessPiece, to tile: Tile, chessScene: ChessScene?) {
        removePiece(at: tile)
        addPiece(ChessPiece(belongsTo: oldPiece.player, type: .queen, tile: tile), at: tile)
        if chessScene != nil {
            oldPiece.sprite.removeFromParent()
            board[tile.0][tile.1]!.sprite.position = oldPiece.sprite.position
            chessScene?.addChild(board[tile.0][tile.1]!.sprite)
            chessScene?.selectedPiece = board[tile.0][tile.1]
        }
    }

    func addPiece(_ piece: ChessPiece, at tile: Tile) {
        if piece.player == .player1 {
            player1Pieces.append(piece)
        } else {
            player2Pieces.append(piece)
        }
        board[tile.0][tile.1] = piece;
    }

    private func removePiece(at tile: Tile) {
        let piece = pieceFromTile(tile)
        if piece != nil {
            for (index, p) in piecesForPlayer(piece!.player).enumerated() {
                if p == piece {
                    if piece!.player == .player1 {
                        player1Pieces.remove(at: index)
                    } else {
                        player2Pieces.remove(at: index)
                    }
                    break
                }
            }
            board[tile.0][tile.1] = nil
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
    
    func pieceFromTile(_ tile: Tile) -> ChessPiece? {
        SharedFunctions.tileInBounds(tile) ? board[tile.0][tile.1] : nil
    }
    
    func piecesForPlayer(_ player: PlayerID) -> [ChessPiece] {
        player == .player1 ? player1Pieces : player2Pieces
    }
    
    func kingForPlayer(_ player: PlayerID) -> ChessPiece {
        player == .player1 ? player1King! : player2King!
    }
    
    func rooksForPlayer(_ player: PlayerID) -> [ChessPiece] {
        let playerPieces = piecesForPlayer(player)
        var rooks: [ChessPiece] = []
        for piece in playerPieces {
            if piece.type == .rook {
                rooks.append(piece)
            }
        }
        return rooks
    }
}
