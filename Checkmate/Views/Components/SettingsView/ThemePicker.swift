//
//  ThemePicker.swift
//  Checkmate
//
//  Created by Paul Scott on 12/2/20.
//

import SwiftUI

struct ThemePicker: View {
    @ObservedObject var gameSettings: GameSettings
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Picker("", selection: $gameSettings.selectedTheme) {
                ForEach(ThemeName.allCases, id: \.self) {
                    Text($0.rawValue.capitalized).tag($0)
                }
            }
            .pickerStyle(InlinePickerStyle())
            .background(
                RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
                    .fill(gameSettings.theme.backgroundColor)
            )
            Text("Game Theme")
                .foregroundColor(.white)
                .padding()
        }
        .environment(\.colorScheme, .dark)
    }
}
