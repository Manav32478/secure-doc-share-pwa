# Firebase Setup Instructions

## Prerequisites
- Node.js installed
- Firebase CLI installed: `npm install -g firebase-tools`
- Firebase account created at https://firebase.google.com

## Step 1: Login to Firebase
```bash
firebase login
```

## Step 2: Initialize Firebase Project
```bash
cd /Users/manavsarvaiya/Desktop/secure-doc-share-pwa
firebase init
```

Select:
- ✅ Firestore
- ✅ Storage
- ✅ Hosting (optional)

When prompted:
1. Use existing project: **doc-share-55636**
2. Firestore rules file: **firestore.rules**
3. Firestore indexes file: **firestore.indexes.json**
4. Storage rules file: **storage.rules**

## Step 3: Deploy Security Rules
```bash
firebase deploy --only firestore:rules
firebase deploy --only storage:rules
```

## Step 4: Enable Authentication
1. Go to Firebase Console: https://console.firebase.google.com
2. Select your project: **doc-share-55636**
3. Go to **Authentication** → **Sign-in method**
4. Enable **Email/Password** authentication

## Step 5: Configure Firestore Database
1. Go to **Firestore Database**
2. Click **Create database**
3. Select **Production mode** (rules are already configured)
4. Choose your preferred location (e.g., us-central1)

## Step 6: Configure Storage
1. Go to **Storage**
2. Click **Get started**
3. Select **Production mode**
4. Choose same location as Firestore

## Firestore Collections Structure

### users/
```
users/{email} = {
  uid: string,
  email: string,
  createdAt: timestamp
}
```

### documents/
```
documents/{docId} = {
  fileName: string,
  fileSize: number,
  fileType: string,
  storagePath: string,
  ownerId: string,
  ownerEmail: string,
  createdAt: timestamp,
  sharedWith: {
    [userId]: {
      email: string,
      consent: boolean,
      expiresAt: timestamp
    }
  }
}
```

### sharedLinks/
```
sharedLinks/{linkId} = {
  documentId: string,
  ownerId: string,
  storagePath: string,
  fileName: string,
  expiresAt: timestamp,
  createdAt: timestamp,
  accessCount: number
}
```

## Storage Structure
```
documents/
  {userId}/
    {timestamp}_{fileName}
```

## Testing Security Rules Locally
```bash
firebase emulators:start --only firestore,storage
```

## Verify Deployment
```bash
firebase deploy --only firestore:rules,storage:rules
```

## Important Notes
- Links expire automatically based on the `expiresAt` timestamp
- Users must be registered to share documents
- File size limit: 50MB
- All security rules are enforced server-side

## Troubleshooting
If you get permission errors:
1. Check that your Firebase config in `js/firebase.js` is correct
2. Verify security rules are deployed
3. Ensure authentication is enabled
4. Check browser console for specific errors
