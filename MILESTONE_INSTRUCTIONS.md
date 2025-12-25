# GitHub Milestone Instructions

## Creating the Feature Milestone

As requested in the issue, a milestone should be created to track the implementation of the scoring system revamp and game date tracking feature.

### Steps to Create the Milestone

1. Navigate to the repository on GitHub: https://github.com/williammanco-ad/Kaboo
2. Click on the **"Issues"** tab
3. Click on **"Milestones"** (located near the top of the issues list)
4. Click **"New milestone"** button
5. Fill in the following details:

**Milestone Title:** `Scoring System Revamp & Date Tracking`

**Due Date:** (Optional - set based on your project timeline)

**Description:**
```
Implementation of enhanced scoring system and game date tracking features.

## Features Implemented:
- ✅ Direct score input via text entry (allows any positive/negative integer)
- ✅ Game date selection when starting new games
- ✅ Support for recording historical games with custom dates
- ✅ Backward compatibility with existing game data

## Components Modified:
- HomeView.swift - Added DatePickerSheet and direct score input UI
- Models.swift - Updated GameStore.startNewGame() to accept custom dates
- USER_GUIDE.md - Updated documentation
- README.md - Updated with new features

## Acceptance Criteria:
- [x] Users can input or select an integer score (positive/negative) instead of only incrementing/decrementing by one
- [x] The date each game session occurs is recorded (with option for custom dates)
- [x] Backward compatibility maintained with existing data
- [x] UI/UX updated to support new features
```

6. Click **"Create milestone"**
7. Associate this PR/Issue with the milestone

### Alternative: Using GitHub CLI

If you have the GitHub CLI (`gh`) installed and authenticated, you can create the milestone with:

```bash
gh api repos/williammanco-ad/Kaboo/milestones \
  -X POST \
  -f title='Scoring System Revamp & Date Tracking' \
  -f description='Implementation of enhanced scoring system and game date tracking features...'
```

---

**Note:** This milestone has been requested as part of issue acceptance criteria to track the implementation of the scoring revamp and date tracking features.
