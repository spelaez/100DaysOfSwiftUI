//
//  Question.swift
//  Edutainment
//
//  Created by Santiago Pelaez Rua on 4/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import Foundation

struct Question {
    var multiplier: Int
    var multiplicand: Int
    var result: Int {
        return multiplier * multiplicand
    }
    
    var description: String { "\(multiplier) x \(multiplicand)" }
}
