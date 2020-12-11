//
//  Settings.swift
//  Checkmate
//
//  Created by Paul Scott on 12/1/20.
//

import Foundation
import SwiftUI

class GameSettings: ObservableObject {
    
    // player information
    @Published var playerCount: Int = 1
    @Published var player1: Player?
    @Published var player2: Player?
    
    // one player information
    @Published var aiDifficulty: AIDifficulty = .normal
    @Published var playerSide: PlayerID = .player1
    
    // timer information
    @Published var timeLimit: Int = 0
    
    // game theme
    @Published var selectedTheme: ThemeName {
        didSet {
            UserDefaults.standard.set(selectedTheme.rawValue, forKey: "theme")
        }
    }
    @Published var selectedSave: GameSave?
    
    var theme: GameTheme {
        switch selectedTheme {
        case .bismuth:
            return GameThemes.bismuth
        case .blue:
            return GameThemes.blue
        case .green:
            return GameThemes.green
        case .iridescent:
            return GameThemes.iridescent
        case .metallic:
            return GameThemes.metallic
        case.opal:
            return GameThemes.opal
        case .red:
            return GameThemes.red
        case .regal:
            return GameThemes.regal
        case .vaporwave:
            return GameThemes.vaporwave
        }
    }
    
    init() {
        selectedTheme = ThemeName(rawValue: UserDefaults.standard.string(forKey: "theme") ?? ThemeName.green.rawValue)!
    }
}
