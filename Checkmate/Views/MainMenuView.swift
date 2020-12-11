//
//  MainMenuView.swift
//  Checkmate
//
//  Created by Paul Scott on 11/6/20.
//

import SwiftUI
import CoreData

struct MainMenuView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var gameSettings = GameSettings()
    @State var shouldHideNavBar: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: ViewConstants.mediumSpacing) {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: ViewConstants.logoHeight)
                        .padding(.top, ViewConstants.largePadding)
                        .padding(.bottom, ViewConstants.mediumPadding)
                    ChessSettings(gameSettings: gameSettings, shouldHideNavBar: $shouldHideNavBar)
                    Spacer()
                    MainMenuButtons(gameSettings: gameSettings, shouldHideNavBar: $shouldHideNavBar)
                }
                .onAppear {
                    shouldHideNavBar = true
                }
                .foregroundColor(.white)
                .padding()
                .background(gameSettings.theme.backgroundColor)
                .edgesIgnoringSafeArea(.all)
                .navigationBarHidden(shouldHideNavBar)
                SettingsButton(gameSettings: gameSettings)
            }
        }
    }
}
