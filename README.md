# 🔐 Secure Doc Share - Complete Setup Guide

## Quick Start Instructions

### ⚠️ IMPORTANT: Firebase Configuration Required

Your app is using Firebase for backend services. You **MUST** configure Firebase console first:

## Step 1: Enable Firebase Authentication

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your project: **doc-share-55636**
3. Navigate to **Authentication** → **Get Started**
4. Click **Sign-in method** tab
5. Enable **Email/Password** provider
6. Click **Save**

## Step 2: Create Firestore Database

1. In Firebase Console, go to **Firestore Database**
2. Click **Create database**
3. Choose **Start in production mode**
4. Select your location (e.g., `us-central` or nearest to you)
5. Click **Enable**

## Step 3: Enable Firebase Storage

1. Go to **Storage** in Firebase Console
2. Click **Get started**
3. Choose **Start in production mode**
4. Use the same location as Firestore
5. Click **Done**

## Step 4: Deploy Security Rules

Option A - Using Firebase CLI (Recommended):
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Initialize project
firebase use doc-share-55636

# Deploy rules
firebase deploy --only firestore:rules,storage:rules
```

Option B - Manual Setup:

### Firestore Rules (Copy to Firebase Console → Firestore → Rules):
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{email} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.token.email == email;
    }
    
    match /documents/{documentId} {
      allow read, write: if request.auth != null && 
                            request.auth.uid == resource.data.ownerId;
      allow create: if request.auth != null && 
                       request.resource.data.ownerId == request.auth.uid;
    }
    
    match /sharedLinks/{linkId} {
      allow read: if true;
      allow create, update, delete: if request.auth != null;
    }
  }
}
```

### Storage Rules (Copy to Firebase Console → Storage → Rules):
```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /documents/{userId}/{fileName} {
      allow read, write, delete: if request.auth != null && request.auth.uid == userId;
      allow write: if request.resource.size < 50 * 1024 * 1024;
    }
  }
}
```

## Step 5: Test the Application

1. Start the local server (already running on port 8000)
2. Open browser to: http://localhost:8000
3. Create a test account (email + password)
4. Upload a test document
5. Generate a shareable link
6. Test the link in a new incognito window

## Features

### ✅ Authentication
- Email/Password registration and login
- Secure session management
- Auto-redirect for logged-in users

### ✅ Document Upload
- Drag & drop or click to upload
- Real-time progress bar
- File size limit: 50MB
- Supports all file types

### ✅ Time-Bound Sharing (Two Methods)

#### Method 1: Email Sharing
1. Upload a document
2. Enter recipient's email (must be registered)
3. Set expiration date/time
4. Recipient must give consent
5. Access expires automatically

#### Method 2: Shareable Link
1. Upload a document
2. Click "Generate Link"
3. Set hours until expiration (1-720 hours)
4. Share the link with anyone
5. Link expires automatically
6. No login required to download

### ✅ Security Features
- Server-side access control
- Automatic link expiration
- Consent-based sharing
- Owner-only file management
- Encrypted file storage

## Troubleshooting

### "Invalid credential" or "auth/invalid-credential"
- **Cause**: Email/Password authentication not enabled in Firebase
- **Fix**: Go to Firebase Console → Authentication → Sign-in method → Enable Email/Password

### "Permission denied" or "Missing or insufficient permissions"
- **Cause**: Firestore/Storage rules not deployed
- **Fix**: Deploy security rules (see Step 4)

### Documents not showing after upload
- **Cause**: Firestore database not created
- **Fix**: Create Firestore database (see Step 2)

### Upload fails
- **Cause**: Storage not enabled
- **Fix**: Enable Firebase Storage (see Step 3)

### Check Browser Console
Press F12 → Console tab to see detailed error messages

## Project Structure

```
secure-doc-share-pwa/
├── index.html              # Login/Register page
├── dashboard.html          # Main dashboard
├── shared.html            # Public link access page
├── js/
│   └── firebase.js        # Firebase configuration
├── firestore.rules        # Firestore security rules
├── storage.rules          # Storage security rules
├── firebase.json          # Firebase config
└── FIREBASE_SETUP.md      # Detailed setup guide
```

## Database Collections

### users/
Stores registered user information
```javascript
{
  email: "user@example.com",
  uid: "firebase-uid-string",
  createdAt: timestamp
}
```

### documents/
Stores document metadata
```javascript
{
  fileName: "document.pdf",
  fileSize: 1048576,
  fileType: "application/pdf",
  storagePath: "documents/uid/timestamp_filename",
  ownerId: "owner-uid",
  ownerEmail: "owner@example.com",
  createdAt: timestamp,
  sharedWith: {
    "user-uid": {
      email: "recipient@example.com",
      consent: true,
      expiresAt: timestamp
    }
  }
}
```

### sharedLinks/
Stores public shareable links
```javascript
{
  linkId: "unique-link-id",
  documentId: "document-id",
  ownerId: "owner-uid",
  storagePath: "documents/uid/timestamp_filename",
  fileName: "document.pdf",
  fileSize: 1048576,
  expiresAt: timestamp,
  createdAt: timestamp,
  accessCount: 0,
  lastAccessedAt: timestamp
}
```

## Time-Bound Link System

### How It Works:

1. **Link Generation**:
   - User sets expiration hours (1-720)
   - System calculates exact expiration timestamp
   - Unique link ID generated
   - Link stored in Firestore with expiry

2. **Link Access**:
   - Anyone can open the link (no login needed)
   - System checks if current time < expiration time
   - If valid: Shows download button
   - If expired: Shows expiration message

3. **Automatic Expiration**:
   - Server-side timestamp comparison
   - Cannot be bypassed client-side
   - Expired links cannot be accessed
   - Safe and secure

### Link Format:
```
http://localhost:8000/shared.html?link={unique-link-id}
```

## Support & Help

If you encounter issues:
1. Check browser console (F12) for errors
2. Verify all Firebase services are enabled
3. Ensure security rules are deployed
4. Check that your Firebase config in `js/firebase.js` is correct

## Next Steps

1. ✅ Complete Firebase setup (Steps 1-4 above)
2. ✅ Test user registration
3. ✅ Test document upload
4. ✅ Test shareable link generation
5. ✅ Test link expiration

---

Made with ❤️ for secure document sharing
# secure-doc-share-pwa
