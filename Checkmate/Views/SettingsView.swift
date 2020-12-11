//
//  SettingsView.swift
//  Checkmate
//
//  Created by Paul Scott on 12/2/20.
//

import SwiftUI
import CoreData

struct SettingsView: View {
    @ObservedObject var gameSettings: GameSettings
    @Binding var shouldShowSheet: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: ViewConstants.mediumSpacing) {
            Text("Settings")
                .font(.system(size: ViewConstants.largeFont))
            ThemePicker(gameSettings: gameSettings)
            RoundedAlertButton(
                "Delete All Saved Games",
                message: "Are you sure you want to delete all saved games?",
                actionText: "Delete",
                dangerous: true
            ) {
                Delete.allGameSaves()
                gameSettings.selectedSave = nil
            }
            RoundedAlertButton(
                "Delete All Players",
                message: "Are you sure you want to delete all players?",
                actionText: "Delete",
                dangerous: true
            ) {
                Delete.allPlayers()
                gameSettings.player1 = nil
                gameSettings.player2 = nil
                gameSettings.selectedSave = nil
            }
            RoundedButton("Dismiss", gradient: Colors.blueGradient) {
                shouldShowSheet = false
            }
            Spacer()
        }
        .padding()
    }
}
