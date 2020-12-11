//
//  PlayerName.swift
//  Checkmate
//
//  Created by Paul Scott on 11/8/20.
//

import SwiftUI

struct PlayerName: View {
    @Binding var playerName: String
    
    var body: some View {
        TextField("Player Name", text: $playerName)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
                    .stroke(Color.blue, lineWidth: ViewConstants.smallLineWidth)
            )
    }
}
