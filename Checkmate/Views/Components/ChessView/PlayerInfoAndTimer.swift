//
//  PlayerInfoAndTimer.swift
//  Checkmate
//
//  Created by Paul Scott on 11/19/20.
//

import SwiftUI

struct PlayerInfoAndTimer: View {
    @Binding var player: Player?
    @State var image: Data?
    let playerNumber: PlayerID
    @Binding var timeLeft: Int
    let timeLimit: Int
    @Binding var pause: Bool
    @Binding var gameOver: Bool
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var timeLeftFormatted: String {
        let minutes: Int = timeLeft / 60;
        let seconds: Int = timeLeft % 60;
        return "\(minutes):\(String(format: "%02d", seconds))"
    }
    
    var body: some View {
        VStack(alignment: playerNumber == .player1 ? .leading : .trailing) {
            PlayerImage(imageData: $image, size: ViewConstants.chessViewImageSize, showEditButton: false)
                .background(
                    Circle()
                        .stroke(playerNumber == .player1 ? Color.white : Color.black, lineWidth: ViewConstants.mediumLineWidth)
                )
            Text(player!.name)
            if timeLimit != 0 {
                Text(timeLeftFormatted)
                    .onReceive(timer) { _ in
                        adjustTimeLeft()
                    }
                    .font(.system(size: ViewConstants.mediumFont))
            }
        }
        .foregroundColor(.white)
    }
    
    private func adjustTimeLeft() {
        if timeLeft > 0 && !pause && !gameOver {
            timeLeft -= 1
        } else if timeLeft == 0 {
            gameOver = true
        }
    }
}
