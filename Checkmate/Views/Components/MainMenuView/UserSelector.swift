//
//  UserSelector.swift
//  Checkmate
//
//  Created by Paul Scott on 11/6/20.
//

import SwiftUI
import CoreData

struct UserSelector: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Player.name, ascending: true)],
        animation: .default
    ) private var allPlayers: FetchedResults<Player>
    
    @Binding var selectedPlayer: Player?
    let playerNo: Int
    @Binding var shouldHideNavBar: Bool
    @State var shouldShowPlayerList: Bool = false
    
    var body: some View {
        HStack(spacing: ViewConstants.mediumSpacing) {
            Text("P\(playerNo): ")
            NavigationLink(
                destination: PlayerListView(
                    selectedPlayer: $selectedPlayer,
                    shouldShowPlayerList: $shouldShowPlayerList,
                    shouldHideNavBar: $shouldHideNavBar
                ),
                isActive: $shouldShowPlayerList
            ) {
                RoundedButton("\(selectedPlayer != nil ? selectedPlayer!.name : "Select Player")") {
                    shouldShowPlayerList = true
                }
            }
        }
        .font(.system(size: ViewConstants.smallFont))
    }
}
