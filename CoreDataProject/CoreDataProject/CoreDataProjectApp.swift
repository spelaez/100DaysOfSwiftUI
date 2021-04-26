//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Santiago Pelaez Rua on 11/03/21.
//

import SwiftUI
import CoreData

@main
struct CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear(perform: {
                    persistenceController.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                })
        }
    }
}
