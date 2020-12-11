//
//  PlayerListItem.swift
//  Checkmate
//
//  Created by Paul Scott on 11/10/20.
//

import SwiftUI

struct PlayerListItem: View {
    @ObservedObject var player: Player
    @Binding var selectedPlayer: Player?
    @State var shouldShowEditPlayerSheet: Bool = false
    
    var body: some View {
        HStack {
            PlayerImage(imageData: $player.image, size: ViewConstants.smallImageSize, showEditButton: false)
                .padding(.top, ViewConstants.smallPadding)
                .padding(.bottom, ViewConstants.smallPadding)
            Spacer()
            Text(player.name)
                .font(.system(size: ViewConstants.mediumFont))
            Spacer()
            Button(action: { shouldShowEditPlayerSheet = true }) {
                Image(systemName: "info.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: ViewConstants.infoHeight)
            }
            .buttonStyle(BorderlessButtonStyle())
            .sheet(isPresented: $shouldShowEditPlayerSheet) {
                EditPlayerView(
                    player: player,
                    selectedPlayer: $selectedPlayer,
                    shouldShowSheet: $shouldShowEditPlayerSheet
                )
            }
        }
    }
}
