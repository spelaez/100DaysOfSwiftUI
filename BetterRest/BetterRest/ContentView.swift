//
//  ContentView.swift
//  BetterRest
//
//  Created by Santiago Pelaez Rua on 24/05/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 0
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 9
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")
                    .font(.headline)) {
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                }
                
                Section(header: Text("Desired amount of sleep")
                    .font(.headline)) {
                        
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                        .accessibility(value: Text("\(sleepAmount, specifier: "%g") hours of sleep"))
                }
                
                Section(header: Text("Daily coffee intake")
                    .font(.headline)) {
                        
                        Picker(selection: $coffeeAmount, label: Text("Daily coffee intake")) {
                            ForEach(1..<21) {
                                if $0 == 1 {
                                    Text("1 cup")
                                } else {
                                    Text("\($0) cups")
                                }
                            }
                        }
                        .labelsHidden()
                }
                
                Section(header: Text("Your ideal bedtime is...")
                    .font(.headline)) {
                    Text(calculateBedTime())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }
    
    func calculateBedTime() -> String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount + 1))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
        } catch {
            return "Sorry, there was a problem calculating your bedtime."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
