//
//  MissionView.swift
//  Moonshot
//
//  Created by Santiago Pelaez Rua on 12/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Mission \(member)")
            }
        }
        
        self.astronauts = matches
    }
    
    func color(for role: String) -> Color {
        if role == "Commander" {
            return .accentColor
        }
        
        return .secondary
    }
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader {geo in
                        
                        Image(self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: fullView.size.width, maxHeight: geo.size.height)
                            .padding()
                            .scaleEffect(0.8 + getScaleFactor(geo: geo, fullView: fullView))
                            .accessibility(hidden: true)
                    }.frame(maxHeight: 200)
                    
                    Text(self.mission.formattedLauchDate)
                        .accessibility(label: Text("Date: \(mission.formattedLauchDate)"))
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.primary, lineWidth: 1))
                                    .accessibility(hidden: true)
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(self.color(for: crewMember.role))
                                }
                                .accessibilityElement(children: .ignore)
                                .accessibility(label: Text("\(crewMember.astronaut.name) as \(crewMember.role)"))
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    func getScaleFactor(geo: GeometryProxy, fullView: GeometryProxy) -> CGFloat {
        return (geo.frame(in: .global).midY / fullView.size.height) * 0.87
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
