//
//  Models.swift
//  Kaboo
//
//  Created by Kaboo Team
//

import Foundation

struct Player: Identifiable, Codable {
    let id: UUID
    var name: String
    var score: Int
    
    init(id: UUID = UUID(), name: String, score: Int = 0) {
        self.id = id
        self.name = name
        self.score = score
    }
}

struct GameSession: Identifiable, Codable {
    let id: UUID
    var date: Date
    var players: [Player]
    var winnerName: String?
    var isActive: Bool
    
    init(id: UUID = UUID(), date: Date = Date(), players: [Player] = [], winnerName: String? = nil, isActive: Bool = true) {
        self.id = id
        self.date = date
        self.players = players
        self.winnerName = winnerName
        self.isActive = isActive
    }
    
    func winner() -> Player? {
        return players.min(by: { $0.score < $1.score })
    }
}

class GameStore: ObservableObject {
    @Published var currentSession: GameSession?
    @Published var pastSessions: [GameSession] = []
    
    init() {
        loadSessions()
    }
    
    func startNewGame() {
        currentSession = GameSession()
    }
    
    func addPlayer(name: String) {
        guard var session = currentSession else { return }
        let player = Player(name: name)
        session.players.append(player)
        currentSession = session
    }
    
    func updatePlayerScore(playerId: UUID, score: Int) {
        guard var session = currentSession else { return }
        if let index = session.players.firstIndex(where: { $0.id == playerId }) {
            session.players[index].score = score
            currentSession = session
        }
    }
    
    func callKaboo() {
        guard var session = currentSession else { return }
        if let winner = session.winner() {
            session.winnerName = winner.name
            session.isActive = false
            pastSessions.insert(session, at: 0)
            currentSession = nil
            saveSessions()
        }
    }
    
    func cancelGame() {
        currentSession = nil
    }
    
    private func saveSessions() {
        if let encoded = try? JSONEncoder().encode(pastSessions) {
            UserDefaults.standard.set(encoded, forKey: "pastSessions")
        }
    }
    
    private func loadSessions() {
        if let data = UserDefaults.standard.data(forKey: "pastSessions"),
           let decoded = try? JSONDecoder().decode([GameSession].self, from: data) {
            pastSessions = decoded
        }
    }
}
