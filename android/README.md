# SecureVault Android Project

This is a native Android wrapper around your SecureVault web app. It uses Android's WebView to display your web application in a native container.

## Project Structure

```
android/
├── app/                                    # Main app module
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/securevault/app/
│   │   │   │   └── MainActivity.kt         # Main activity - loads WebView
│   │   │   ├── res/
│   │   │   │   ├── layout/
│   │   │   │   │   └── activity_main.xml  # UI layout (WebView)
│   │   │   │   ├── values/
│   │   │   │   │   ├── strings.xml        # App strings
│   │   │   │   │   └── themes.xml         # App theme
│   │   │   │   └── xml/
│   │   │   │       ├── backup_rules.xml
│   │   │   │       └── data_extraction_rules.xml
│   │   │   └── AndroidManifest.xml        # App configuration
│   │   └── test/                          # Unit tests
│   ├── build.gradle                       # App build configuration
│   └── proguard-rules.pro                 # Code obfuscation rules
├── gradle/
│   └── wrapper/                           # Gradle wrapper files
├── settings.gradle                        # Project settings
├── build.gradle                           # Project-level build config
├── gradle.properties                      # Gradle properties
├── gradlew                                # Gradle wrapper (macOS/Linux)
├── gradlew.bat                            # Gradle wrapper (Windows)
├── BUILD_APK.md                           # Complete build guide
└── .gitignore                             # Git ignore rules
```

## Quick Start

1. **Open in Android Studio:**
   - File → Open → Select this `android` folder
   
2. **Wait for Gradle sync** (2-3 minutes)

3. **Build APK:**
   - Build → Build Bundle(s)/APK(s) → Build APK(s)

4. **Install:**
   - Connect Android device or start emulator
   - Drag APK to emulator, or run `adb install`

## Key Features

- ✅ WebView-based wrapper for your web app
- ✅ Full Supabase integration support
- ✅ Camera and file access permissions
- ✅ Network connectivity handling
- ✅ Screenshot protection (from web app)
- ✅ Back button navigation support
- ✅ Release & debug builds configured

## Configuration Files

### MainActivity.kt
Contains the core logic:
- WebView initialization
- Permission requests
- URL loading (line ~76, change as needed)
- Permission request handling

### AndroidManifest.xml
App configuration:
- Application ID: `com.securevault.app`
- App name: `SecureVault`
- Required permissions
- Target SDK: 34 (Android 14)
- Min SDK: 24 (Android 7.0+)

### build.gradle (app-level)
Build configuration:
- Dependencies (AndroidX, Material Design)
- Target/compile SDK versions
- Build types (debug/release)
- Kotlin configuration

## URL Configuration

In `MainActivity.kt` line ~76, choose how to load your app:

```kotlin
// Option A: Hosted website
webView.loadUrl("https://your-domain.com")

// Option B: Local development server
webView.loadUrl("http://10.0.2.2:8000")

// Option C: Bundled files
webView.loadUrl("file:///android_asset/index.html")
```

## Building for Production

### Debug APK (Development)
```bash
./gradlew assembleDebug
# Output: app/build/outputs/apk/debug/app-debug.apk
```

### Release APK (Production)
```bash
./gradlew assembleRelease
# Output: app/build/outputs/apk/release/app-release.apk
```

### Signed APK (Google Play)
```bash
./gradlew bundleRelease
# Then upload to Google Play Console
```

## Libraries & Dependencies

- **AndroidX Core:** Low-level Android APIs
- **AndroidX AppCompat:** Backward compatibility
- **Material Design:** Modern UI components
- **WebView:** Built-in Android component (no external dependency)

## Permissions Included

| Permission | Purpose |
|-----------|---------|
| INTERNET | Connect to Supabase backend |
| READ_EXTERNAL_STORAGE | Read files for upload |
| WRITE_EXTERNAL_STORAGE | Save downloaded files |
| CAMERA | Camera access (if needed) |
| ACCESS_NETWORK_STATE | Check network connectivity |

## For More Information

See **BUILD_APK.md** for detailed instructions on:
- Step-by-step build process
- Troubleshooting
- Google Play Store deployment
- Advanced configuration
- Testing on devices/emulators

## Support

- **Android Documentation:** https://developer.android.com/docs
- **WebView Guide:** https://developer.android.com/guide/webapps/webview
- **Kotlin Documentation:** https://kotlinlang.org/docs
