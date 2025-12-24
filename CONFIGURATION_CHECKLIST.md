# 📋 Release Configuration Checklist

Use this checklist to ensure you've configured everything needed for releases.

## ☑️ Apple Developer Setup

- [ ] Apple Developer Account (paid membership)
- [ ] App created in App Store Connect
- [ ] Bundle ID created (e.g., `com.yourcompany.kaboo`)
- [ ] App Store Connect API Key created
  - [ ] .p8 file downloaded and saved
  - [ ] Key ID noted
  - [ ] Issuer ID noted

## ☑️ Code Signing Setup

- [ ] Private certificates repository created on GitHub
- [ ] Fastlane match initialized
- [ ] Development certificates generated
- [ ] App Store certificates generated
- [ ] Match password created and saved

## ☑️ Fastlane Configuration Files

### Appfile (`fastlane/Appfile`)
- [ ] `apple_id` - Replace `YOUR_APPLE_ID@example.com`
- [ ] `itc_team_id` - Replace `YOUR_ITC_TEAM_ID`
- [ ] `team_id` - Replace `YOUR_TEAM_ID`
- [ ] `app_identifier` - Replace `com.yourcompany.kaboo`

### Matchfile (`fastlane/Matchfile`)
- [ ] `git_url` - Replace with certificates repo URL
- [ ] `app_identifier` - Replace `com.yourcompany.kaboo`
- [ ] `username` - Replace `YOUR_APPLE_ID@example.com`

### Fastfile (`fastlane/Fastfile`)
- [ ] Verify project name is correct (`Kaboo.xcodeproj`)
- [ ] Verify scheme name is correct (`Kaboo`)

## ☑️ GitHub Secrets

Navigate to: Settings → Secrets and variables → Actions → New repository secret

- [ ] `FASTLANE_USER` - Your Apple ID email
- [ ] `FASTLANE_PASSWORD` - App-specific password
- [ ] `FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD` - App-specific password
- [ ] `MATCH_PASSWORD` - Password for certificates encryption
- [ ] `MATCH_GIT_BASIC_AUTHORIZATION` - Base64 encoded GitHub token
- [ ] `APP_STORE_CONNECT_API_KEY_KEY_ID` - API Key ID
- [ ] `APP_STORE_CONNECT_API_KEY_ISSUER_ID` - API Issuer ID
- [ ] `APP_STORE_CONNECT_API_KEY_KEY` - Content of .p8 file

## ☑️ Xcode Project Setup

- [ ] Xcode project created (`Kaboo.xcodeproj`)
- [ ] Bundle Identifier matches configuration
- [ ] "Automatically manage signing" is OFF
- [ ] Deployment target set (iOS 14.0+)
- [ ] App icon added
- [ ] Launch screen configured

## ☑️ App Store Metadata

### Required Files (in `fastlane/metadata/en-US/`)
- [ ] `name.txt` - Updated
- [ ] `subtitle.txt` - Updated
- [ ] `description.txt` - Updated
- [ ] `keywords.txt` - Updated
- [ ] `support_url.txt` - Replaced with actual URL
- [ ] `privacy_url.txt` - Replaced with actual URL
- [ ] `marketing_url.txt` - Replaced with actual URL

### Required Assets
- [ ] App icon (1024x1024)
- [ ] Screenshots for iPhone 6.5"
- [ ] Screenshots for iPad Pro 12.9" (if supporting iPad)
- [ ] App preview video (optional)

## ☑️ Testing

- [ ] Local build successful
  ```bash
  fastlane build
  ```
- [ ] Local tests passing
  ```bash
  fastlane test
  ```
- [ ] CI workflow runs successfully
- [ ] Can deploy to TestFlight
  ```bash
  fastlane beta
  ```

## ☑️ Documentation

- [ ] Privacy policy created and published
- [ ] Support website/email configured
- [ ] App Store description finalized
- [ ] Screenshots prepared
- [ ] Marketing materials ready

## 🎯 Ready to Release?

If all items above are checked, you're ready to:

1. **Create a release tag:**
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

2. **Deploy to TestFlight:**
   - Via GitHub Actions: Actions → Deploy to App Store → testflight
   - Via command line: `fastlane beta`

3. **Submit to App Store:**
   - Deploy: `fastlane release`
   - Complete metadata in App Store Connect
   - Submit for review

---

**Need help?** See [RELEASE.md](RELEASE.md) for detailed instructions.
