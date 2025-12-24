# Kaboo 🎮🃏

[![CI](https://github.com/williammanco-ad/Kaboo/workflows/CI/badge.svg)](https://github.com/williammanco-ad/Kaboo/actions/workflows/ci.yml)
[![Release](https://github.com/williammanco-ad/Kaboo/workflows/Release/badge.svg)](https://github.com/williammanco-ad/Kaboo/actions/workflows/release.yml)
[![License](https://img.shields.io/github/license/williammanco-ad/Kaboo)](LICENSE)

Cards game born in Sicily that conquered the world

## 📱 About

Kaboo is a classic Sicilian card game brought to iOS. Experience the authentic gameplay with modern design and smooth animations.

## ✨ Features

- Classic Kaboo gameplay rules
- Beautiful card designs
- Smooth animations
- Single player mode with AI
- Multiplayer support
- Tutorial for new players
- Statistics and achievements
- Leaderboards

## 🚀 Release Pipeline

This project includes a complete automated release pipeline with:

- **Continuous Integration**: Automated builds and tests on every commit
- **Automated Releases**: Tag-based releases with GitHub Actions
- **TestFlight Distribution**: Beta testing via TestFlight
- **App Store Deployment**: Automated App Store submissions

### Quick Start for Releases

See [RELEASE.md](RELEASE.md) for complete instructions on:
- Setting up the release pipeline
- Configuring code signing
- Deploying to TestFlight
- Releasing to the App Store

### Creating a New Release

```bash
# Tag a new version
git tag v1.0.0
git push origin v1.0.0

# The GitHub Actions workflow will automatically:
# - Build the app
# - Create a GitHub release
# - Generate changelog
```

### Deploy to TestFlight

```bash
# Via GitHub Actions
# Go to Actions → Deploy to App Store → Run workflow → Select "testflight"

# Or locally
fastlane beta
```

## 🛠️ Development

### Prerequisites

- Xcode (latest stable version)
- iOS 14.0 or later
- Swift 5.0 or later
- Fastlane (for deployment)

### Setup

1. Clone the repository
2. Open `Kaboo.xcodeproj` in Xcode
3. Build and run

### Building

```bash
# Build for testing
xcodebuild -project Kaboo.xcodeproj -scheme Kaboo -configuration Debug build

# Run tests
xcodebuild test -project Kaboo.xcodeproj -scheme Kaboo -destination 'platform=iOS Simulator,name=iPhone 15'
```

## 📦 Project Structure

```
.
├── .github/workflows/    # GitHub Actions workflows
│   ├── ci.yml           # Continuous integration
│   ├── release.yml      # Release automation
│   └── appstore.yml     # App Store deployment
├── fastlane/            # Fastlane configuration
│   ├── Fastfile         # Build and deployment lanes
│   ├── Appfile          # App configuration
│   ├── Matchfile        # Code signing configuration
│   └── metadata/        # App Store metadata
├── RELEASE.md           # Release pipeline documentation
└── README.md            # This file
```

## 📄 License

See [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Support

For support, please visit [your support URL] or open an issue on GitHub.

## 🎯 Roadmap

- [ ] Add your Xcode project
- [ ] Configure code signing
- [ ] Test the CI pipeline
- [ ] Deploy to TestFlight
- [ ] Release to App Store

---

Made with ❤️ in Sicily
