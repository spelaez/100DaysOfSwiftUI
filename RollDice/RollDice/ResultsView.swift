//
//  ResultsView.swift
//  RollDice
//
//  Created by Santiago Pelaez Rua on 19/04/21.
//

import SwiftUI

struct ResultsHeader: View {
    var body: some View {
        HStack {
            Text("DICES")
                .multilineTextAlignment(.center)
                .padding(.leading)
                .alignmentGuide(HorizontalAlignment.center, computeValue: { dimension in
                    dimension[HorizontalAlignment.center]
                })
            
            Spacer()
            
            Text("SIDES")
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Text("TOTAL")
                .multilineTextAlignment(.center)
                .padding(.trailing)
        }
    }
}

struct ResultsView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: DiceResult.entity(),
                  sortDescriptors: []) var results: FetchedResults<DiceResult>
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List {
                    Section(header: ResultsHeader()) {
                        ForEach(results) { result in
                            HStack {
                                Text("\(result.dices)")
                                    .multilineTextAlignment(.center)
                                    .padding(.leading)
                                
                                Spacer()
                                
                                Text("\(result.sides)")
                                    .multilineTextAlignment(.center)
                                
                                Spacer()
                                
                                Text("\(result.total)")
                                    .multilineTextAlignment(.center)
                                    .padding(.trailing)
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .navigationBarTitle("Results")
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
