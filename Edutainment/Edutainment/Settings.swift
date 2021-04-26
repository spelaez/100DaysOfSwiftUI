//
//  Settings.swift
//  Edutainment
//
//  Created by Santiago Pelaez Rua on 3/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI

struct Settings: View {
    @State private var table = 1
    @State private var questionAmounts = ["5", "10", "20", "All"]
    @State private var questionAmount = "5"
    
    var onPlayGame: (Int, String) -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            Form {
                Section(header: Text("Choose your table")) {
                    Stepper(value: $table, in: 1...12) {
                        Text("Table of \(table)")
                    }
                    
                }
                
                Section(header: Text("Choose the amount of questions")) {
                    Picker("Amount of Questions", selection: $questionAmount) {
                        ForEach(questionAmounts, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                
                Button(action: {
                    self.onPlayGame(self.table, self.questionAmount)
                }) { Text("Play Game!") }
            }
        }.navigationBarTitle("Settings")
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings { (_, _) in
        }
    }
}
