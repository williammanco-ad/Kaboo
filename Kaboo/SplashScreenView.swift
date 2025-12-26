//
//  SplashScreenView.swift
//  Kaboo
//
//  Created by Kaboo Team
//

import SwiftUI

struct SplashScreenView: View {
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0.0
    
    var body: some View {
        ZStack {
            // Green background
            Color.green
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Card symbols arranged in a fancy way
                HStack(spacing: 10) {
                    Text("♠️")
                        .font(.system(size: 60))
                    Text("♥️")
                        .font(.system(size: 60))
                }
                
                // App title
                Text("KABOO")
                    .font(.system(size: 72, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                
                HStack(spacing: 10) {
                    Text("♣️")
                        .font(.system(size: 60))
                    Text("♦️")
                        .font(.system(size: 60))
                }
            }
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    scale = 1.0
                    opacity = 1.0
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
