//
//  ContentView.swift
//  RollDice
//
//  Created by Santiago Pelaez Rua on 16/04/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView {
            RollerView()
                .tabItem {
                    Text("Roll")
                    Image(systemName: "cube.fill")
                }
            
            ResultsView()
                .tabItem {
                    Text("Results")
                    Image(systemName: "text.justify")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
