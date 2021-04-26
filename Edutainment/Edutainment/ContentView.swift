//
//  ContentView.swift
//  Edutainment
//
//  Created by Santiago Pelaez Rua on 3/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI

enum AppState {
    case settings
    case playing
}

struct ContentView: View {
    @State private var state: AppState = .settings
    @State private var questions = [Question]()
    
    var body: some View {
        NavigationView {
            if state == AppState.settings {
                Settings { (table, questions) in
                    self.generateQuestions(table: table, quantity: questions)
                    self.state = .playing
                }
            } else {
                GameView(questions: questions, gameOverCallback: {
                    self.state = .settings
                })
            }
        }
    }
    
    private func generateQuestions(table: Int, quantity: String) {
        var amount: Int
        amount = Int(quantity) ?? 30
        
        var questions = [Question]()
        
        for _ in 0..<amount {
            let multiplicand = Int.random(in: 0...30)
            
            let question = Question(multiplier: table, multiplicand: multiplicand)
            questions.append(question)
        }
        
        self.questions = questions
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
