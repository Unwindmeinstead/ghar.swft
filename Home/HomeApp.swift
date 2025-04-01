//
//  HomeApp.swift
//  Home
//
//  Created by UNKNOWN on 3/31/25.
//

import SwiftUI

@main
struct GharApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 800, minHeight: 600)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowToolbarStyle(UnifiedWindowToolbarStyle())
    }
}
