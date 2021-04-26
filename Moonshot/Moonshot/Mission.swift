//
//  Mission.swift
//  Moonshot
//
//  Created by Santiago Pelaez Rua on 10/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLauchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        }
        
        return "N/A"
    }
    
    var crewNames: String {
        let names = crew.map{ $0 .name }.joined(separator: ", ") + "."
        
        return names
    }
}
