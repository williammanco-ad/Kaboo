# App Store Metadata

This directory contains the metadata used for the App Store listing.

## Files

- **name.txt**: App name (30 characters max)
- **subtitle.txt**: App subtitle (30 characters max)
- **description.txt**: Full app description (4000 characters max)
- **keywords.txt**: Comma-separated keywords (100 characters max)
- **support_url.txt**: Support/help URL
- **privacy_url.txt**: Privacy policy URL
- **marketing_url.txt**: Marketing website URL

## Screenshots

Add screenshots to the following subdirectories:
- `iphone65/` - iPhone 6.5" display (required)
- `iphone55/` - iPhone 5.5" display
- `ipad129/` - iPad Pro 12.9" display

Screenshots should be:
- PNG or JPEG format
- Without transparency
- At the correct resolution for the device

## Localization

To add support for other languages, create a new directory with the language code:
- `en-US` - English (US)
- `es-ES` - Spanish
- `it-IT` - Italian
- `fr-FR` - French
- etc.

Copy the files from `en-US` and translate the content.

## What to Replace

Before releasing, update the following:

1. **name.txt**: Keep "Kaboo" or customize
2. **subtitle.txt**: Customize the subtitle if needed
3. **description.txt**: Update the description to match your game features
4. **keywords.txt**: Add relevant keywords for App Store search
5. **support_url.txt**: Replace with your actual support URL
6. **privacy_url.txt**: Replace with your actual privacy policy URL
7. **marketing_url.txt**: Replace with your actual website URL

## Updating Metadata

After making changes, deploy with:

```bash
fastlane deliver --skip_binary_upload --skip_screenshots
```

Or the metadata will be automatically updated during the next release.
