//
//  GameView.swift
//  Edutainment
//
//  Created by Santiago Pelaez Rua on 3/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @State private var answer = ""
    @State private var currentQuestion = 0
    @State private var score = 0
    @State private var finished = false
    
    var questions: [Question]
    var gameOverCallback: () -> ()
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 0) {
                Text("\(questions[currentQuestion].description) = ")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                
                TextField("answer", text: $answer)
                    .fixedSize(horizontal: true, vertical: false)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.largeTitle)
                    .keyboardType(UIKeyboardType.numberPad)
                    .multilineTextAlignment(.center)
            }
            Button(action: {
                self.nextQuestion()
            }) {
                Text("Send!")
            }
            
            Spacer()
            
            Text("Round \(currentQuestion + 1) out of \(questions.count)")
        }.alert(isPresented: $finished) {
            Alert(title: Text("Game Over!"), message: Text("Your got \(score) correct!"), dismissButton: .default(Text("Ok!"), action: gameOverCallback))
        }
    }
    
    func nextQuestion() {
        score += questions[currentQuestion].result == Int(answer)! ? 1 : 0
        
        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
        } else {
            finishGame()
        }
    }
    
    func finishGame() {
        finished = true
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(questions: [], gameOverCallback: {})
    }
}
