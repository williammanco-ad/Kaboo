//
//  HomeView.swift
//  Kaboo
//
//  Created by Kaboo Team
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var gameStore: GameStore
    @State private var showingAddPlayer = false
    @State private var newPlayerName = ""
    @State private var showingKabooAlert = false
    
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
                
                VStack(spacing: 20) {
                    if gameStore.currentSession == nil {
                        // No active game - show start button
                        VStack(spacing: 30) {
                            Image(systemName: "suit.club.fill")
                                .font(.system(size: 100))
                                .foregroundColor(.green)
                            
                            Text("Ready to play Kaboo?")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Button(action: {
                                gameStore.startNewGame()
                            }) {
                                HStack {
                                    Image(systemName: "play.fill")
                                    Text("Start New Game")
                                        .fontWeight(.bold)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.green, Color.green.opacity(0.7)]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .foregroundColor(.white)
                                .cornerRadius(15)
                                .shadow(color: .green.opacity(0.4), radius: 10, x: 0, y: 5)
                            }
                            .padding(.horizontal, 40)
                        }
                    } else {
                        // Active game
                        VStack(spacing: 15) {
                            Text("Game in Progress")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                            
                            if let session = gameStore.currentSession {
                                if session.players.isEmpty {
                                    Text("Add players to start")
                                        .foregroundColor(.gray)
                                        .padding(.top, 20)
                                } else {
                                    ScrollView {
                                        VStack(spacing: 12) {
                                            ForEach(session.players) { player in
                                                PlayerScoreCard(
                                                    player: player,
                                                    onScoreChange: { newScore in
                                                        gameStore.updatePlayerScore(playerId: player.id, score: newScore)
                                                    }
                                                )
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                
                                // Action buttons
                                VStack(spacing: 12) {
                                    Button(action: {
                                        showingAddPlayer = true
                                    }) {
                                        HStack {
                                            Image(systemName: "person.badge.plus")
                                            Text("Add Player")
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                    }
                                    
                                    if !session.players.isEmpty {
                                        Button(action: {
                                            showingKabooAlert = true
                                        }) {
                                            HStack {
                                                Image(systemName: "flag.checkered")
                                                Text("KABOO!")
                                                    .fontWeight(.heavy)
                                            }
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color.red, Color.orange]),
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                )
                                            )
                                            .foregroundColor(.white)
                                            .cornerRadius(12)
                                            .shadow(color: .red.opacity(0.4), radius: 10, x: 0, y: 5)
                                        }
                                    }
                                    
                                    Button(action: {
                                        gameStore.cancelGame()
                                    }) {
                                        Text("Cancel Game")
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.gray.opacity(0.2))
                                            .foregroundColor(.red)
                                            .cornerRadius(12)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.bottom, 10)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Kaboo")
            .alert("Add Player", isPresented: $showingAddPlayer) {
                TextField("Player Name", text: $newPlayerName)
                Button("Cancel", role: .cancel) {
                    newPlayerName = ""
                }
                Button("Add") {
                    if !newPlayerName.isEmpty {
                        gameStore.addPlayer(name: newPlayerName)
                        newPlayerName = ""
                    }
                }
            }
            .alert("Game Over!", isPresented: $showingKabooAlert) {
                Button("Finish Game") {
                    gameStore.callKaboo()
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                if let winner = gameStore.currentSession?.winner() {
                    Text("\(winner.name) wins with \(winner.score) points!")
                }
            }
        }
    }
}

struct PlayerScoreCard: View {
    let player: Player
    let onScoreChange: (Int) -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(player.name)
                    .font(.headline)
                Text("Score: \(player.score)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            HStack(spacing: 15) {
                Button(action: {
                    onScoreChange(max(Player.minimumScore, player.score - 1))
                }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    onScoreChange(player.score + 1)
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    HomeView()
        .environmentObject(GameStore())
}
