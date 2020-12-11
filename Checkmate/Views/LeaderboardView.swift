//
//  LeaderboardView.swift
//  Checkmate
//
//  Created by Paul Scott on 11/29/20.
//

import SwiftUI

struct LeaderboardView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Player.rating, ascending: false)],
        animation: .default
    ) private var rankedPlayers: FetchedResults<Player>
    
    @Binding var shouldHideNavBar: Bool
    
    var body: some View {
        VStack {
            if rankedPlayers.count > 0 {
                List {
                    ForEach(rankedPlayers.indices) { index in
                        LeaderboardListItem(ranking: index + 1, player: rankedPlayers[index])
                    }
                }
            } else {
                Text("No Players")
                    .font(.system(size: ViewConstants.mediumFont))
            }
        }
        .navigationTitle("Leaderboard")
        .padding()
        .onAppear {
            shouldHideNavBar = false
        }
    }
}
