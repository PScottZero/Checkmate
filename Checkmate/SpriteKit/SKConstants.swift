//
//  SKConstants.swift
//  Checkmate
//
//  Created by Paul Scott on 11/16/20.
//

import Foundation
import SpriteKit

struct SKConstants {
    static let tileSize: Int = 40
    static let spriteSize = CGSize(width: 30, height: 30)
    static let spriteOffset: Int = 20
    static let boardWidth = 8
    static let boardRange = 0..<8
    static let tileRange = 0..<64
    static let invalidTile = (-1, -1)
    static let moveSpeed = 0.25
    static let moveColor = SKColor(red: 0, green: 0, blue: 1, alpha: 0.3)
    static let checkColor = SKColor(red: 1, green: 0, blue: 0, alpha: 0.3)
    static let darkTile = SKColor(red: 133 / 255, green: 112 / 255, blue: 80 / 255, alpha: 1)
    static let lightTile = SKColor(red: 201 / 255, green: 178 / 255, blue: 143 / 255, alpha: 1)
    static let boardZPosition: CGFloat = 1
    static let checkHintZPosition: CGFloat = 2
    static let pieceZPosition: CGFloat = 3
    static let hintZPosition: CGFloat = 4
    static let nilMove: Move = (from: (-1, -1), to: (-1, -1))
    static let initialDepth: Int = 1
    static let easyDepth: Int = 1
    static let normalDepth: Int = 2
    static let hardDepth: Int = 3
    static let impossibleDepth: Int = 4
    static let initialAlpha: Int = -10000
    static let initialBeta: Int = 10000
}
