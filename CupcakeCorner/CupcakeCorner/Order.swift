//
//  Order.swift
//  CupcakeCorner
//
//  Created by Santiago Pelaez Rua on 30/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI

class OrderWrapper: ObservableObject {
    @Published var order: Order
    
    init(order: Order) {
        self.order = order
    }
    
    init() {
        order = Order()
    }
}

struct Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        
        let validName = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let validstreetAddress = streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let validCity = city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let validZip = zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        return !(validName || validstreetAddress || validCity || validZip)
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        
        cost += Double(quantity) / 2
        
        cost += extraFrosting ? Double(quantity) : 0
        cost += addSprinkles ? Double(quantity) / 2 : 0
        
        return cost
    }
}
