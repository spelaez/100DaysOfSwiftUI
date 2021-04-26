//
//  ContentView.swift
//  iExpense
//
//  Created by Santiago Pelaez Rua on 5/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI

//
//class User: ObservableObject {
//    @Published var firstName = "Bilbo"
//    @Published var lastName = "Baggins"
//}
//
//struct SecondView: View {
//    var name: String
//
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//        Button("Dismiss") {
//            self.presentationMode.wrappedValue.dismiss()
//        }
//    }
//}
//
//struct ContentView: View {
//    @State private var showingSheet = false
//
//    var body: some View {
//        Button("Show Sheet") {
//            self.showingSheet.toggle()
//        }.sheet(isPresented: $showingSheet) {
//            SecondView(name: "@twostraws")
//        }
//    }
//}


//struct ContentView: View {
//    @ObservedObject var user = User()
//
//    var body: some View {
//        VStack {
//            Text("Your name is \(user.firstName) \(user.lastName).")
//
//            TextField("First name", text: $user.firstName)
//            TextField("Last name", text: $user.lastName)
//        }
//    }
//}

//struct ContentView: View {
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                List {
//                    ForEach(numbers, id: \.self) {
//                        Text("\($0)")
//                    }
//                    .onDelete(perform: removeRows)
//                }
//
//                Button("Add Number") {
//                    self.numbers.append(self.currentNumber)
//                    self.currentNumber += 1
//                }
//            }.navigationBarItems(leading: EditButton())
//        }
//    }
//
//    func removeRows(at offsets: IndexSet) {
//        numbers.remove(atOffsets: offsets)
//    }
//}
//
//struct ContentView: View {
//    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
//
//    var body: some View {
//        Button("Tap count: \(tapCount)") {
//            self.tapCount += 1
//            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
//        }
//    }
//}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text("$\(item.amount)")
                            .foregroundColor(self.getColor(for: item.amount))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems( leading: EditButton(),
                                 trailing:
                Button(action: {
                    self.showingAddExpense.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }
    
    func getColor(for amount: Int) -> Color {
        if amount < 10 {
            return .red
        } else if amount < 100 {
            return .blue
        }
        
        return .purple
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
