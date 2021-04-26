//
//  Challenge.swift
//  Drawing
//
//  Created by Santiago Pelaez Rua on 19/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI

struct Challenge: View {
    @State private var lineWidth: CGFloat = 0.0
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
//            Arrow(bodyWidth: 100)
//                .stroke(Color.black, lineWidth: lineWidth)
//                .frame(width: 300, height: 300)
//                .clipped()
//                .padding()
//
//            Spacer()
//
//            Slider(value: $lineWidth, in: 0...10)
//                .padding()
            
            ColorCyclingRectangle(amount: self.colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
        }
    }
}

struct Challenge_Previews: PreviewProvider {
    static var previews: some View {
        Challenge()
    }
}
