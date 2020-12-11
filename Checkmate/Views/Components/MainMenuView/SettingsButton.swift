//
//  SettingsButton.swift
//  Checkmate
//
//  Created by Paul Scott on 12/8/20.
//

import SwiftUI

struct SettingsButton: View {
    @ObservedObject var gameSettings: GameSettings
    @State var shouldShowSettingsSheet = false
    
    var body: some View {
        Button(action: { shouldShowSettingsSheet = true }) {
            Image(systemName: "gear")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
        }
        .sheet(isPresented: $shouldShowSettingsSheet) {
            SettingsView(gameSettings: gameSettings, shouldShowSheet: $shouldShowSettingsSheet)
        }
        .frame(width: ViewConstants.gearIconSize, height: ViewConstants.gearIconSize)
        .padding()
    }
}
