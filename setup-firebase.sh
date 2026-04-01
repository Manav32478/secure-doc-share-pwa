#!/bin/bash

# Secure Doc Share - Firebase Setup Script
echo "🔐 Secure Doc Share - Firebase Configuration"
echo "=============================================="
echo ""

# Check if Firebase CLI is installed
if ! command -v firebase &> /dev/null; then
    echo "❌ Firebase CLI not found"
    echo "Installing Firebase CLI..."
    npm install -g firebase-tools
    echo "✓ Firebase CLI installed"
fi

# Login to Firebase
echo ""
echo "Step 1: Login to Firebase"
firebase login

# Initialize Firebase (if not already done)
if [ ! -f ".firebaserc" ]; then
    echo ""
    echo "Step 2: Initialize Firebase Project"
    firebase init firestore storage --project doc-share-55636
fi

# Deploy Firestore rules
echo ""
echo "Step 3: Deploying Firestore Security Rules..."
firebase deploy --only firestore:rules --project doc-share-55636

# Deploy Storage rules
echo ""
echo "Step 4: Deploying Storage Security Rules..."
firebase deploy --only storage:rules --project doc-share-55636

echo ""
echo "=============================================="
echo "✅ Firebase Configuration Complete!"
echo ""
echo "Next Steps:"
echo "1. Go to https://console.firebase.google.com"
echo "2. Select project: doc-share-55636"
echo "3. Enable Authentication > Email/Password"
echo "4. Create Firestore Database (if not created)"
echo "5. Enable Storage (if not enabled)"
echo ""
echo "Then test your app at: http://localhost:8000"
echo "=============================================="
