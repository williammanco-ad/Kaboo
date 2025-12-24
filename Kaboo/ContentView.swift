//
//  ContentView.swift
//  Kaboo
//
//  Created by Kaboo Team
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Game", systemImage: "suit.club.fill")
                }
            
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock.fill")
                }
        }
        .accentColor(.green)
    }
}

#Preview {
    ContentView()
}
