# 🔄 Quick Start: What to Replace

This guide shows exactly what to replace to configure the release pipeline for your Kaboo app.

## 📍 Location Guide

### 1. Fastlane Configuration Files

#### File: `fastlane/Appfile`

```ruby
# Line 5: Replace with YOUR Apple ID
apple_id("YOUR_APPLE_ID@example.com")
# Example: apple_id("john.doe@example.com")

# Line 8: Replace with YOUR iTunes Connect Team ID
# Find it: App Store Connect → Users and Access → Team ID
itc_team_id("YOUR_ITC_TEAM_ID")
# Example: itc_team_id("123456789")

# Line 11: Replace with YOUR Developer Team ID
# Find it: Apple Developer → Membership → Team ID
team_id("YOUR_TEAM_ID")
# Example: team_id("ABCD123456")

# Line 14: Replace with YOUR app's Bundle ID
# This should match what you create in App Store Connect
app_identifier("com.yourcompany.kaboo")
# Example: app_identifier("com.acme.kaboo")
```

#### File: `fastlane/Matchfile`

```ruby
# Line 5: Replace with YOUR certificates repository URL
git_url("https://github.com/YOUR_USERNAME/certificates")
# Example: git_url("https://github.com/john-doe/kaboo-certificates")

# Line 12: Replace with YOUR app's Bundle ID (same as Appfile)
app_identifier(["com.yourcompany.kaboo"])
# Example: app_identifier(["com.acme.kaboo"])

# Line 15: Replace with YOUR Apple ID (same as Appfile)
username("YOUR_APPLE_ID@example.com")
# Example: username("john.doe@example.com")
```

#### File: `fastlane/Fastfile`

Most values are automatically configured, but verify:

```ruby
# Line 15 & 26 & 49 & 69: Project name (if different)
increment_build_number(xcodeproj: "Kaboo.xcodeproj")
# Change "Kaboo.xcodeproj" if your project name is different

# Line 23 & 34 & 60 & 80: Scheme name (if different)
gym(scheme: "Kaboo", ...)
# Change "Kaboo" if your scheme name is different
```

### 2. App Store Metadata

#### File: `fastlane/metadata/en-US/name.txt`
```
Kaboo
```
↓ Replace if you want a different app name (30 chars max)
```
Your App Name
```

#### File: `fastlane/metadata/en-US/subtitle.txt`
```
Play the classic Sicilian card game
```
↓ Customize your subtitle (30 chars max)
```
Your custom subtitle
```

#### File: `fastlane/metadata/en-US/description.txt`
```
Kaboo - The Classic Sicilian Card Game

Experience the authentic card game...
```
↓ Update with your actual app description (4000 chars max)

#### File: `fastlane/metadata/en-US/keywords.txt`
```
kaboo, card game, sicilian, cards, game, classic, traditional, italy, sicily
```
↓ Add your relevant keywords (100 chars max, comma-separated)

#### File: `fastlane/metadata/en-US/support_url.txt`
```
https://yourwebsite.com/support
```
↓ Replace with YOUR support URL
```
https://kaboo.app/support
```

#### File: `fastlane/metadata/en-US/privacy_url.txt`
```
https://yourwebsite.com/privacy
```
↓ Replace with YOUR privacy policy URL
```
https://kaboo.app/privacy
```

#### File: `fastlane/metadata/en-US/marketing_url.txt`
```
https://yourwebsite.com
```
↓ Replace with YOUR marketing website
```
https://kaboo.app
```

### 3. GitHub Secrets

Go to: **GitHub Repository → Settings → Secrets and variables → Actions**

Click "New repository secret" for each:

| Secret Name | Value | Where to Get It |
|------------|-------|-----------------|
| `FASTLANE_USER` | `your.email@example.com` | Your Apple ID |
| `FASTLANE_PASSWORD` | `abcd-efgh-ijkl-mnop` | appleid.apple.com → App-Specific Passwords |
| `FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD` | `abcd-efgh-ijkl-mnop` | Same as above |
| `MATCH_PASSWORD` | `your-secure-password` | Create a strong password |
| `MATCH_GIT_BASIC_AUTHORIZATION` | `dXNlcm5hbWU6dG9rZW4=` | See below* |
| `APP_STORE_CONNECT_API_KEY_KEY_ID` | `ABCD1234EF` | App Store Connect → API Keys |
| `APP_STORE_CONNECT_API_KEY_ISSUER_ID` | `12345678-1234-1234-1234-123456789012` | App Store Connect → API Keys |
| `APP_STORE_CONNECT_API_KEY_KEY` | `-----BEGIN PRIVATE KEY-----...` | Content of downloaded .p8 file |

*To generate `MATCH_GIT_BASIC_AUTHORIZATION`:
```bash
echo -n "your_github_username:your_personal_access_token" | base64
```

### 4. Xcode Project

In Xcode:
1. Select your project in the navigator
2. Select the Kaboo target
3. Go to "Signing & Capabilities"
4. **Bundle Identifier**: Set to `com.yourcompany.kaboo` (same as Appfile)
5. **Team**: Select your team
6. **Automatically manage signing**: Turn OFF
7. **Provisioning Profile**: Will be managed by fastlane match

## 🎯 Search & Replace Quick Commands

Use these commands to quickly replace values:

```bash
# Navigate to repository
cd /path/to/Kaboo

# Replace Apple ID (update both occurrences)
find fastlane -name "*.rb" -o -name "Appfile" -o -name "Matchfile" | xargs sed -i '' 's/YOUR_APPLE_ID@example.com/your.real.email@example.com/g'

# Replace Bundle ID
find fastlane -name "*.rb" -o -name "Appfile" -o -name "Matchfile" | xargs sed -i '' 's/com.yourcompany.kaboo/com.realcompany.kaboo/g'

# Replace certificates repo URL
sed -i '' 's|YOUR_USERNAME|yourusername|g' fastlane/Matchfile

# Replace team IDs (do these manually in the files)
# They have specific values that need to come from Apple
```

## ✅ Verification

After replacing all values, verify:

```bash
# Check Appfile
cat fastlane/Appfile | grep -E "apple_id|team_id|app_identifier"

# Check Matchfile
cat fastlane/Matchfile | grep -E "git_url|app_identifier|username"

# Check metadata URLs
cat fastlane/metadata/en-US/*_url.txt
```

## 🚨 Common Mistakes to Avoid

1. ❌ Don't leave placeholder values like `YOUR_APPLE_ID`
2. ❌ Don't use different Bundle IDs in different files
3. ❌ Don't commit the .p8 file to the repository (use GitHub Secrets)
4. ❌ Don't use your actual Apple password (use app-specific password)
5. ❌ Don't make the certificates repository public

## 📚 Next Steps

After replacing all values:

1. ✅ Review [CONFIGURATION_CHECKLIST.md](CONFIGURATION_CHECKLIST.md)
2. ✅ Read [RELEASE.md](RELEASE.md) for complete setup instructions
3. ✅ Test locally: `fastlane build`
4. ✅ Create your first release tag

---

**Questions?** See [RELEASE.md](RELEASE.md) for detailed documentation.
