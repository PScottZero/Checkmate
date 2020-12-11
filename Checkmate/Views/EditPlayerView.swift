//
//  NewPlayerView.swift
//  Checkmate
//
//  Created by Paul Scott on 11/7/20.
//

import SwiftUI
import CoreData

struct EditPlayerView: View {
    @ObservedObject var player: Player
    @Binding var selectedPlayer: Player?
    @Binding var shouldShowSheet: Bool
    
    var body: some View {
        VStack(spacing: ViewConstants.largeSpacing) {
            PlayerImage(imageData: $player.image, size: ViewConstants.largeImageSize, showEditButton: true)
            PlayerName(playerName: $player.name)
            HStack(spacing: ViewConstants.largeSpacing) {
                Text("Wins: \(player.wins)")
                Text("Losses: \(player.losses)")
                Text("Rating: \(String(player.rating))")
            }
            RoundedAlertButton(
                "Reset Stats",
                message: "Are you sure you want to reset wins and losses?",
                actionText: "Reset",
                dangerous: true
            ) {
                player.wins = 0
                player.losses = 0
                player.rating = ViewConstants.defaultRating
            }
            RoundedAlertButton(
                "Delete Player",
                message: "Are you sure you want to delete this player?",
                actionText: "Delete",
                dangerous: true
            ) {
                Delete.player(player)
                shouldShowSheet = false
                if selectedPlayer == player {
                    selectedPlayer = nil
                }
            }
            RoundedButton("Dismiss", gradient: Colors.blueGradient) {
                shouldShowSheet = false
            }
            Spacer()
        }
        .padding()
    }
}
