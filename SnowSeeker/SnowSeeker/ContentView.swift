//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Santiago Pelaez Rua on 21/04/21.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

enum ResortFilter: String {
    case country
    case size
    case price
    case none = "filters"
}

enum ResortSorting: String {
    case `default` = "sortings"
    case alphabetical = "name"
    case country
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @ObservedObject var favorites = Favorites()
    
    @State private var filterText = ""
    @State private var filter = ResortFilter.none
    @State private var sorting = ResortSorting.default
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var filteredSortedResorts: [Resort] {
        var resorts = self.resorts
        
        if !filterText.isEmpty {
            switch filter {
            case .country:
                resorts = resorts.filter { $0.country.contains(filterText) }
            case .price:
                resorts = resorts.filter { $0.price == Int(filterText) }
            case .size:
                resorts = resorts.filter { $0.size == Int(filterText) }
            case .none:
                break
            }
        }
        
        switch sorting {
        case .alphabetical:
            return resorts.sorted(by: { $0.name > $1.name })
        case .country:
            return resorts.sorted(by: { $0.country > $1.country })
        default:
            return resorts
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                TextField("Filter", text: $filterText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                ForEach(filteredSortedResorts) { resort in
                    NavigationLink(destination: ResortView(resort: resort)) {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                                .layoutPriority(1)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                                .layoutPriority(1)
                        }
                        .layoutPriority(1)
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibility(label: Text("This is a favorite resort"))
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(leading: Text(filter.rawValue.capitalized)
                                    .foregroundColor(.blue)
                                    .contextMenu(ContextMenu(menuItems: {
                                        Button(action: {
                                            filter = .country
                                        }, label: {
                                            Label("Country", systemImage: "map")
                                            
                                        })
                                        Button(action: {
                                            filter = .size
                                        }, label: {
                                            Label("Size",
                                                  systemImage: "arrow.up.left.and.arrow.down.right")
                                        })
                                        Button(action: {
                                            filter = .size
                                        }, label: {
                                            Label("Price", systemImage: "dollarsign.circle")
                                        })
                                        Button(action: {
                                            filter = .none
                                        }, label: {
                                            Text("None")
                                        })
                                    }))
                                ,
                                trailing: Text(sorting.rawValue.capitalized)
                                    .foregroundColor(.blue)
                                    .contextMenu(ContextMenu(menuItems: {
                                        Button(action: {
                                            withAnimation {
                                                sorting = .default
                                            }
                                        }, label: {
                                            Label("Default", systemImage: "arrow.down")
                                            
                                        })
                                        Button(action: {
                                            withAnimation {
                                                sorting = .country
                                            }
                                        }, label: {
                                            Label("Country", systemImage: "map")
                                        })
                                        Button(action: {
                                            withAnimation {
                                                sorting = .alphabetical
                                            }
                                        }, label: {
                                            Label("Name", systemImage: "abc")
                                            
                                        })
                                    }))
            )
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
