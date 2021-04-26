//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Santiago Pelaez Rua on 22/04/21.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"
    
    init() {
        resorts = []
        load()
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(resorts) else { return }
        
        UserDefaults.standard.setValue(data, forKey: "resorts")
    }
    
    func load() {
        guard let data = UserDefaults.standard.data(forKey: "resorts") else { return }
        
        resorts = (try? JSONDecoder().decode(Set<String>.self, from: data)) ?? []
    }
}
