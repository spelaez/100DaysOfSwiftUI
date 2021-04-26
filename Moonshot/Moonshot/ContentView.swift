//
//  ContentView.swift
//  Moonshot
//
//  Created by Santiago Pelaez Rua on 9/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingDate = true
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    MissionCell(mission: mission, format: self.showingDate ? .date : .crew)
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(action: {
                self.showingDate.toggle()
            }, label: {
                Text(self.showingDate ? "Crew" : "Dates")
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
