//
//  KabooApp.swift
//  Kaboo
//
//  Created by Kaboo Team
//

import SwiftUI

@main
struct KabooApp: App {
    @State private var showSplash = true
    @StateObject private var gameStore = GameStore()
    
    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                ContentView()
                    .environmentObject(gameStore)
            }
        }
    }
}
