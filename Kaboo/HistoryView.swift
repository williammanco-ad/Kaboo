//
//  HistoryView.swift
//  Kaboo
//
//  Created by Kaboo Team
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var gameStore: GameStore
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.green.opacity(0.1), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                if gameStore.pastSessions.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "clock.badge.questionmark")
                            .font(.system(size: 80))
                            .foregroundColor(.gray.opacity(0.5))
                        
                        Text("No past games yet")
                            .font(.title3)
                            .foregroundColor(.gray)
                        
                        Text("Play a game and it will appear here")
                            .font(.subheadline)
                            .foregroundColor(.gray.opacity(0.8))
                    }
                } else {
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(gameStore.pastSessions) { session in
                                GameSessionCard(session: session)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("History")
        }
    }
}

struct GameSessionCard: View {
    let session: GameSession
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.green)
                Text(formatDate(session.date))
                    .font(.headline)
                
                Spacer()
                
                if let winnerName = session.winnerName {
                    HStack {
                        Image(systemName: "trophy.fill")
                            .foregroundColor(.yellow)
                        Text(winnerName)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                }
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Players:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                ForEach(session.players.sorted(by: { $0.score < $1.score })) { player in
                    HStack {
                        if player.name == session.winnerName {
                            Image(systemName: "crown.fill")
                                .foregroundColor(.yellow)
                                .font(.caption)
                        }
                        Text(player.name)
                            .font(.body)
                        Spacer()
                        Text("\(player.score) pts")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    HistoryView()
        .environmentObject(GameStore())
}
