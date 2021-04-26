//
//  Expenses.swift
//  iExpense
//
//  Created by Santiago Pelaez Rua on 6/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] {
        didSet {
            do {
                let encoder = JSONEncoder()
                let encoded = try encoder.encode(items)
                UserDefaults.standard.set(encoded, forKey: "Items")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}
