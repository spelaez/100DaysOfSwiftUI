//
//  ActivityDetailView.swift
//  HabitTracking
//
//  Created by Santiago Pelaez Rua on 20/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI

struct ActivityDetailView: View {
    @State var activity: Activity
    
    let callBack: (Activity) -> ()
    
    var body: some View {
        Form {
            Section {
                Text(activity.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(activity.description)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
            }
            
            Section(header: Text("Times completed")) {
                Stepper("\(activity.timesCompleted)", value: $activity.timesCompleted)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .navigationBarTitle("Activity Detail", displayMode: .inline)
        .onDisappear {
            self.callBack(self.activity)
        }
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let activity = Activity(name: "Name", description: "Description", timesCompleted: 0)
        
        return NavigationView {
            ActivityDetailView(activity: activity, callBack: { _ in})
        }
    }
}
