# Kaboo App - User Guide

## Overview
Kaboo is a SwiftUI app for tracking scores in the Sicilian card game Kaboo. The player with the **lowest score** wins!

## App Flow

### 1. Launch
- App displays a **green splash screen** with card symbols (♠️ ♥️ ♣️ ♦️)
- Animated entrance with scale and fade effects
- Duration: 2.5 seconds

### 2. Home Tab - Game Management

#### Starting a New Game
1. Tap the **"Start New Game"** button (green gradient)
2. A date picker sheet appears with options to:
   - **Select a specific date and time** using the graphical date picker (useful for recording historical games)
   - **Use Current Time** button for games being played right now
   - **Cancel** to return without starting a game
3. Tap "Start Game" to confirm and begin the session

#### Adding Players
1. Tap **"Add Player"** button (blue)
2. Enter player name in the alert dialog
3. Tap "Add" to confirm
4. Repeat for all players

#### During the Game
- Each player has a card with:
  - Name display
  - Current score
  - **Minus button** (red circle) - decreases score by 1
  - **Edit button** (blue pencil circle) - **NEW!** Set score directly to any value
  - **Plus button** (green circle) - increases score by 1
- Scores cannot go below 0
- **Direct Score Entry**: Tap the pencil button to:
  - Enter any integer score (positive or negative)
  - Useful for quickly setting scores or making large adjustments
  - Minimum score of 0 is still enforced

#### Ending the Game
1. Tap the **"KABOO!"** button (fancy red-orange gradient with shadow)
2. Alert shows the winner (player with lowest score)
3. Tap "Finish Game" to confirm
4. Game is saved to history

#### Canceling a Game
- Tap "Cancel Game" to discard the current session without saving

### 3. History Tab - Past Games

#### Viewing Game History
- All completed games are listed (newest first)
- Each game card shows:
  - **Date and time** of the game
  - **Winner's name** with trophy icon (🏆)
  - **All players** sorted by score (lowest to highest)
  - **Crown icon** (👑) next to the winner
  - Score for each player

#### Empty State
- If no games have been played yet
- Shows clock icon and helpful message

## Visual Design

### Color Scheme
- **Primary**: Green (tabs, buttons, backgrounds)
- **Accent**: Various (blue for actions, red/orange for Kaboo)
- **Background**: White with green gradient overlays
- **Cards**: White with subtle shadows

### Icons
- **Game Tab**: Club suit (♣️)
- **History Tab**: Clock (🕐)
- **Add Player**: Person with plus
- **Kaboo**: Checkered flag
- **Winner**: Trophy and crown

## Technical Features
- **Data Persistence**: Game history saved automatically using UserDefaults
- **Real-time Updates**: Scores update immediately across the app
- **Shared State**: Single GameStore instance manages all data
- **Error Handling**: Proper logging for data save/load operations
- **Score Validation**: Minimum score of 0 enforced
- **Flexible Scoring**: Both incremental (+/-) and direct score entry supported
- **Custom Game Dates**: Record games with accurate timestamps, including historical games

## Game Rules (Simplified)
1. Each player accumulates points during gameplay
2. When "Kaboo" is called, the round ends
3. The player with the **lowest total score** wins
4. Scores are recorded in the history

## Tips
- Add all players before starting to track scores
- Use the +/- buttons for quick adjustments, or the pencil button to set scores directly
- When recording historical games, use the date picker to set the correct date and time
- Review game history to track player performance over time
- The fancy "KABOO!" button makes ending the game exciting!

---

**Enjoy playing Kaboo!** 🎴
