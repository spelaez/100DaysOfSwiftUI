//
//  DiceView.swift
//  RollDice
//
//  Created by Santiago Pelaez Rua on 16/04/21.
//

import SwiftUI
import CoreHaptics

enum DiceSides: Int {
    case four = 4,
         six = 6,
         eight = 8,
         ten = 10,
         twelve = 12,
         twenty = 20,
         hundred = 100
    
    static var all: [DiceSides] {
        return [.four,
                .six,
                .eight,
                .ten,
                .twelve,
                .twenty,
                .hundred]
    }
}

struct DiceView: View {
    var sides: DiceSides
    var result: Int
    
    @State private var currentNumber = "0"
    @State private var engine: CHHapticEngine?
    
    private let feedbackGen = UINotificationFeedbackGenerator()
    
    var maxNumber: Int {
        sides.rawValue
    }
    
    var body: some View {
        ZStack {
            Color.red
                .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                        .stroke()
                )
            
            Text(currentNumber)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .frame(minWidth: 50, maxWidth: 100, minHeight: 50, maxHeight: 100)
        .padding()
        .onAppear(perform: prepareHaptics)
        .onAppear(perform: rollDice)
    }
    
    func rollDice() {
        for i in 0..<100 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)/50) {
                currentNumber = "\(Int.random(in: 1...maxNumber))"
                sendHapticFeedBack()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            currentNumber = "\(result)"
            sendHapticFeedBack()
        }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func sendHapticFeedBack() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
        let event = CHHapticEvent(eventType: .hapticTransient,
                                  parameters: [intensity, sharpness],
                                  relativeTime: 0)
        
        playHaptics(with: [event])
    }
    
    func playHaptics(with events: [CHHapticEvent]) {
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(sides: .eight, result: 0)
    }
}
