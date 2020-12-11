//
//  CheckmateApp.swift
//  Checkmate
//
//  Created by Paul Scott on 11/6/20.
//

import SwiftUI

@main
struct CheckmateApp: App {
    @Environment(\.scenePhase) private var scenePhase
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainMenuView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .inactive:
                try? persistenceController.container.viewContext.save()
            default:
                break
            }
        }
    }
}
