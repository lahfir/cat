//
//  HeartShape.swift
//  Cat
//
//  Created by Lahfir on 24/09/23.
//

import Foundation
import SwiftUI

struct HeartShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        let centerX = width / 2
        let centerY = height / 2
        
        path.move(to: CGPoint(x: centerX, y: centerY + height / 4))
        path.addCurve(to: CGPoint(x: centerX - width / 2, y: centerY - height / 4),
                      control1: CGPoint(x: centerX - width / 4, y: centerY + height / 4),
                      control2: CGPoint(x: centerX - width / 2, y: centerY))
        path.addArc(center: CGPoint(x: centerX - width / 4, y: centerY - height / 4),
                    radius: width / 4,
                    startAngle: Angle(radians: .pi),
                    endAngle: Angle(radians: 0),
                    clockwise: false)
        path.addArc(center: CGPoint(x: centerX + width / 4, y: centerY - height / 4),
                    radius: width / 4,
                    startAngle: Angle(radians: .pi),
                    endAngle: Angle(radians: 0),
                    clockwise: false)
        path.addCurve(to: CGPoint(x: centerX, y: centerY + height / 4),
                      control1: CGPoint(x: centerX + width / 2, y: centerY),
                      control2: CGPoint(x: centerX + width / 4, y: centerY + height / 4))
        
        return path
    }
}
