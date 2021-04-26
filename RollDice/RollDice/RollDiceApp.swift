//
//  RollDiceApp.swift
//  RollDice
//
//  Created by Santiago Pelaez Rua on 16/04/21.
//

import SwiftUI

@main
struct RollDiceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
