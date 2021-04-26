//
//  ContentView.swift
//  Flashzilla
//
//  Created by Santiago Pelaez Rua on 8/04/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var withoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State private var cards = [Card]()
    @State private var timeRemaining = 10
    @State private var isActive = true
    @State private var showingEditingScreen = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if timeRemaining == 0 {
                    Text("GAME OVER")
                }
                
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                    )
                
                ZStack {
                    VStack {
                        HStack {
                            
                            Spacer()
                            
                            Button(action: {
                                showingEditingScreen = true
                            }) {
                                Image(systemName: "plus.circle")
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .clipShape(Circle())
                            }
                        }
                        
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                    
                    if withoutColor || accessibilityEnabled {
                        VStack {
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    withAnimation {
                                        removeCard(at: cards.count - 1)
                                    }
                                }) {
                                    Image(systemName: "xmark.circle")
                                        .padding()
                                        .background(Color.black.opacity(0.7))
                                        .clipShape(Circle())
                                }
                                .accessibility(label: Text("Wrong"))
                                .accessibility(hint: Text("Mark your answer as being incorrect."))
                                Spacer()
                                
                                Button(action: {
                                    withAnimation {
                                        removeCard(at: cards.count - 1)
                                    }
                                }) {
                                    Image(systemName: "checkmark.circle")
                                        .padding()
                                        .background(Color.black.opacity(0.7))
                                        .clipShape(Circle())
                                }
                                .accessibility(label: Text("Correct"))
                                .accessibility(hint: Text("Mark your answer as being correct"))
                            }
                        }
                    }
                    
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) {
                            withAnimation {
                                removeCard(at: index)
                            }
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index == cards.count - 1)
                        .accessibility(hidden: index < cards.count - 1)
                        
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else if timeRemaining == 0 {
                gameOver()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if !cards.isEmpty {
                isActive = true
            }
        }
        .sheet(isPresented: $showingEditingScreen, onDismiss: resetCards) {
            EditCards()
        }
        .onAppear(perform: resetCards)
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 10
        isActive = true
        loadData()
    }
    
    func gameOver() {
        
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
