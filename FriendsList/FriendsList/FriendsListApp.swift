//
//  FriendsListApp.swift
//  FriendsList
//
//  Created by Santiago Pelaez Rua on 11/03/21.
//

import SwiftUI

@main
struct FriendsListApp: App {
    let persisteceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            UserList()
                .environment(\.managedObjectContext, persisteceController.container.viewContext)
        }.onChange(of: scenePhase) { _ in
            persisteceController.save()
        }
    }
}
