//
//  RollerView.swift
//  RollDice
//
//  Created by Santiago Pelaez Rua on 17/04/21.
//

import SwiftUI

struct RollerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var numberOfDice = 1
    @State private var diceSides = DiceSides.six
    @State private var diceResult: DiceResult?
    @State private var isRolling = false
    @State private var result: Int = 0
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Stepper("Number of Dice \(numberOfDice)",
                        value: $numberOfDice,
                        in: 1...5)
                    .padding()
                
                Text("How many sides ?")
                    .padding(.horizontal)
                
                Picker("How many sides ?",
                       selection: $diceSides) {
                    ForEach(DiceSides.all, id: \.rawValue) { diceSide in
                        Text("\(diceSide.rawValue)").tag(diceSide)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                GeometryReader { geo in
                    Button("Roll!", action: roll)
                        .font(.largeTitle)
                        .foregroundColor(.red)
                        .padding()
                        .frame(width: geo.size.width, height: 100)
                }.frame(height: 100)
                
                if isRolling {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100,
                                                           maximum: 100))]) {
                        
                        ForEach(diceResult!.wrappedResult) { aResult in
                            DiceView(sides: diceSides,
                                     result: Int(aResult.value))
                        }
                    }
                }
                
                Spacer()
            }
            .navigationBarTitle("Dice Configuration")
            .onAppear(perform: {
                isRolling = false
            })
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                if viewContext.hasChanges { try? viewContext.save() }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
                if viewContext.hasChanges { try? viewContext.save() }
            }
        }
    }
    
    func roll() {
        withAnimation {
            isRolling = false
        }
        
        createResult()
        try? viewContext.save()
        
        withAnimation {
            isRolling = true
        }
    }
    
    func createResult() {
        let result = DiceResult(context: viewContext)
        result.id = UUID()
        result.dices = Int16(numberOfDice)
        result.sides = Int16(diceSides.rawValue)
        
        for _ in 0..<numberOfDice {
            let value = Int.random(in: 1...diceSides.rawValue)
            let resultEntity = Result(context: viewContext)
            resultEntity.value = Int16(value)
            
            result.addToResult(resultEntity)
        }
        
        diceResult = result
    }
}

struct RollerView_Previews: PreviewProvider {
    static var previews: some View {
        RollerView()
    }
}
