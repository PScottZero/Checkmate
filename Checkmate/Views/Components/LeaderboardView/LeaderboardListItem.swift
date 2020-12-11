//
//  LeaderboardListItem.swift
//  Checkmate
//
//  Created by Paul Scott on 11/29/20.
//

import SwiftUI

struct LeaderboardListItem: View {
    let ranking: Int
    @ObservedObject var player: Player
    
    var rankColor: Color {
        switch ranking {
        case 1:
            return Colors.rankOneColor
        case 2:
            return .gray
        case 3:
            return Colors.rankThreeColor
        default:
            return .blue
        }
    }
    
    var body: some View {
        HStack {
            Text("\(ranking)")
                .font(.system(size: ViewConstants.mediumFont, design: .monospaced))
                .foregroundColor(.white)
                .background(
                    Circle()
                        .foregroundColor(rankColor)
                        .frame(width: ViewConstants.rankSize, height: ViewConstants.rankSize)
                )
                .frame(width: ViewConstants.rankSize, height: ViewConstants.rankSize)
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(player.name)
                            .font(.system(size: ViewConstants.mediumFont))
                        Text("W-L: \(player.wins)-\(player.losses)")
                        Text("Rating: \(String(player.rating))")
                            .foregroundColor(rankColor)
                    }
                    Spacer()
                    PlayerImage(imageData: $player.image, size: ViewConstants.smallImageSize, showEditButton: false)
                        .padding(.top, ViewConstants.smallPadding)
                        .padding(.bottom, ViewConstants.smallPadding)
                }
            }
            .padding(.leading)
        }
    }
}
