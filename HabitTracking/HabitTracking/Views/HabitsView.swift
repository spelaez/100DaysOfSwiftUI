//
//  HabitsView.swift
//  HabitTracking
//
//  Created by Santiago Pelaez Rua on 20/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI

struct HabitsView: View {
    @ObservedObject var habits: Habit
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<habits.activities.count, id: \.self) { index in
                    NavigationLink(destination: ActivityDetailView(activity: self.habits.activities[index], callBack: {activity in
                        self.update(activity: activity, at: index)
                    })) {
                        
                        VStack(alignment: .leading) {
                            Text(self.habits.activities[index].name)
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Text(self.habits.activities[index].description)
                                .font(.subheadline)
                                .fontWeight(.light)
                                .foregroundColor(Color.gray)
                        }
                    }
                }
            }
            .navigationBarTitle("Habits")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddActivity = true
                }, label: {
                    Text("Add")
                })
            )
                .sheet(isPresented: $showingAddActivity, content: {
                    AddActivityView(habits: self.habits)
                })
        }
    }
    
    func update(activity: Activity, at index: Int) {
        habits.update(activity: activity, at: index)
    }
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView(habits: Habit())
    }
}
