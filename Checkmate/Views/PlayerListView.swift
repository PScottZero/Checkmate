//
//  PlayerListView.swift
//  Checkmate
//
//  Created by Paul Scott on 11/10/20.
//

import SwiftUI

struct PlayerListView: View {
    @Binding var selectedPlayer: Player?
    @Binding var shouldShowPlayerList: Bool
    @Binding var shouldHideNavBar: Bool
    @State var shouldShowNewPlayerSheet: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Player.name, ascending: true)],
        animation: .default
    ) private var allPlayers: FetchedResults<Player>
    
    var body: some View {
        VStack {
            if allPlayers.count > 0 {
                List {
                    ForEach(allPlayers) { player in
                        Button(action: {
                            selectedPlayer = player
                            shouldShowPlayerList = false
                        }) {
                            PlayerListItem(player: player, selectedPlayer: $selectedPlayer)
                        }
                    }
                }
            } else {
                Spacer()
                Text("Please add at least one player")
                    .font(.system(size: ViewConstants.mediumFont))
            }
            Spacer()
            RoundedButton("New Player", gradient: Colors.blueGradient) {
                shouldShowNewPlayerSheet = true
            }.sheet(isPresented: $shouldShowNewPlayerSheet) {
                NewPlayerView(shouldShowSheet: $shouldShowNewPlayerSheet)
            }
        }
        .navigationTitle("Select Player")
        .padding()
        .onAppear {
            shouldHideNavBar = false
        }
    }
}
