//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Santiago Pelaez Rua on 23/05/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI

struct MoveImage: View {
    var name: String
    
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 150, maxHeight: 150)
    }
}


struct ContentView: View {
    private var moves = ["Rock", "Paper", "Scissors"]
    @State private var choice = Int.random(in: 0..<2)
    @State private var shouldWin = Bool.random()
    @State private var round = 1
    @State private var score = 0
    @State private var showFinalScore = false
    
    private func newRound() {
        round += 1
        
        if round > 10 {
            showFinalScore = true
            round = 1
            score = 0
        } else {
            choice = Int.random(in: 0..<2)
            shouldWin = Bool.random()
        }
    }
    
    private func moveTapped(move: String) {
        var won: Bool
        let appChoice = moves[choice]
        
        switch move {
        case "Rock":
            won = appChoice == "Scissors"
        case "Paper":
            won = appChoice == "Rock"
        case "Scissors":
            won = appChoice == "Paper"
        default:
            return
        }
        
        if shouldWin {
            score += won ? 1 : -1
        } else {
            score += won ? -1 : 1
        }
        
        newRound()
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.green, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 30) {
                    Text("Score: \(score)")
                        .font(.largeTitle)
                    Text("You should \(shouldWin ? "Win" : "Lose")")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    MoveImage(name: self.moves[self.choice])
                    
                    Spacer()
                    
                    Text("VS")
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    Spacer()
                    
                    HStack {
                        ForEach(moves, id: \.self) { move in
                            Button(action: {
                                self.moveTapped(move: move)
                            }) {
                                MoveImage(name: move)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .navigationBarTitle("Rock Paper Scissors")
                .alert(isPresented: $showFinalScore) {
                    Alert(title: Text("Game Over"), message: Text("Your final score: \(score)"), dismissButton: .default(Text("Ok!")) {
                        self.newRound()
                        })
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
