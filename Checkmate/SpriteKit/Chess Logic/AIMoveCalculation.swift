//
//  AIMoveCalculation.swift
//  Checkmate
//
//  Created by Paul Scott on 12/1/20.
//

import Foundation

typealias Move = (from: Tile, to: Tile)
typealias MoveAndValue = (move: Move, value: Int)

struct AIMoveCalculation {
    static var aiDifficulty: AIDifficulty = .easy
    static var aiPlayer: PlayerID = .player2
    static var stop: Bool = false
    static var maxDepth: Int {
        switch aiDifficulty {
        case .easy:
            return SKConstants.easyDepth
        case .normal:
            return SKConstants.normalDepth
        case .hard:
            return SKConstants.hardDepth
        }
    }
    
    static func move(aiPlayer: PlayerID, aiDifficulty: AIDifficulty, board: ChessBoard) -> Move {
        self.aiPlayer = aiPlayer
        self.aiDifficulty = aiDifficulty
        return minMaxStart(board: board, player: aiPlayer)
    }
    
    private static func minMaxStart(board: ChessBoard, player: PlayerID) -> Move {
        let moves = allMovesForPlayer(player, on: board)
        if moves.isEmpty {
            return SKConstants.nilMove
        } else {
            var values: [MoveAndValue] = []
            for move in moves {
                let newBoard = board.copy()
                newBoard.movePiece(from: move.from, to: move.to)
                values.append((move: move, value: alphaBeta(
                    board: newBoard,
                    player: player.opposite(),
                    depth: SKConstants.initialDepth,
                    α: SKConstants.initialAlpha,
                    β: SKConstants.initialBeta
                )))
            }
            values.shuffle()
            if player == .player1 {
                return values.max { $0.value < $1.value }!.move
            } else {
                return values.min { $0.value < $1.value }!.move
            }
        }
    }
    
    // created with help from: https://en.wikipedia.org/wiki/Alpha–beta_pruning
    private static func alphaBeta(board: ChessBoard, player: PlayerID, depth: Int, α: Int, β: Int) -> Int {
        var alpha = α
        var beta = β
        if depth == maxDepth {
            return board.boardValue
        }
        if player == .player1 {
            var bestValue = SKConstants.initialAlpha
            outerLoop: for piece in board.piecesOnBoardForPlayer(.player1) {
                let from = board.tileFromPiece(piece)
                for move in MoveCalculation.movesFor(piece, on: board) {
                    let newBoard = board.copy()
                    newBoard.movePiece(from: from, to: move)
                    bestValue = max(bestValue, alphaBeta(
                        board: newBoard,
                        player: .player2,
                        depth: depth + 1,
                        α: alpha,
                        β: beta
                    ))
                    alpha = max(alpha, bestValue)
                    if alpha >= beta {
                        break outerLoop
                    }
                }
            }
            return bestValue
        } else {
            var bestValue = SKConstants.initialBeta
            outerLoop: for piece in board.piecesOnBoardForPlayer(.player2) {
                let from = board.tileFromPiece(piece)
                for move in MoveCalculation.movesFor(piece, on: board) {
                    let newBoard = board.copy()
                    newBoard.movePiece(from: from, to: move)
                    bestValue = min(bestValue, alphaBeta(
                        board: newBoard,
                        player: .player1,
                        depth: depth + 1,
                        α: alpha,
                        β: beta
                    ))
                    beta = min(beta, bestValue)
                    if beta <= alpha {
                        break outerLoop
                    }
                }
            }
            return bestValue
        }
    }
    
    private static func allMovesForPlayer(_ player: PlayerID, on board: ChessBoard) -> [Move] {
        var allMoves: [Move] = []
        for piece in board.piecesOnBoardForPlayer(player) {
            for move in MoveCalculation.movesFor(piece, on: board) {
                allMoves.append((from: board.tileFromPiece(piece), to: move))
            }
        }
        return allMoves
    }
}
