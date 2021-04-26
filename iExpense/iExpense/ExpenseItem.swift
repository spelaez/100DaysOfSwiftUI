//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Santiago Pelaez Rua on 6/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
