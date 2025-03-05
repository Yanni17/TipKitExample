//
//  TipKitTutorialApp.swift
//  TipKitTutorial
//
//  Created by Ioannis Pechlivanis on 04.03.25.
//

import SwiftUI
import TipKit

@main
struct TipKitTutorialApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
//                    try? Tips.resetDatastore()
                    try? Tips.configure()
                }
        }
    }
}
