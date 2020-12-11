//
//  PieceColorPicker.swift
//  Checkmate
//
//  Created by Paul Scott on 12/1/20.
//

import SwiftUI

struct PieceColorPicker: View {
    @Binding var playerSide: PlayerID
    
    var body: some View {
        VStack {
            Text("Piece Color")
            Picker("", selection: $playerSide) {
                Text("White").tag(PlayerID.player1)
                Text("Black").tag(PlayerID.player2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .environment(\.colorScheme, .dark)
        }
    }
}
