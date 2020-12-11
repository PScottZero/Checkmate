//
//  ChessScene.swift
//  Checkmate
//
//  Created by Paul Scott on 11/10/20.
//

import Foundation
import SpriteKit
import AVFoundation

enum PlayerID: String {
    case player1, player2
    
    mutating func toggle() {
        self = self.opposite()
    }
    
    func opposite() -> PlayerID {
        return (self == .player1) ? .player2 : .player1
    }
}

class ChessScene: SKScene, ObservableObject {
    @Published var turn: PlayerID = .player1
    @Published var gameOver: Bool = false
    @Published var isFirstMove: Bool = true
    
    var gameSettings: GameSettings
    
    var board = ChessBoard()
    private var player1Pieces: PieceSet
    private var player2Pieces: PieceSet
    
    private var validMoveNodes: [SKShapeNode] = []
    private var validTiles: [Tile] = []
    private var moveSFX: AVAudioPlayer?
    private var checkNode: SKShapeNode?
    private var movingPiece: Bool = false
    
    var selectedPiece: ChessPiece? = nil
    var toTile: Tile? = nil
    
    private var enemyKing: ChessPiece { turn == .player1 ? player2Pieces.king : player1Pieces.king }
    var player1IsInCheckmate: Bool { MoveCalculation.kingIsInCheckmate(for: .player1, on: board) }
    var player2IsInCheckmate: Bool { MoveCalculation.kingIsInCheckmate(for: .player2, on: board) }
    
    var playingWithAI: Bool { gameSettings.playerCount == 1 }
    var aiTurn: PlayerID { gameSettings.playerSide.opposite() }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        do {
            let path = Bundle.main.path(forResource: "piece_moved.mp3", ofType: nil)!
            moveSFX = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        } catch {
            moveSFX = nil
        }
        player1Pieces = PieceSet(belongsTo: .player1, isOnBoard: board)
        player2Pieces = PieceSet(belongsTo: .player2, isOnBoard: board)
        board.player1King = player1Pieces.king
        board.player2King = player2Pieces.king
        gameSettings = GameSettings()
        super.init(size: size)
        self.scaleMode = .fill
    }
    
    convenience init(size: CGSize, gameSettings: GameSettings) {
        self.init(size: size)
        self.gameSettings = gameSettings
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!gameOver && !movingPiece) {
            guard let touch = touches.first else { return }
            let touchPoint = touch.location(in: self)
            let touchedPiece = pieceFromNode(node: atPoint(touchPoint))
            if selectedPiece != nil && touchedPiece?.player == selectedPiece?.player {
                hideValidMoves()
                selectPiece(touchedPiece)
            } else if selectedPiece == nil {
                selectPiece(touchedPiece)
            } else {
                movePiece(to: touchPoint)
            }
        }
    }
    
    func resetGame() {
        removeAllChildren()
        validMoveNodes = []
        validTiles = []
        selectedPiece = nil
        board = ChessBoard()
        turn = .player1
        gameOver = false
        if gameSettings.selectedSave != nil {
            initGameFromSave()
        } else {
            player1Pieces = PieceSet(belongsTo: .player1, isOnBoard: board)
            player2Pieces = PieceSet(belongsTo: .player2, isOnBoard: board)
            board.player1King = player1Pieces.king
            board.player2King = player2Pieces.king
        }
        drawChessGrid()
        drawChessPieces()
        if turn == aiTurn && playingWithAI {
            self.aiMove()
        }
    }
    
    private func initGameFromSave() {
        for piece in Array(gameSettings.selectedSave!.pieces) {
            let newPiece = ChessPiece(
                belongsTo: piece.belongsToPlayer1 ? .player1 : .player2,
                type: ChessPieceType(rawValue: piece.type)!
            )
            newPiece.canTakeEnPassant = piece.canTakeEnPassant
            newPiece.moveCount = Int(piece.moveCount)
            board.addPiece(newPiece, tile: (Int(piece.row), Int(piece.column)))
            if piece.type == ChessPieceType.king.rawValue {
                if piece.belongsToPlayer1 {
                    board.player1King = newPiece
                } else {
                    board.player2King = newPiece
                }
            }
        }
        turn = gameSettings.selectedSave!.isPlayer1Turn ? .player1 : .player2
        isFirstMove = false
    }
    
    func drawChessGrid(forImage: Bool = false) {
        for tileNo in SKConstants.tileRange {
            let tile = squareNode(
                at: (tileNo % SKConstants.boardWidth, tileNo / SKConstants.boardWidth),
                color: tileColor(tileNo: tileNo, forImage: forImage)
            )
            tile.zPosition = SKConstants.boardZPosition
            addChild(tile)
        }
    }
    
    private func tileColor(tileNo: Int, forImage: Bool) -> SKColor {
        if forImage {
            return (tileNo + (tileNo / SKConstants.boardWidth)) % 2 == 0 ? SKConstants.darkTile : SKConstants.lightTile
        } else {
            return (tileNo + (tileNo / SKConstants.boardWidth)) % 2 == 0 ? gameSettings.theme.boardColor2 : gameSettings.theme.boardColor1
        }
    }
    
    private func drawChessPieces() {
        for row in SKConstants.boardRange {
            for column in SKConstants.boardRange {
                board.board[row][column]?.sprite.position = CGPoint(
                    x: column * SKConstants.tileSize + SKConstants.spriteOffset,
                    y: row * SKConstants.tileSize + SKConstants.spriteOffset
                )
                if board.board[row][column] != nil {
                    addChild(board.board[row][column]!.sprite)
                }
            }
        }
    }
    
    private func selectPiece(_ piece: ChessPiece?) {
        selectedPiece = piece
        if selectedPiece != nil {
            showValidMoves()
        }
        if validTiles.isEmpty {
            selectedPiece = nil
        }
    }
    
    private func movePiece(to touchPoint: CGPoint) {
        toTile = locationToTile(touchPoint)
        let fromTile = board.tileFromPiece(selectedPiece!)
        if SharedFunctions.isInTileList(tileList: validTiles, tile: toTile!) {
            movingPiece = true
            hideValidMoves()
            hideCheckNode()
            board.movePiece(from: fromTile, to: toTile!, chessScene: self)
            animateMove(piece: selectedPiece!, to: toTile!) {
                self.moveCompletion()
            }
        }
    }
    
    private func aiMove() {
        DispatchQueue.global(qos: .userInteractive).async {
            let move = AIMoveCalculation.move(
                aiPlayer: self.gameSettings.playerSide.opposite(),
                aiDifficulty: self.gameSettings.aiDifficulty,
                board: self.board
            )
            if move.to.0 == -1 && move.to.1 == -1 {
                DispatchQueue.main.async { self.gameOver = true }
            } else {
                self.hideValidMoves()
                self.hideCheckNode()
                let pieceToMove = self.board.pieceFromTile(move.from);
                self.board.movePiece(from: move.from, to: move.to, chessScene: self)
                self.animateMove(piece: pieceToMove!, to: self.board.tileFromPiece(pieceToMove!)) {
                    self.moveCompletion()
                }
            }
        }
    }
    
    private func moveCompletion() {
        moveSFX?.play()
        if MoveCalculation.kingIsInCheck(for: turn.opposite(), on: board) {
            showCheckNode()
            if MoveCalculation.kingIsInCheckmate(for: turn.opposite(), on: board) {
                DispatchQueue.main.async { self.gameOver = true }
            }
        }
        turn.toggle()
        selectedPiece = nil
        if turn == aiTurn && playingWithAI {
            aiMove()
        }
        movingPiece = false
    }
    
    func animateMove(piece: ChessPiece, to: Tile, completion: @escaping () -> Void) {
        DispatchQueue.main.async { self.isFirstMove = false }
        piece.sprite.run(moveAnimation(to: CGPoint(
            x: to.1 * SKConstants.tileSize + SKConstants.spriteOffset,
            y: to.0 * SKConstants.tileSize + SKConstants.spriteOffset
        )), completion: completion)
    }
    
    private func showValidMoves() {
        validTiles = MoveCalculation.movesFor(selectedPiece!, on: board)
        for tile in validTiles {
            let moveNode = squareNode(at: tile, color: gameSettings.theme.moveColor)
            moveNode.zPosition = SKConstants.hintZPosition
            validMoveNodes.append(moveNode)
            addChild(moveNode)
        }
    }
    
    private func hideValidMoves() {
        for moveBlock in validMoveNodes {
            moveBlock.removeFromParent()
        }
        validMoveNodes = []
    }
    
    private func showCheckNode() {
        checkNode = squareNode(at: board.tileFromPiece(enemyKing), color: gameSettings.theme.checkColor)
        checkNode?.zPosition = SKConstants.checkHintZPosition
        addChild(checkNode!)
    }
    
    private func hideCheckNode() {
        checkNode?.removeFromParent()
    }
    
    private func pieceFromNode(node: SKNode) -> ChessPiece? {
        if !(self.playingWithAI && turn == aiTurn) {
            for piece in board.piecesOnBoardForPlayer(turn) {
                if piece.sprite == node {
                    return piece
                }
            }
        }
        return nil
    }
    
    private func locationToTile(_ location: CGPoint) -> Tile {
        return (Int(floor(location.y / CGFloat(SKConstants.tileSize))),
                Int(floor(location.x / CGFloat(SKConstants.tileSize))))
    }
    
    private func moveAnimation(to point: CGPoint) -> SKAction {
        let moveAction = SKAction.move(to: point, duration: SKConstants.moveSpeed)
        moveAction.timingMode = SKActionTimingMode.easeInEaseOut
        return moveAction
    }
    
    private func squareNode(at tile: Tile, color: SKColor) -> SKShapeNode {
        let squareNode = SKShapeNode(
            rect: CGRect(
                x: tile.1 * SKConstants.tileSize,
                y: tile.0 * SKConstants.tileSize,
                width: SKConstants.tileSize,
                height: SKConstants.tileSize)
        )
        squareNode.fillColor = color
        squareNode.strokeColor = .clear
        return squareNode
    }
}
