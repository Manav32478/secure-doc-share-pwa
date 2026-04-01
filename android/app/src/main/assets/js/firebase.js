// Import Firebase
import { initializeApp } from "https://www.gstatic.com/firebasejs/10.12.2/firebase-app.js";
import { getAuth } from "https://www.gstatic.com/firebasejs/10.12.2/firebase-auth.js";
import { getFirestore } from "https://www.gstatic.com/firebasejs/10.12.2/firebase-firestore.js";
import { getStorage } from "https://www.gstatic.com/firebasejs/10.12.2/firebase-storage.js";

// Firebase config
const firebaseConfig = {
  apiKey: "AIzaSyBpmCrk7KlgyZ6b3LzXU5oTvxZLe-vak3U",
  authDomain: "doc-share-55636.firebaseapp.com",
  projectId: "doc-share-55636",
  storageBucket: "doc-share-55636.firebasestorage.app",
  messagingSenderId: "262446356687",
  appId: "1:262446356687:web:9fef520e72b2947a4d7fba"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Export auth, db, and storage
export const auth = getAuth(app);
export const db = getFirestore(app);
export const storage = getStorage(app);
