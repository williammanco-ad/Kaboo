# Kaboo

Cards game born in Sicily that conquered the world

## Overview

Kaboo is a SwiftUI iOS app that allows players to track scores for the Sicilian card game Kaboo. The app features:

- **Splash Screen**: A fancy green-themed splash screen with card suit symbols
- **Game Management**: Start games, add players, and track scores in real-time
- **Score Tracking**: Easy increment/decrement buttons for each player's score
- **Winner Declaration**: Call "Kaboo!" to end the game and declare the winner (lowest score wins)
- **Game History**: View all past game sessions with player scores and winners

## Features

### Splash Screen
- Green background with animated card symbols (♠️ ♥️ ♣️ ♦️)
- Smooth fade-in animation
- Displays for 2.5 seconds on app launch

### New Features (Latest Update)
- **Direct Score Input**: Tap the pencil button on any player card to enter a score directly
  - Supports any integer value (positive or negative)
  - Quick way to set exact scores
  - Minimum score validation (0) still enforced
- **Game Date Selection**: When starting a new game, choose the date and time
  - Perfect for recording historical games
  - Use current time for real-time gameplay
  - Graphical date picker interface

### Home Tab
- **Start New Game**: Big green button to initiate a game session
  - **NEW:** Date picker to select when the game is being played
  - Options for current time or historical dates
- **Add Players**: Add multiple players with custom names
- **Score Management**: 
  - Plus/minus buttons for incremental score adjustments
  - **NEW:** Direct score input button (pencil icon) to set any score value
  - Real-time score updates
  - Visual card-style player list
- **Kaboo Button**: Fancy gradient button to end the game
  - Shows winner preview in alert
  - Winner is the player with the lowest score
- **Cancel Game**: Option to cancel an active game

### History Tab
- Lists all completed games
- Shows game date and time
- Displays all players with their final scores
- Highlights the winner with a crown icon
- Trophy indicator next to winner's name
- Players sorted by score (lowest to highest)

## Project Structure

```
Kaboo/
├── Kaboo.xcodeproj/          # Xcode project file
│   └── project.pbxproj
├── Kaboo/
│   ├── KabooApp.swift         # Main app entry point
│   ├── ContentView.swift      # Tab view container
│   ├── SplashScreenView.swift # Splash screen with animations
│   ├── HomeView.swift         # Game management interface
│   ├── HistoryView.swift      # Past games display
│   ├── Models.swift           # Data models (Player, GameSession, GameStore)
│   └── Assets.xcassets/       # App assets
└── README.md
```

## Technical Details

- **Platform**: iOS 17.0+
- **Framework**: SwiftUI
- **Language**: Swift 5.0
- **Data Persistence**: UserDefaults (for game history)
- **Architecture**: MVVM with ObservableObject

## Building and Running

1. Open `Kaboo.xcodeproj` in Xcode
2. Select an iOS Simulator or device
3. Press ⌘R to build and run

## How to Play

1. Launch the app (splash screen appears)
2. Tap "Start New Game" on the Home tab
3. Select the game date/time (or use current time)
4. Add players using the "Add Player" button
5. During gameplay, use +/- buttons for quick adjustments or pencil button to set exact scores
6. When ready to finish, tap the "KABOO!" button
7. The winner (lowest score) is announced
8. View the completed game in the History tab
