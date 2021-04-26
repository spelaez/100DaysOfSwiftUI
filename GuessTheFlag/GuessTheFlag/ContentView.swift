//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Santiago Pelaez Rua on 16/05/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    let name: String
    
    var body: some View {
        Image(self.name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var score = 0
    @State private var scoreTitle = ""
    
    @State private var flagAngles = [0.0, 0.0, 0.0]
    @State private var wrongFlagAngles = [0.0, 0.0, 0.0]
    @State private var flagOpacity = [1.0, 1.0, 1.0]
    
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]

    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .fixedSize(horizontal: true, vertical: false)
                        .foregroundColor(.white)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    .fixedSize(horizontal: true, vertical: false)
                }
                
                ForEach(0..<3){ number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(name: self.countries[number])
                    }
                    .rotation3DEffect(.degrees(self.flagAngles[number])
                        , axis: (x: 0, y: 1, z: 0))
                        .opacity(self.flagOpacity[number])
                        .rotationEffect(.degrees(self.wrongFlagAngles[number]), anchor: .center)
                    .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown Flag"]))
                }
                
                Spacer()
                
                Text("Total Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            
            animateCorrectAnswer()
        } else {
            scoreTitle = "Wrong!, That's the flag of \(countries[number])"
            score -= 1
            
            animateWrongAnswer(number)
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        flagAngles[correctAnswer] = 0
        correctAnswer = Int.random(in: 0...2)
        
        flagAngles = [0.0, 0.0, 0.0]
        flagOpacity = [1.0, 1.0, 1.0]
        wrongFlagAngles = [0.0, 0.0, 0.0]
    }
    
    func animateCorrectAnswer() {
        for number in 0...2 {
            if number == correctAnswer {
                withAnimation {
                    flagAngles[number] = 360
                }
            } else {
                withAnimation {
                    flagOpacity[number] = 0.25
                }
            }
        }
    }
    
    func animateWrongAnswer(_ number: Int) {
        withAnimation(Animation.easeIn(duration: 0.1).repeatCount(5, autoreverses: true)) {
            wrongFlagAngles[number] = 5
        }
        
        withAnimation(Animation.default.delay(0.5)) {
            wrongFlagAngles[correctAnswer] = 360
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
