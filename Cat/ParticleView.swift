//
//  ParticleView.swift
//  Cat
//
//  Created by Lahfir on 24/09/23.
//

import Foundation
import SwiftUI

struct ParticleView: View {
    let position: CGPoint
    let color: Color
    let animation: Animation
    var scale: CGFloat
    
    var body: some View {
        HeartShape()
            .frame(width: 10, height: 10)
            .foregroundColor(color)
            .shadow(color: color, radius: 5, x: 0, y: 0) // Adjust radius and color as needed
            .position(position)
            .animation(animation, value: position)
            .scaleEffect(scale)
    }
}
