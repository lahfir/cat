//
//  AnimatedCatImage.swift
//  Cat
//
//  Created by Lahfir on 24/09/23.
//

import Foundation
import SwiftUI

struct AnimatedCatImage: View {
    var isSpeaking: Bool
    
    var body: some View {
        if isSpeaking {
            AnimatedImage(imageName: "cat_speaking")
        } else {
            AnimatedImage(imageName: "cat_body_test")
        }
    }
}
