//
//  Activity.swift
//  HabitTracking
//
//  Created by Santiago Pelaez Rua on 20/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import Foundation

struct Activity: Identifiable, Codable {
    let id = UUID()
    let name: String
    let description: String
    var timesCompleted: Int
}
