# 🚀 Release Pipeline Documentation

This document provides comprehensive instructions for releasing the Kaboo card game app.

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Initial Setup](#initial-setup)
- [Configuration Steps](#configuration-steps)
- [Release Process](#release-process)
- [Troubleshooting](#troubleshooting)

## Overview

The Kaboo app uses an automated release pipeline with the following components:
- **GitHub Actions**: Automated CI/CD workflows
- **Fastlane**: iOS build and deployment automation
- **TestFlight**: Beta testing distribution
- **App Store Connect**: Production releases

## Prerequisites

Before you can use the release pipeline, ensure you have:

1. **Apple Developer Account** (paid membership required)
2. **App Store Connect** access
3. **Xcode** installed (latest stable version)
4. **GitHub** repository access with admin permissions
5. **Fastlane** installed locally (`gem install fastlane`)

## Initial Setup

### 1. Create Your Xcode Project

First, create your Kaboo game project in Xcode:

```bash
# This repository contains only the pipeline infrastructure
# You need to create your actual Xcode project
# Name it: Kaboo.xcodeproj
# Scheme name: Kaboo
```

### 2. App Store Connect Setup

1. Go to [App Store Connect](https://appstoreconnect.apple.com/)
2. Create a new app:
   - **Platform**: iOS
   - **Name**: Kaboo
   - **Primary Language**: English (or your preference)
   - **Bundle ID**: Create a unique bundle ID (e.g., `com.yourcompany.kaboo`)
   - **SKU**: A unique identifier for your app

3. Create an App Store Connect API Key:
   - Go to Users and Access → Keys → App Store Connect API
   - Click the + button to create a new key
   - Give it a name (e.g., "GitHub Actions")
   - Download the .p8 file (you can only download it once!)
   - Note the **Key ID** and **Issuer ID**

### 3. Code Signing Setup

Code signing is handled by `fastlane match`. You need a separate private Git repository to store your certificates:

```bash
# 1. Create a new PRIVATE repository on GitHub (e.g., kaboo-certificates)
# 2. Initialize fastlane match
fastlane match init

# 3. Generate certificates and provisioning profiles
fastlane setup_signing
```

This will create and store your certificates in the private repository.

## Configuration Steps

### Step 1: Update Fastlane Configuration Files

#### A. Edit `fastlane/Appfile`

Replace the following placeholders:

```ruby
# Replace YOUR_APPLE_ID@example.com
apple_id("john.doe@example.com")

# Replace YOUR_ITC_TEAM_ID
# Find it in App Store Connect → Users and Access → Team ID
itc_team_id("123456789")

# Replace YOUR_TEAM_ID
# Find it in Apple Developer → Membership → Team ID
team_id("ABCD123456")

# Replace com.yourcompany.kaboo
# Use the Bundle ID you created in App Store Connect
app_identifier("com.yourcompany.kaboo")
```

#### B. Edit `fastlane/Matchfile`

Replace the following placeholders:

```ruby
# Replace with your certificates repository
git_url("https://github.com/yourcompany/kaboo-certificates")

# Replace with your actual app identifier
app_identifier(["com.yourcompany.kaboo"])

# Replace with your Apple ID
username("john.doe@example.com")
```

#### C. Edit `fastlane/Fastfile`

Update the project name if different:

```ruby
# Find and replace "Kaboo.xcodeproj" with your actual project name
# Find and replace "Kaboo" scheme name if different
```

### Step 2: Configure GitHub Secrets

Add the following secrets to your GitHub repository (Settings → Secrets and variables → Actions):

#### Required Secrets:

1. **FASTLANE_USER**
   - Your Apple ID email address
   - Example: `john.doe@example.com`

2. **FASTLANE_PASSWORD**
   - Your Apple ID password
   - Use an app-specific password (recommended)
   - Generate at: https://appleid.apple.com/account/manage

3. **FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD**
   - App-specific password for fastlane
   - Same as above if using app-specific password

4. **MATCH_PASSWORD**
   - Password to encrypt/decrypt certificates
   - Create a strong password and save it securely

5. **MATCH_GIT_BASIC_AUTHORIZATION**
   - Base64 encoded GitHub credentials for certificates repo
   - Generate with: `echo -n "your_github_username:your_personal_access_token" | base64`
   - Personal access token needs `repo` scope

6. **APP_STORE_CONNECT_API_KEY_KEY_ID**
   - The Key ID from App Store Connect API key
   - Example: `ABCD1234EF`

7. **APP_STORE_CONNECT_API_KEY_ISSUER_ID**
   - The Issuer ID from App Store Connect API key
   - Example: `12345678-1234-1234-1234-123456789012`

8. **APP_STORE_CONNECT_API_KEY_KEY**
   - The content of the .p8 file (the entire file content)
   - Open the .p8 file in a text editor and copy all content

### Step 3: Update Bundle Identifier in Xcode

1. Open your Xcode project
2. Select the project in the navigator
3. Select your target
4. Go to "Signing & Capabilities"
5. Set the Bundle Identifier to match what you configured (e.g., `com.yourcompany.kaboo`)
6. Ensure "Automatically manage signing" is **OFF** (fastlane match will handle it)

## Release Process

### Continuous Integration (Automatic)

Every push to `main` or `develop` branch automatically:
- Builds the app
- Runs tests
- Reports status

### Creating a Release

#### Method 1: Tag-based Release (Recommended)

```bash
# 1. Update version in Xcode (optional, fastlane can handle this)
# 2. Commit all changes
git add .
git commit -m "Prepare for release v1.0.0"

# 3. Create and push a version tag
git tag v1.0.0
git push origin v1.0.0

# 4. GitHub Actions will automatically:
#    - Build the app
#    - Create a GitHub release
#    - Generate changelog from commits
```

#### Method 2: Manual Deployment

##### Deploy to TestFlight (Beta Testing)

```bash
# Local deployment
fastlane beta

# OR via GitHub Actions
# Go to Actions → Deploy to App Store → Run workflow
# Select "testflight"
```

##### Deploy to App Store (Production)

```bash
# Local deployment
fastlane release

# OR via GitHub Actions
# Go to Actions → Deploy to App Store → Run workflow
# Select "appstore"
```

### Version Numbering

Follow semantic versioning: `MAJOR.MINOR.PATCH`

- **MAJOR**: Breaking changes or major new features
- **MINOR**: New features, backwards compatible
- **PATCH**: Bug fixes

Examples:
- `v1.0.0` - Initial release
- `v1.1.0` - New game features
- `v1.1.1` - Bug fixes

### What Happens During Release

1. **Build Phase**:
   - Increment build number automatically
   - Sync code signing certificates
   - Build IPA file

2. **TestFlight Phase**:
   - Upload IPA to TestFlight
   - Available to beta testers in ~15 minutes
   - Send notification when ready

3. **App Store Phase**:
   - Upload IPA to App Store
   - Update metadata if changed
   - Submit for review (manual step in App Store Connect)

## Post-Release Steps

After deploying to App Store:

1. **Go to App Store Connect**
2. Navigate to your app → App Store → Version
3. Complete the following:
   - Add screenshots (required)
   - Add app preview videos (optional)
   - Fill in description and keywords
   - Set pricing and availability
   - Click "Submit for Review"

4. **Wait for Apple Review** (typically 24-48 hours)

5. **Monitor TestFlight**:
   - Invite beta testers
   - Collect feedback
   - Fix critical issues before public release

## Maintenance

### Updating Certificates

Certificates expire after 1 year. To renew:

```bash
fastlane match nuke distribution
fastlane match nuke development
fastlane setup_signing
```

### Updating Fastlane

```bash
gem update fastlane
```

### Monitoring Builds

- Check GitHub Actions tab for build status
- Review logs if builds fail
- Set up notifications in GitHub settings

## Troubleshooting

### Common Issues

#### 1. Code Signing Errors

**Problem**: "No signing certificate found"

**Solution**:
```bash
fastlane match development --readonly false
fastlane match appstore --readonly false
```

#### 2. Build Number Conflicts

**Problem**: "A build with this number already exists"

**Solution**:
- Manually increment build number in Xcode
- Or let fastlane handle it automatically

#### 3. API Key Issues

**Problem**: "Invalid API key"

**Solution**:
- Verify the .p8 file content is correct
- Check Key ID and Issuer ID match
- Ensure the key hasn't been revoked

#### 4. Two-Factor Authentication

**Problem**: Fastlane stuck on 2FA

**Solution**:
- Use app-specific passwords instead
- Set `FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD`

#### 5. Match Repository Access

**Problem**: "Can't access certificates repository"

**Solution**:
- Verify the repository URL in Matchfile
- Check `MATCH_GIT_BASIC_AUTHORIZATION` is correct
- Ensure the repository is private

### Getting Help

- **Fastlane Docs**: https://docs.fastlane.tools/
- **GitHub Actions Docs**: https://docs.github.com/actions
- **Apple Developer Forums**: https://developer.apple.com/forums/

## Summary Checklist

Before your first release, ensure:

- [ ] Xcode project created and configured
- [ ] App created in App Store Connect
- [ ] Bundle ID configured correctly
- [ ] App Store Connect API key created and saved
- [ ] Certificates repository created (private)
- [ ] Code signing setup completed
- [ ] All GitHub secrets configured
- [ ] Fastlane files updated with your information
- [ ] Test build runs successfully locally
- [ ] CI workflow runs successfully on GitHub

## Quick Reference

### Commands

```bash
# Test locally
fastlane test

# Build locally
fastlane build

# Deploy to TestFlight
fastlane beta

# Deploy to App Store
fastlane release

# Setup/update signing
fastlane setup_signing
```

### File Locations

- **Workflows**: `.github/workflows/`
- **Fastlane**: `fastlane/`
- **Build output**: `./build/`
- **Certificates**: Private repository

---

**Good luck with your Kaboo card game release! 🎮🃏**
