# SecureVault Android APK Build Guide

## Quick Start: Build APK in 5 Minutes

### Prerequisites
- Android Studio (latest version) - free download from https://developer.android.com/studio
- JDK 11 or higher (included with Android Studio)
- ~4GB disk space for build tools
- Your Supabase backend running (for web app)

### Step 1: Open Project in Android Studio

1. Open Android Studio
2. Click **File** → **Open**
3. Navigate to `/Users/manavsarvaiya/Desktop/secure-doc-share-pwa/android`
4. Click **Open**
5. Wait for Gradle to sync (bottom right shows progress)

### Step 2: Configure Web App URL

The Android app needs to know where to load your web app from. Edit `MainActivity.kt`:

```
File: android/app/src/main/java/com/securevault/app/MainActivity.kt
Line: ~76
```

Choose one loading option:

**Option A: Load from deployed website**
```kotlin
webView.loadUrl("https://yourdomain.com")  // Your hosted web app
```

**Option B: Load from localhost (during development)**
```kotlin
webView.loadUrl("http://10.0.2.2:8000")    // Local Python server
```

**Option C: Load from bundled files**
```kotlin
webView.loadUrl("file:///android_asset/index.html")
```

Save the file (Cmd+S).

### Step 3: Build the APK

**For Debug APK (testing, faster build):**
1. Click **Build** → **Build Bundle(s)/APK(s)** → **Build APK(s)**
2. Wait 2-5 minutes
3. Success message appears → Click **Locate**
4. APK is at: `android/app/build/outputs/apk/debug/app-debug.apk`

**For Release APK (optimized, production-ready):**
1. Click **Build** → **Build Bundle(s)/APK(s)** → **Build APK(s)**
2. Or use: **Build** → **Generate Signed Bundle/APK** for Google Play

### Step 4: Install APK on Device or Emulator

#### On Physical Android Device:
1. Connect via USB cable
2. Enable **Developer Mode** → Settings → About → Tap Build Number 7x
3. Enable **USB Debugging** → Settings → Developer Options
4. Run `adb install android/app/build/outputs/apk/debug/app-debug.apk`
5. Or drag APK into Android Studio Device Manager

#### On Android Emulator:
1. Create emulator: **Tools** → **Device Manager** → **Create Device**
2. Start emulator
3. Drag APK onto emulator screen, or run `adb install ...`

### Step 5: Test the App

1. Launch SecureVault from app drawer
2. App should load your web app in full screen
3. Test:
   - ✅ Login/signup works
   - ✅ Document upload works
   - ✅ File permissions granted
   - ✅ Back button navigates in web app

---

## Important Configuration Files

### Main Activity (java/com/securevault/app/MainActivity.kt)
- Handles WebView setup
- Manages permissions (camera, storage, internet)
- Specifies which URL to load

### Android Manifest (AndroidManifest.xml)
- App permissions: INTERNET, STORAGE, CAMERA
- App metadata

### Build Configuration (app/build.gradle)
- Target SDK: 34 (Android 14)
- Min SDK: 24 (Android 7.0+)
- App version and name

---

## URL Configuration for Different Environments

### Development (Local Server)
```kotlin
webView.loadUrl("http://10.0.2.2:8000")
```
- 10.0.2.2 is the emulator's way to reach localhost
- Make sure your Python server is running on port 8000

### Production (Deployed Website)
```kotlin
webView.loadUrl("https://yourdomain.com")
```
- Replace with your actual domain
- MUST use HTTPS for Supabase auth to work

### Bundled (Offline-ready)
```kotlin
webView.loadUrl("file:///android_asset/index.html")
```
- Copy all your HTML/CSS/JS files to `android/app/src/main/assets/`
- Works offline after APK installation

---

## Permissions Included

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.CAMERA" />
```

These allow:
- 🌐 Internet access for Supabase
- 📁 File upload/download
- 📷 Camera functionality (if needed)

---

## Troubleshooting

### "Gradle sync failed"
→ File → Sync Now
→ Or: File → Invalidate Caches → Restart

### "App won't load (white screen)"
→ Check URL in MainActivity.kt is correct
→ Check Python server is running (for localhost)
→ Check INTERNET permission is granted
→ Open Chrome DevTools (via `adb shell pm grant` for web debugging)

### "WebView permission denied"
→ Android 6+ requires runtime permissions
→ App will prompt user on first launch
→ Check AndroidManifest.xml has permissions

### "Can't find adb command"
→ Add Android SDK tools to PATH:
```bash
export PATH="$PATH:~/Library/Android/sdk/platform-tools"
```

---

## Build & Release for Google Play Store

### 1. Create Signed APK
1. **Build** → **Generate Signed Bundle/APK**
2. Choose **APK**
3. Click **Create new...** to create keystore
4. Fill in details:
   - Key store path: `securevault.jks`
   - Key alias: `securevault`
   - Password: (choose strong password)
5. Build release APK

### 2. Test Signed APK
```bash
adb install android/app/release/app-release.apk
```

### 3. Upload to Google Play Console
1. Go to https://play.google.com/console
2. Create new app (or use existing)
3. Fill in app info
4. Upload APK to Internal Testing track
5. Test thoroughly
6. Promote to Production

### 4. Submit for Review
- Follow Google Play policies
- Add screenshots, description, privacy policy
- Submit for review (takes 1-24 hours)

---

## Project Structure

```
android/
├── app/
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/securevault/app/
│   │   │   │   └── MainActivity.kt          ← Main app logic
│   │   │   ├── res/
│   │   │   │   ├── layout/activity_main.xml ← UI layout
│   │   │   │   ├── values/
│   │   │   │   │   ├── strings.xml
│   │   │   │   │   └── themes.xml
│   │   │   │   └── xml/
│   │   │   │       ├── backup_rules.xml
│   │   │   │       └── data_extraction_rules.xml
│   │   │   └── AndroidManifest.xml          ← App config
│   │   └── test/                            ← Unit tests
│   ├── build.gradle                         ← App build config
│   └── proguard-rules.pro                   ← Code obfuscation
├── build.gradle                             ← Project config
├── settings.gradle
├── gradle.properties
└── local.properties                         ← (auto-generated)
```

---

## Advanced: Bundled Web App (Offline)

To bundle your web app so it doesn't need internet:

1. Create folder: `android/app/src/main/assets/`
2. Copy all files from web app root:
   ```bash
   cp -r /Users/manavsarvaiya/Desktop/secure-doc-share-pwa/*.html \
         android/app/src/main/assets/
   cp -r /Users/manavsarvaiya/Desktop/secure-doc-share-pwa/css \
         android/app/src/main/assets/
   cp -r /Users/manavsarvaiya/Desktop/secure-doc-share-pwa/js \
         android/app/src/main/assets/
   ```
3. In MainActivity.kt, change URL to:
   ```kotlin
   webView.loadUrl("file:///android_asset/index.html")
   ```
4. Rebuild APK

---

## Support & Next Steps

- ✅ APK built successfully? Install and test
- ❌ Errors? Check troubleshooting section above
- 🚀 Ready to publish? Follow Google Play Store steps
- 📱 Need custom features? Modify MainActivity.kt

For questions about Android development:
- https://developer.android.com/docs
- https://stackoverflow.com/questions/tagged/android
