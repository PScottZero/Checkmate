//
//  GameThemes.swift
//  Checkmate
//
//  Created by Paul Scott on 12/2/20.
//

import Foundation
import SwiftUI
import SpriteKit

enum ThemeName: String, CaseIterable {
    case bismuth, blue, green, iridescent, metallic, opal, red, regal, vaporwave
}

struct GameTheme {
    let backgroundColor: LinearGradient
    let boardColor1: SKColor
    let boardColor2: SKColor
    let moveColor: SKColor
    let checkColor: SKColor
    
    init(
        backgroundColor: LinearGradient,
        boardColor1: SKColor = SKConstants.lightTile,
        boardColor2: SKColor = SKConstants.darkTile,
        moveColor: SKColor = SKColor(red: 0, green: 0, blue: 1, alpha: 0.3),
        checkColor: SKColor = SKColor(red: 1, green: 0, blue: 0, alpha: 0.3)
    ) {
        self.backgroundColor = backgroundColor
        self.boardColor1 = boardColor1
        self.boardColor2 = boardColor2
        self.moveColor = moveColor
        self.checkColor = checkColor
    }
}

struct GameThemes {
    static let green = GameTheme(
        backgroundColor: LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 37 / 255, green: 128 / 255, blue: 79 / 255),
                Color(red: 0 / 255, green: 88 / 255, blue: 79 / 215)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
    )
    
    static let blue = GameTheme(
        backgroundColor: LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 35 / 255, green: 110 / 255, blue: 145 / 215),
                Color(red: 15 / 255, green: 73 / 255, blue: 100 / 215)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
    )
    
    static let red = GameTheme(
        backgroundColor: LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 245 / 255, green: 66 / 255, blue: 66 / 255),
                Color(red: 145 / 255, green: 35 / 255, blue: 35 / 215)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
    )
    
    static let vaporwave = GameTheme(
        backgroundColor: LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 255 / 255, green: 120 / 255, blue: 237 / 255),
                Color(red: 96 / 255, green: 42 / 255, blue: 245 / 255)
            ]),
            startPoint: .top,
            endPoint: .bottom
        ),
        boardColor1: SKColor(red: 255 / 255, green: 120 / 255, blue: 237 / 255, alpha: 1),
        boardColor2: SKColor(red: 96 / 255, green: 42 / 255, blue: 245 / 255, alpha: 1),
        moveColor: SKColor(red: 209 / 255, green: 17 / 255, blue: 107 / 255, alpha: 0.5),
        checkColor: SKColor(red: 1, green: 0, blue: 0, alpha: 0.7)
    )
    
    static let metallic = GameTheme(
        backgroundColor: LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.7, green: 0.7, blue: 0.7),
                Color(red: 0.3, green: 0.3, blue: 0.3)
            ]),
            startPoint: .top,
            endPoint: .bottom
        ),
        boardColor1: SKColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1),
        boardColor2: SKColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    )
    
    static let iridescent = GameTheme(
        backgroundColor: LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.7, green: 0.7, blue: 0.7),
                Color(red: 0.7, green: 0.3, blue: 0),
                Color(red: 0.7, green: 0, blue: 0.3),
                Color(red: 0, green: 0.4, blue: 0.7),
                Color(red: 0.3, green: 0.3, blue: 0.3)
            ]),
            startPoint: .top,
            endPoint: .bottom
        ),
        boardColor1: SKColor(red: 171 / 255, green: 192 / 255, blue: 209 / 255, alpha: 1),
        boardColor2: SKColor(red: 121 / 255, green: 145 / 255, blue: 166 / 255, alpha: 1)
    )
    
    static let regal = GameTheme(
        backgroundColor: LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 173 / 255, green: 0, blue: 0),
                Color(red: 163 / 255, green: 51 / 255, blue: 103 / 255)
            ]),
            startPoint: .top,
            endPoint: .bottom
        ),
        boardColor1: SKColor(red: 240 / 255, green: 199 / 255, blue: 110 / 255, alpha: 1),
        boardColor2: SKColor(red: 173 / 255, green: 0, blue: 0, alpha: 1),
        moveColor: SKColor(red: 0, green: 0, blue: 1, alpha: 0.5),
        checkColor: SKColor(red: 1, green: 0, blue: 0, alpha: 1)
    )
    
    static let opal = GameTheme(
        backgroundColor: LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 80 / 255, green: 128 / 255, blue: 194 / 255),
                Color(red: 106 / 255, green: 129 / 255, blue: 223 / 255),
                Color(red: 150 / 255, green: 207 / 255, blue: 138 / 255),
                Color(red: 219 / 255, green: 216 / 255, blue: 121 / 255),
                Color(red: 199 / 255, green: 149 / 255, blue: 138 / 255),
                Color(red: 181 / 255, green: 184 / 255, blue: 201 / 255)
            ]),
            startPoint: .bottom,
            endPoint: .top
        ),
        boardColor1: SKColor(red: 209 / 255, green: 215 / 255, blue: 224 / 255, alpha: 1),
        boardColor2: SKColor(red: 100 / 255, green: 148 / 255, blue: 214 / 255, alpha: 1),
        moveColor: SKColor(red: 170 / 255, green: 227 / 255, blue: 158 / 255, alpha: 0.5)
    )
    
    static let bismuth = GameTheme(
        backgroundColor: LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 37 / 255, green: 96 / 255, blue: 165 / 255),
                Color(red: 47 / 255, green: 110 / 255, blue: 114 / 255),
                Color(red: 79 / 255, green: 170 / 255, blue: 85 / 255),
                Color(red: 230 / 255, green: 222 / 255, blue: 80 / 255),
                Color(red: 219 / 255, green: 112 / 255, blue: 235 / 255)
            ]),
            startPoint: .bottom,
            endPoint: .top
        ),
        boardColor1: SKColor(red: 79 / 255, green: 170 / 255, blue: 85 / 255, alpha: 1),
        boardColor2: SKColor(red: 37 / 255, green: 96 / 255, blue: 165 / 255, alpha: 1),
        moveColor: SKColor(red: 1, green: 1, blue: 0, alpha: 0.5)
    )
}
