//
//  DraggableView.swift
//  Cat
//
//  Created by Lahfir on 24/09/23.
//

import Foundation
import SwiftUI

struct DraggableView<Content: View>: View {
    @GestureState private var dragState = CGSize.zero
    var content: () -> Content
    
    var body: some View {
        content()
            .offset(dragState)
            .gesture(
                DragGesture()
                    .updating($dragState) { value, state, _ in
                        state = value.translation
                    }
            )
    }
}
