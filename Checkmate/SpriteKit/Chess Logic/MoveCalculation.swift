//
//  MoveCalculation.swift
//  Checkmate
//
//  Created by Paul Scott on 11/28/20.
//

import Foundation

struct MoveCalculation {
    static func movesFor(_ piece: ChessPiece, on board: ChessBoard, skipCheck: Bool = false) -> [Tile] {
        switch piece.type {
        case .pawn:
            return MoveCalculation.pawnMoves(pawn: piece, on: board, skipCheck: skipCheck)
        case .knight:
            return MoveCalculation.knightMoves(knight: piece, on: board, skipCheck: skipCheck)
        case .bishop:
            return MoveCalculation.bishopMoves(bishop: piece, on: board, skipCheck: skipCheck)
        case .rook:
            return MoveCalculation.rookMoves(rook: piece, on: board, skipCheck: skipCheck)
        case .queen:
            return MoveCalculation.queenMoves(queen: piece, on: board, skipCheck: skipCheck)
        case .king:
            return MoveCalculation.kingMoves(king: piece, on: board, skipCheck: skipCheck)
        }
    }
    
    private static func pawnMoves(pawn: ChessPiece, on board: ChessBoard, skipCheck: Bool) -> [Tile] {
        var validMoves = MoveCalculation.kingKnightPawnMoveHelper(
            piece: pawn,
            on: board,
            relativeMoves: pawnStandardMoves(pawn: pawn),
            skipCheck: skipCheck
        )
        let tile = board.tileFromPiece(pawn)
        if validMoves.count == 1 {
            if abs(validMoves[0].0 - tile.0) > 1 {
                validMoves = []
            }
        }
        validMoves += MoveCalculation.pawnDiagonalAttack(pawn: pawn, pawnTile: tile, on: board)
        return MoveCalculation.removeMovesThatPutKingInCheck(
            piece: pawn,
            on: board,
            possibleMoves: validMoves,
            skipCheck: skipCheck
        )
    }
    
    private static func pawnStandardMoves(pawn: ChessPiece) -> [Tile] {
        let relativeMoves: [Tile]
        switch (pawn.player) {
        case .player1:
            relativeMoves = pawn.moveCount == 0 ? [(2, 0), (1, 0)] : [(1, 0)]
        case .player2:
            relativeMoves = pawn.moveCount == 0 ? [(-2, 0), (-1, 0)] : [(-1, 0)]
        }
        return relativeMoves
    }
    
    private static func pawnDiagonalAttack(pawn: ChessPiece, pawnTile: Tile, on board: ChessBoard) -> [Tile] {
        var validMoves: [Tile] = []
        let diagonals = (pawn.player == .player1) ? [(1, -1), (1, 1)] : [(-1, -1), (-1, 1)]
        for diagonal in diagonals {
            let possibleMove = (pawnTile.0 + diagonal.0, pawnTile.1 + diagonal.1)
            let takenPiece = board.pieceFromTile(possibleMove)
            if (takenPiece != nil && takenPiece!.player == pawn.player.opposite()) ||
                canTakeEnPassant(pawnPlayer: pawn.player, diagonal: possibleMove, board: board) {
                validMoves.append(possibleMove)
            }
        }
        return validMoves
    }
    
    private static func canTakeEnPassant(pawnPlayer: PlayerID, diagonal: Tile, board: ChessBoard) -> Bool {
        let takenPiece = board.pieceFromTile((diagonal.0 + (pawnPlayer == .player1 ? -1 : 1), diagonal.1))
        return takenPiece != nil && takenPiece!.canTakeEnPassant
    }
    
    private static func bishopMoves(bishop: ChessPiece, on board: ChessBoard, skipCheck: Bool) -> [Tile] {
        MoveCalculation.bishopQueenRookMoveHelper(
            piece: bishop,
            on: board,
            directions: [(1, 1), (1, -1), (-1, 1), (-1, -1)],
            skipCheck: skipCheck
        )
    }
    
    private static func knightMoves(knight: ChessPiece, on board: ChessBoard, skipCheck: Bool) -> [Tile] {
        MoveCalculation.kingKnightPawnMoveHelper(
            piece: knight,
            on: board,
            relativeMoves: [
                (1, 2), (1, -2), (-1, 2), (-1, -2),
                (2, 1), (2, -1), (-2, 1), (-2, -1)
            ],
            skipCheck: skipCheck
        )
    }
    
    private static func rookMoves(rook: ChessPiece, on board: ChessBoard, skipCheck: Bool) -> [Tile] {
        MoveCalculation.bishopQueenRookMoveHelper(
            piece: rook,
            on: board,
            directions: [(1, 0), (-1, 0), (0, 1), (0, -1)],
            skipCheck: skipCheck
        ) + rookCastling(rook: rook, on: board, skipCheck: skipCheck)
    }
    
    private static func rookCastling(rook: ChessPiece, on board: ChessBoard, skipCheck: Bool) -> [Tile] {
        let king = board.kingForPlayer(rook.player)
        if canCastle(king: king, rook: rook, on: board) {
            return MoveCalculation.removeMovesThatPutKingInCheck(
                piece: rook,
                on: board,
                possibleMoves: [board.tileFromPiece(king)],
                skipCheck: skipCheck
            )
        }
        return []
    }
    
    private static func queenMoves(queen: ChessPiece, on board: ChessBoard, skipCheck: Bool) -> [Tile] {
        MoveCalculation.bishopQueenRookMoveHelper(
            piece: queen,
            on: board,
            directions: [
                (1, 0), (-1, 0), (0, 1), (0, -1),
                (1, 1), (1, -1), (-1, 1), (-1, -1)
            ],
            skipCheck: skipCheck
        )
    }
    
    private static func kingMoves(king: ChessPiece, on board: ChessBoard, skipCheck: Bool) -> [Tile] {
        MoveCalculation.kingKnightPawnMoveHelper(
            piece: king,
            on: board,
            relativeMoves: [
                (1, -1), (1, 0), (1, 1),
                (0, -1), (0, 1),
                (-1, -1), (-1, 0), (-1, 1)
            ],
            skipCheck: skipCheck
        ) + kingCastling(king: king, on: board, skipCheck: skipCheck)
    }
    
    private static func kingCastling(king: ChessPiece, on board: ChessBoard, skipCheck: Bool) -> [Tile] {
        var castleMoves: [Tile] = []
        for rook in board.rooksForPlayer(king.player) {
            if canCastle(king: king, rook: rook, on: board) {
                castleMoves.append(board.tileFromPiece(rook))
            }
        }
        return MoveCalculation.removeMovesThatPutKingInCheck(
            piece: king,
            on: board,
            possibleMoves: castleMoves,
            skipCheck: skipCheck
        )
    }
    
    private static func canCastle(king: ChessPiece, rook: ChessPiece, on board: ChessBoard) -> Bool {
        if rook.moveCount == 0 && king.moveCount == 0 {
            let kingTile = board.tileFromPiece(king)
            var tileCheck = board.tileFromPiece(rook)
            if kingTile.0 == tileCheck.0 {
                let range = abs(kingTile.1 - tileCheck.1)
                let offset = kingTile.1 - tileCheck.1 > 0 ? 1 : -1
                for _ in 0..<range {
                    tileCheck = (tileCheck.0, tileCheck.1 + offset)
                    let piece = board.pieceFromTile(tileCheck)
                    if tileCheck == kingTile {
                        return true
                    }
                    if piece != nil {
                        break;
                    }
                }
            }
        }
        return false
    }
    
    private static func kingKnightPawnMoveHelper(
        piece: ChessPiece,
        on board: ChessBoard,
        relativeMoves: [Tile],
        skipCheck: Bool
    ) -> [Tile] {
        let tile = board.tileFromPiece(piece)
        var validMoves: [Tile] = []
        for move in relativeMoves {
            let possibleMove = (tile.0 + move.0, tile.1 + move.1)
            if SharedFunctions.tileInBounds(possibleMove) {
                let takenPiece = board.pieceFromTile(possibleMove)
                if takenPiece == nil || (takenPiece!.player != piece.player && piece.type != .pawn) {
                    validMoves.append(possibleMove)
                }
            }
        }
        return MoveCalculation.removeMovesThatPutKingInCheck(
            piece: piece,
            on: board,
            possibleMoves: validMoves,
            skipCheck: skipCheck
        )
    }
    
    private static func bishopQueenRookMoveHelper(
        piece: ChessPiece,
        on board: ChessBoard,
        directions: [Tile],
        skipCheck: Bool
    ) -> [Tile] {
        let tile = board.tileFromPiece(piece)
        var validMoves: [Tile] = []
        for direction in directions {
            var possibleMove = tile
            while SharedFunctions.tileInBounds(possibleMove) {
                possibleMove = (possibleMove.0 + direction.0, possibleMove.1 + direction.1)
                if SharedFunctions.tileInBounds(possibleMove) {
                    let takenPiece = board.pieceFromTile(possibleMove)
                    if takenPiece == nil {
                        validMoves.append(possibleMove)
                    } else {
                        if takenPiece!.player != piece.player {
                            validMoves.append(possibleMove)
                        }
                        break;
                    }
                }
            }
        }
        return MoveCalculation.removeMovesThatPutKingInCheck(
            piece: piece,
            on: board,
            possibleMoves: validMoves,
            skipCheck: skipCheck
        )
    }
    
    private static func removeMovesThatPutKingInCheck(
        piece: ChessPiece,
        on board: ChessBoard,
        possibleMoves: [Tile],
        skipCheck: Bool
    ) -> [Tile] {
        var validMoves: [Tile] = []
        for move in possibleMoves {
            if !MoveCalculation.movePutsKingInCheck(
                from: board.tileFromPiece(piece),
                to: move,
                for: piece.player,
                on: board,
                skipCheck: skipCheck
            ) {
                validMoves.append(move)
            }
        }
        return validMoves
    }
    
    static func kingIsInCheck(for player: PlayerID, on board: ChessBoard, skipCheck: Bool = false) -> Bool {
        let enemyPieces = board.piecesOnBoardForPlayer(player.opposite())
        let kingPiece = board.kingForPlayer(player)
        let kingTile = board.tileFromPiece(kingPiece)
        for piece in enemyPieces {
            if SharedFunctions.isInTileList(
                tileList: MoveCalculation.movesFor(piece, on: board, skipCheck: skipCheck),
                tile: kingTile
            ) {
                return true
            }
        }
        return false
    }
    
    static func kingIsInCheckmate(for player: PlayerID, on board: ChessBoard) -> Bool {
        for piece in board.piecesOnBoardForPlayer(player) {
            if MoveCalculation.movesFor(piece, on: board).count != 0 {
                return false
            }
        }
        return true
    }
    
    private static func movePutsKingInCheck(
        from: Tile,
        to: Tile,
        for player: PlayerID,
        on board: ChessBoard,
        skipCheck: Bool
    ) -> Bool {
        if !skipCheck {
            let boardCopy = board.copy()
            boardCopy.movePiece(from: from, to: to)
            return MoveCalculation.kingIsInCheck(for: player, on: boardCopy, skipCheck: true)
        }
        return false
    }
}
