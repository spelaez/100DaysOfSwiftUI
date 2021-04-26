//
//  Prospect.swift
//  HotProspects
//
//  Created by Santiago Pelaez Rua on 29/03/21.
//

import Foundation

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    private(set) var creationDate = Date()
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    static let saveKey = "SavedData"
    
    init() {
        self.people = []
        
        if let data = try? Data(contentsOf: getDirectory()),
           let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
            people = decoded
            return
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            try? encoded.write(to: getDirectory(), options: .atomicWrite)
        }
    }
    
    private func getDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory,
                                             in: .userDomainMask)
        
        return paths[0].appendingPathComponent("prospects")
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
}
