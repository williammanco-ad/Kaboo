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
    @State private var showingCelebration = false
    
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
                                            showingCelebration = true
                                        }) {
                                            HStack {
                                                Image(systemName: "flag.checkered")
                                                Text("Finish & Declare Winner")
                                                    .fontWeight(.semibold)
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
            .sheet(isPresented: $showingCelebration) {
                if let winner = gameStore.currentSession?.winner() {
                    WinnerCelebrationView(
                        winner: winner,
                        onFinish: {
                            gameStore.callKaboo()
                            showingCelebration = false
                        }
                    )
                }
            }
        }
    }
}

struct WinnerCelebrationView: View {
    let winner: Player
    let onFinish: () -> Void
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0.0
    @State private var confettiOpacity: Double = 0.0
    
    var body: some View {
        ZStack {
            // Background gradient - darker colors to make yellow trophy stand out
            LinearGradient(
                gradient: Gradient(colors: [Color.purple.opacity(0.6), Color.blue.opacity(0.5)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Trophy animation
                Image(systemName: "trophy.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.yellow)
                    .shadow(color: .orange, radius: 20)
                    .scaleEffect(scale)
                    .opacity(opacity)
                
                VStack(spacing: 15) {
                    Text("🎉 Winner! 🎉")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.orange)
                        .opacity(opacity)
                    
                    Text(winner.name)
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.primary)
                        .opacity(opacity)
                    
                    Text("\(winner.score) points")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .opacity(opacity)
                }
                
                Button(action: onFinish) {
                    Text("Finish Game")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(color: .green.opacity(0.4), radius: 10)
                }
                .padding(.horizontal, 40)
                .padding(.top, 20)
                .opacity(opacity)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                scale = 1.2
                opacity = 1.0
            }
            
            withAnimation(.easeInOut(duration: 0.5).delay(0.2)) {
                confettiOpacity = 1.0
            }
            
            // Bounce effect
            withAnimation(.easeInOut(duration: 0.3).delay(0.6)) {
                scale = 1.0
            }
        }
    }
}

struct PlayerScoreCard: View {
    let player: Player
    let onScoreChange: (Int) -> Void
    @State private var showingAddPrompt = false
    @State private var showingSubtractPrompt = false
    @State private var pointsInput = ""
    
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
                    showingSubtractPrompt = true
                    pointsInput = ""
                }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    showingAddPrompt = true
                    pointsInput = ""
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
        .alert("Add Points to \(player.name)", isPresented: $showingAddPrompt) {
            TextField("Points to add", text: $pointsInput)
                .keyboardType(.numberPad)
            Button("Cancel", role: .cancel) {
                pointsInput = ""
            }
            Button("Add") {
                if let points = Int(pointsInput), points > 0 {
                    onScoreChange(player.score + points)
                }
                pointsInput = ""
            }
        } message: {
            Text("Enter how many points to add")
        }
        .alert("Subtract Points from \(player.name)", isPresented: $showingSubtractPrompt) {
            TextField("Points to subtract", text: $pointsInput)
                .keyboardType(.numberPad)
            Button("Cancel", role: .cancel) {
                pointsInput = ""
            }
            Button("Subtract") {
                if let points = Int(pointsInput), points > 0 {
                    onScoreChange(max(Player.minimumScore, player.score - points))
                }
                pointsInput = ""
            }
        } message: {
            Text("Enter how many points to subtract")
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(GameStore())
}
