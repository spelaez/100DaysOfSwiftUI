//
//  Arrow.swift
//  Drawing
//
//  Created by Santiago Pelaez Rua on 19/06/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import Foundation
import SwiftUI

struct Arrow: Shape {
    let bodyWidth: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let triangleRect = CGRect(x: (rect.width - bodyWidth * 3) / 2, y: 0, width: bodyWidth * 3, height: rect.height / 3)
        let trianglePath = Triangle().path(in: triangleRect)
        
        path.addPath(trianglePath)
        
        path.move(to: CGPoint(x: triangleRect.midX - (bodyWidth / 2), y: triangleRect.maxY))
        path.addLine(to: CGPoint(x: triangleRect.midX - (bodyWidth / 2), y: rect.maxY))
        path.addLine(to: CGPoint(x: triangleRect.midX + (bodyWidth / 2), y: rect.maxY))
        path.addLine(to: CGPoint(x: triangleRect.midX + (bodyWidth / 2), y: triangleRect.maxY))
        
        return path
    }
    
}
