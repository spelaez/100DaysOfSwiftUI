//
//  Habit.swift
//  HabitTracking
//
//  Created by Santiago Pelaez Rua on 20/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import Foundation

class Habit: ObservableObject {
    struct Constants {
        static let activitiesKey = "activities"
    }
    
    @Published var activities: [Activity] {
        didSet {
            let jsonEncoder = JSONEncoder()
            let data = try? jsonEncoder.encode(activities)
            
            UserDefaults.standard.set(data, forKey: Constants.activitiesKey)
        }
    }
    
    init() {
        guard let activitesData = UserDefaults.standard.data(forKey: Constants.activitiesKey) else {
            activities = []
            return
        }
        
        let jsonDecoder = JSONDecoder()
        let activities = try? jsonDecoder.decode([Activity].self, from: activitesData)
        
        self.activities = activities ?? []
    }
    
    func add(activity: Activity) {
        activities.append(activity)
    }
    
    func update(activity: Activity, at index: Int) {
        activities[index] = activity
    }
}
