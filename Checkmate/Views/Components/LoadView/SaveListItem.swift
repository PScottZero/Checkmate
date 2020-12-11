//
//  SaveListItem.swift
//  Checkmate
//
//  Created by Paul Scott on 12/6/20.
//

import SwiftUI

struct SaveListItem: View {
    @ObservedObject var gameSave: GameSave
    @Binding var selectedSave: GameSave?
    
    var player1: String {
        if gameSave.playingWithAI && !gameSave.playerIsFirst {
            return "AI (\(gameSave.aiDifficulty!.capitalized))"
        } else {
            return "\(gameSave.player1.name)"
        }
    }
    
    var player2: String {
        if gameSave.playingWithAI {
            if gameSave.playerIsFirst {
                return "AI (\(gameSave.aiDifficulty!.capitalized))"
            } else {
                return "\(gameSave.player1.name)"
            }
        } else {
            return "\(gameSave.player2 != nil ? gameSave.player2!.name : "")"
        }
    }
    
    var body: some View {
        HStack(spacing: ViewConstants.mediumSpacing) {
            VStack(alignment: .leading) {
                Group {
                    Text(player1)
                    Text("vs.")
                    Text(player2)
                }
                .font(.system(size: ViewConstants.mediumFont))
                Text(gameSave.time)
                    .font(.system(size: ViewConstants.smallestFont))
            }
            Spacer()
            if let image = UIImage(data: gameSave.image) {
                Image(uiImage: image)
                    .resizable()
                    .frame(
                        width: ViewConstants.savePreviewSize,
                        height: ViewConstants.savePreviewSize
                    )
                    .clipShape(RoundedRectangle(cornerRadius: ViewConstants.cornerRadius))
            }
        }
        RoundedAlertButton(
            "Delete Game",
            message: "Are you sure you want to delete this game?",
            actionText: "Delete",
            dangerous: true
        ) {
            Delete.gameSave(gameSave)
            if gameSave == selectedSave {
                selectedSave = nil
            }
        }
    }
}
