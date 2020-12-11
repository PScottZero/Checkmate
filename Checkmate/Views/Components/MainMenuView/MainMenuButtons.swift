//
//  MainMenuButtons.swift
//  Checkmate
//
//  Created by Paul Scott on 12/8/20.
//

import SwiftUI

struct MainMenuButtons: View {
    @ObservedObject var gameSettings: GameSettings
    @Binding var shouldHideNavBar: Bool
    @State var shouldShowChessView = false
    @State var shouldShowLoadView = false
    @State var shouldShowLeaderboardView = false
    
    var startButtonDisabled: Bool {
        gameSettings.playerCount == 2 ? gameSettings.player1 == nil || gameSettings.player2 == nil
            || gameSettings.player1 == gameSettings.player2 : gameSettings.player1 == nil
    }
    
    var body: some View {
        VStack {
            RoundedNavigationLink(
                label: "Start",
                destination: AnyView(ChessView(
                    gameSettings: gameSettings,
                    shouldShowChessView: $shouldShowChessView
                )),
                isActive: $shouldShowChessView,
                disabled: startButtonDisabled
            ) {
                gameSettings.selectedSave = nil
            }
            HStack {
                RoundedNavigationLink(
                    label: "Load Game",
                    destination: AnyView(LoadView(
                        gameSettings: gameSettings,
                        shouldShowLoadView: $shouldShowLoadView,
                        shouldShowChessView: $shouldShowChessView,
                        shouldHideNavBar: $shouldHideNavBar
                    )),
                    isActive: $shouldShowLoadView,
                    disabled: false
                )
                RoundedNavigationLink(
                    label: "Leaderboard",
                    destination: AnyView(LeaderboardView(shouldHideNavBar: $shouldHideNavBar)),
                    isActive: $shouldShowLeaderboardView,
                    disabled: false
                )
            }
        }
    }
}
