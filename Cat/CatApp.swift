//
//  CatApp.swift
//  Cat
//
//  Created by Lahfir on 19/09/23.
//

import SwiftUI

@main
struct CatApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().edgesIgnoringSafeArea(.all)
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
