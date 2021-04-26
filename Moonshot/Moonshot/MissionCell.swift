//
//  MissionCell.swift
//  Moonshot
//
//  Created by Santiago Pelaez Rua on 14/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI

struct MissionCell: View {
    enum Format {
        case date
        case crew
    }
    
    let mission: Mission
    let format: Format
    
    var body: some View {
        HStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .accessibility(hidden: true)
            
            VStack(alignment: .leading) {
                Text(mission.displayName)
                    .font(.headline)
                Text(self.format == Format.date ? mission.formattedLauchDate : mission.crewNames)
            }
            .accessibilityElement(children: .ignore)
            .accessibility(label: Text("\(mission.displayName), \(format == Format.date ? mission.formattedLauchDate : mission.crewNames)"))
            
            Spacer()
        }
    }
}

struct MissionCell_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        MissionCell(mission: missions[0], format: .crew)
    }
}
