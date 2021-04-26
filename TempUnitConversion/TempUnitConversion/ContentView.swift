//
//  ContentView.swift
//  TempUnitConversion
//
//  Created by Santiago Pelaez Rua on 15/05/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI
struct ContentView: View {
    
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    @State private var value: String = ""
    
    private var units: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    
    var convertedValue: Double {
        let valueToConvert = Double(value) ?? 0
        let measurement = Measurement(value: valueToConvert, unit: units[inputUnit])
        let converted = measurement.converted(to: units[outputUnit])
        
        return converted.value
    }
    
    private func text(for unit: Int) -> String {
        let unit = units[unit]
        switch unit {
        case .celsius:
            return "Celsius"
        case .fahrenheit:
            return "Fahrenheit"
        case .kelvin:
            return "Kelvin"
        default:
            return "Unknown"
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select the unit you want to convert from")) {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(0..<3) {
                            Text("\(self.text(for: $0))")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Select the unit you want to convert to")) {
                    Picker("Input Unit", selection: $outputUnit) {
                        ForEach(0..<3) {
                            Text("\(self.text(for: $0))")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    TextField("Value to convert", text: $value)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(UIKeyboardType.decimalPad)
                }
                
                Section {
                    Text("Total: \(convertedValue, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Temperature Converter", displayMode: .large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
