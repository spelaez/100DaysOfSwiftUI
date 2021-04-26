//
//  AddActivityView.swift
//  HabitTracking
//
//  Created by Santiago Pelaez Rua on 20/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI

struct AddActivityView: View {
    
    @State private var activityName = ""
    @State private var activityDescription = ""
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habits: Habit
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Name", text: $activityName)
                    TextField("Description", text: $activityDescription)
                }
                
                Button(action: {
                    self.addActivity()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                })
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    func addActivity() {
        let activity = Activity(name: activityName, description: activityDescription, timesCompleted: 0)
        
        habits.add(activity: activity)
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        let habits = Habit()
        
        return AddActivityView(habits: habits)
    }
}
