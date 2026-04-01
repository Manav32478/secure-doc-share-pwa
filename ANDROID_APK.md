# SecureVault Android APK - Quick Start Guide

## 🚀 Build Your APK in 3 Steps

Your complete Android project is ready in the `android/` folder!

### Step 1: Download & Install Android Studio
- Go to: https://developer.android.com/studio
- Download and install (free)
- Launch Android Studio

### Step 2: Open the Project
1. File → Open
2. Select: `/Users/manavsarvaiya/Desktop/secure-doc-share-pwa/android`
3. Click Open
4. Wait for Gradle sync to complete (2-3 minutes)

### Step 3: Build the APK
- Click: **Build** → **Build Bundle(s)/APK(s)** → **Build APK(s)**
- Wait 2-5 minutes
- APK location: `android/app/build/outputs/apk/debug/app-debug.apk`

✅ Done! Your APK is ready to install on Android devices.

---

## 📋 Project Structure

```
android/
├── app/
│   ├── src/main/
│   │   ├── java/com/securevault/app/MainActivity.kt  ← Main app logic
│   │   ├── res/layout/activity_main.xml
│   │   ├── AndroidManifest.xml
│   └── build.gradle
├── build.gradle
├── settings.gradle
└── BUILD_APK.md  ← Full detailed guide
```

---

## 🔧 Key Configuration

### Change App URL
File: `android/app/src/main/java/com/securevault/app/MainActivity.kt` (line ~76)

```kotlin
// Option 1: Load from hosted website
webView.loadUrl("https://yourdomain.com")

// Option 2: Load from localhost (dev)
webView.loadUrl("http://10.0.2.2:8000")

// Option 3: Load from bundled files
webView.loadUrl("file:///android_asset/index.html")
```

### App Permissions
Defined in `AndroidManifest.xml`:
- ✅ Internet (Supabase)
- ✅ File access (uploads/downloads)
- ✅ Camera
- ✅ Storage

---

## 📱 Install on Device

### On Physical Phone (via USB):
```bash
cd android
./gradlew installDebug
```

### On Android Emulator:
1. Create virtual device in Android Studio
2. Start emulator
3. Drag APK into emulator window

---

## 🎯 What This APK Includes

✅ Full SecureVault web app in native Android wrapper  
✅ Document upload/download  
✅ Supabase authentication  
✅ File permissions (camera, storage)  
✅ Modern design with smooth animations  
✅ Screenshot/recording protection  
✅ Responsive mobile UI  

---

## 📖 Full Documentation

See `android/BUILD_APK.md` for:
- Detailed step-by-step build instructions
- Troubleshooting guide
- Google Play Store submission steps
- Custom configuration options
- Advanced bundling techniques

---

## ⚡ Next Steps

1. **Build APK:** Open Android Studio, build (3 min)
2. **Test:** Install on emulator or device
3. **Customize:** Edit MainActivity.kt for your needs
4. **Deploy:** Submit to Google Play Store

---

## ❓ Need Help?

### Common Issues:
- **Gradle sync fails:** File → Sync Now
- **White screen:** Check URL in MainActivity.kt
- **Permission denied:** Confirm AndroidManifest.xml has permissions

### Resources:
- Android Docs: https://developer.android.com/docs
- StackOverflow: Tag your question with `android-webview`
- Supabase Docs: https://supabase.com/docs

---

## 🔐 Security Notes

- APK loads your web app in a WebView (sandboxed)
- Supabase auth tokens handled securely by browser
- Data encrypted in transit (HTTPS)
- No sensitive data stored in APK

---

**Ready to build?** Open Android Studio and start the build process! 🎉
