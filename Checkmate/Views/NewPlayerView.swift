//
//  NewPlayerView.swift
//  Checkmate
//
//  Created by Paul Scott on 11/8/20.
//

import SwiftUI
import CoreData

struct NewPlayerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var playerName: String = ""
    @State var imageData: Data? = nil
    @Binding var shouldShowSheet: Bool
    
    var body: some View {
        VStack(spacing: ViewConstants.largeSpacing) {
            PlayerImage(imageData: $imageData, size: ViewConstants.largeImageSize, showEditButton: true)
            PlayerName(playerName: $playerName)
            RoundedButton("Add Player", gradient: Colors.greenGradient, disabled: playerName.isEmpty) {
                let player = Player(context: viewContext)
                player.name = playerName
                player.image = imageData
                player.rating = ViewConstants.defaultRating
                shouldShowSheet = false
            }
            RoundedButton("Cancel", gradient: Colors.redGradient) {
                shouldShowSheet = false
            }
            Spacer()
        }
        .padding()
    }
}
