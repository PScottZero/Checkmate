//
//  PlayerCountPicker.swift
//  Checkmate
//
//  Created by Paul Scott on 11/27/20.
//

import SwiftUI

struct PlayerCountPicker: View {
    @Binding var playerCount: Int
    
    var body: some View {
        VStack {
            Text("Player Count")
            Picker("", selection: $playerCount) {
                Text("One").tag(1)
                Text("Two").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .environment(\.colorScheme, .dark)
        }
    }
}
