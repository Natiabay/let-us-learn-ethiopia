# 📸 Screenshot Generation Guide

## Automated Screenshot Capture

### Requirements
- Device with Tourist Assistant Ethiopia installed
- High-resolution display (1080p+ for Android, Retina for iOS)
- Sample data and stable internet connection

### Screenshot List

#### Google Play Store (Android)
**Dimensions**: 1080 x 1920 pixels (9:16 ratio)

1. **Home Dashboard**
   - Show main navigation with Ethiopian flag colors
   - Display AI chat, maps, and language learning options
   - Include weather widget for Addis Ababa
   - Filename: `01_home_dashboard.png`

2. **AI Chat Interface**
   - Conversation asking "Tell me about Lalibela"
   - Show AI response with cultural insights
   - Include voice message button
   - Filename: `02_ai_chat.png`

3. **Interactive Map**
   - Ethiopian map showing multiple locations
   - Lalibela, Axum, and Gondar marked
   - Location details popup visible
   - Filename: `03_interactive_map.png`

4. **Language Learning**
   - Amharic lesson screen (English → Amharic)
   - Show "Hello" translation with audio button
   - Progress bar and achievement indicators
   - Filename: `04_language_learning.png`

5. **Location Details**
   - Lalibela rock churches detailed page
   - High-quality photos and description
   - Visitor information and hours
   - Filename: `05_location_details.png`

6. **Cultural Guide**
   - Ethiopian coffee ceremony guide
   - Step-by-step instructions with images
   - Traditional music player
   - Filename: `06_cultural_guide.png`

7. **Offline Features**
   - Cached content working without internet
   - Downloaded maps and lessons
   - Offline indicator in status bar
   - Filename: `07_offline_features.png`

8. **Multi-language Support**
   - Language selection screen
   - 8+ language options displayed
   - Ethiopian and source language flags
   - Filename: `08_multilingual.png`

#### Apple App Store (iOS)
**Dimensions**: 1290 x 2796 pixels (iPhone 6.7")

Same content as Android but optimized for iOS design:
- Native iOS navigation patterns
- iOS-style alerts and modals
- SF Pro font usage
- iOS color scheme adaptation

#### Web Store Assets
**Dimensions**: 1920 x 1080 pixels (16:9 ratio)

- Desktop browser screenshots
- Responsive design demonstration
- Progressive Web App (PWA) features

### Capture Instructions

#### Manual Capture
1. Launch Tourist Assistant Ethiopia
2. Navigate to each required screen
3. Ensure sample data is populated
4. Capture screenshots using:
   - Android: Volume Down + Power Button
   - iOS: Side Button + Volume Up Button
   - Web: Browser screenshot tool

#### Automated Capture (Advanced)
```bash
# Using Flutter integration testing
flutter test integration_test/screenshot_test.dart
```

### Post-Processing
1. **Crop and Resize**: Ensure exact dimensions for each store
2. **Add Device Frames**: Optional but recommended for appeal
3. **Optimize File Size**: Use PNG compression
4. **Quality Check**: Verify text readability and image clarity

### Screenshot Mockup Templates
- Use online tools like Previewed, Mockuphone, or App Store Screenshot
- Add device frames for professional appearance
- Consider adding marketing text overlays (store-permitting)

### Store-Specific Requirements

#### Google Play Store
- 2-8 screenshots required
- PNG or JPEG format
- 16:9 or 9:16 aspect ratio
- Max 8MB file size
- Min 320px for any side

#### Apple App Store
- 3-10 screenshots per device size
- PNG or JPEG (RGB color space)
- No alpha channels or transparency
- Text should be legible at all sizes

### Quality Checklist
- [ ] All text is readable and properly sized
- [ ] UI elements are properly aligned
- [ ] No cut-off content at screen edges
- [ ] Consistent branding and color scheme
- [ ] Sample data looks realistic and relevant
- [ ] No placeholder or Lorem Ipsum text
- [ ] Screenshots show key app functionality
- [ ] Cultural content is accurate and respectful

### Marketing Enhancement
- Consider adding subtle text overlays highlighting key features
- Use consistent Ethiopian color scheme (Green, Yellow, Red)
- Ensure screenshots tell a story of the user journey
- Highlight unique features that differentiate from competitors

### File Organization
```
screenshots/
├── android/
│   ├── phone/
│   └── tablet/
├── ios/
│   ├── iphone_67/
│   ├── iphone_65/
│   └── ipad/
└── web/
    └── desktop/
```

### Localization
- Consider screenshots in Amharic for Ethiopian market
- Maintain English screenshots for international appeal
- Ensure cultural sensitivity in all visual content

























