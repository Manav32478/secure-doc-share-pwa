# 🔐 SecureVault - Secure Document Management PWA
## Complete Project Description & Functionality Guide

---

## 📋 PROJECT OVERVIEW

**SecureVault** is a Progressive Web Application (PWA) that provides a secure, user-friendly document management and file sharing platform. It enables users to upload, store, view, download, and securely share documents through time-limited shareable links.

### Key Characteristics:
- **Type**: Progressive Web Application (PWA)
- **Backend**: Supabase (Authentication, Database, Storage)
- **Frontend**: Vanilla HTML5, CSS3, JavaScript ES6
- **Mobile Support**: Fully responsive design + Native Android wrapper
- **Authentication**: Email/Password with Supabase Auth
- **Security**: Row-Level Security (RLS) policies + Secure share tokens

---

## 🎯 CORE FEATURES & FUNCTIONALITY

### 1. **USER AUTHENTICATION**

#### Login System (`login.html`)
- **Email/Password Authentication** using Supabase Auth
- Form validation for email format and password requirements
- Remember user sessions with localStorage
- Redirect logged-in users directly to dashboard
- Error handling with user-friendly notifications
- Professional light theme UI with minimal color palette

#### Registration
- New user account creation with email and password
- Automatic validation before submission
- Session persistence for seamless experience
- Secure password handling through Supabase

### 2. **DOCUMENT UPLOAD FUNCTIONALITY**

#### Multi-File Upload (`dashboard.html`)
**Features:**
- **Drag-and-Drop Support**: Users can drag files directly onto the upload area
- **Click to Browse**: Traditional file picker for users who prefer selecting files
- **Multiple File Selection**: Upload multiple documents in a single batch
- **File Preview Before Upload**: Display selected files with size information
- **Progress Tracking**: Visual progress bar showing upload status
- **Real-time Feedback**: Notifications for success/errors during upload

#### Upload Path Structure
```
Storage Path: userId/{filename}
```
This structure ensures:
- Files are organized by user (RLS compliance)
- Direct user identification for access control
- No path conflicts between users

#### Supported File Types
- Documents: PDF, DOC, DOCX, TXT, XLS, XLSX, PPT, PPTX
- Images: JPG, JPEG, PNG, GIF, BMP, WebP
- Archives: ZIP, RAR (downloadable)
- Videos: MP4, WebM, OGG (previewable)
- Audio: MP3, WAV, OGG (previewable)

#### Upload Validation
- File size limits enforced by Supabase RLS (50MB max)
- Filename sanitization for security
- Duplicate filename handling with timestamps
- Automatic MIME type detection

---

### 3. **DOCUMENT MANAGEMENT**

#### Dashboard (`dashboard.html`)
**Display Features:**
- **Document Grid Layout**: Beautiful card-based grid responsive to screen size
- **Document Information**: 
  - File name with truncation for long names
  - File size in human-readable format (KB, MB, GB)
  - Upload date and time
  - File type indicator with color-coded icons
- **Search & Filter** (Data structure ready):
  - Filter documents by name or date
  - Sort by upload date, file name, or size

#### Document Actions

##### 🔍 **View Document**
- **PDF Viewer**: Full PDF rendering with zoom, pan, and page navigation
- **Image Preview**: Inline display of images with scaling
- **Text Files**: Raw text display with proper formatting
- **Media Player**: HTML5 player for audio/video files
- **Spreadsheet Preview**: Display Excel files in table format
- **Fallback Download**: Unsupported formats offer direct download option

Features of Document Viewer:
- Full-screen modal display with close button
- Keyboard shortcuts support (Escape key)
- Loading state indicators
- Error handling for corrupted files

##### ⬇️ **Download Document**
- Direct download to user's device
- Keeps original filename and extension
- File integrity verification
- Download progress tracking
- Fallback for large files

##### 🔗 **Share Document**
**Secure Sharing System:**
- Generate time-limited shareable links
- Link expiration options:
  - 1 Hour (temporary sharing)
  - 24 Hours (daily access)
  - 7 Days (weekly access)
  - 30 Days (monthly access)
- Copy-to-clipboard functionality
- Share token generation using random strings
- Public access through shareable links

**Shared Link Features:**
- `/shared.html?shareToken={token}` URL structure
- Token validation before file access
- Expiry time checking on download
- Anonymous user access (no account required)
- View and download capabilities

##### 🗑️ **Delete Document**
- Permanent removal from storage
- Confirmation dialog to prevent accidental deletion
- Immediate update of document list
- Success notification
- Automatic cleanup of associated share tokens

---

### 4. **SECURE FILE SHARING**

#### Share Link Generation Modal (`dashboard.html`)
- User-friendly modal interface for creating shares
- Customizable expiration times
- One-click copy to clipboard
- Display of active share tokens
- Delete existing share tokens

#### Public Sharing Page (`shared.html`)
**Features:**
- Access shared documents without authentication
- View document preview (PDF, images, text, media)
- Download shared files
- Expiry date display with countdown
- Responsive design for all devices
- Security verification of share token

**Security Implementation:**
- Unique token generation for each share
- Server-side token validation
- Time-based expiration enforcement
- RLS policies prevent unauthorized access
- Anonymous access logging (optional enhancement)

---

### 5. **USER INTERFACE & DESIGN**

#### Color Scheme (Professional Minimal Light Theme)
```css
--bg: #f8fafc              (Background: Light Slate)
--panel: #ffffff            (Panels: Pure White)
--text: #0f172a             (Text: Dark Navy)
--muted: #64748b            (Muted: Slate Gray)
--border: #dbe2ea           (Borders: Light Slate)
--primary: #1d4ed8          (Primary: Blue)
--danger: #dc2626           (Danger: Red)
```

#### UI Components

##### Navbar
- **Fixed Navigation**: Stays visible while scrolling
- **Brand Name**: "SecureVault" with tagline
- **User Info**: Display logged-in user's email
- **User Avatar**: First letter of email, gradient background
- **Logout Button**: Secure session termination

##### Buttons & Interactive Elements
- **Primary Button**: Blue gradient for main actions
- **Danger Button**: Red gradient for destructive actions
- **Secondary Button**: White/gray for alternative actions
- **Icon Buttons**: Paired with text labels
- **Hover States**: Scale animations and shadow effects
- **Active States**: Pressed appearance feedback

##### Cards & Containers
- **Document Cards**: 
  - Hoverable with elevation effect
  - Icon, title, metadata, and actions
  - Animated border accent on hover
  - Touch-friendly spacing on mobile
- **Sections**: White panels with subtle shadows
- **Modals**: Centered overlays with backdrop blur

#### Animations & Transitions
- **Fade In**: Content elements appear smoothly (0.4-0.6s)
- **Slide Animations**: Navbar elements enter from sides
- **Hover Effects**: Smooth scaling and shadow transitions
- **Progress Bar**: Animated shimmer effect
- **Notification Slide**: Toast messages slide in from right

#### Typography
- **Font Family**: System fonts (San Francisco, Segoe UI, etc.)
- **Font Smoothing**: Antialiased for crisp text
- **Heading Sizes**: 32px (main), 18px (modal), 16px (cards)
- **Letter Spacing**: Negative for compact, professional look

---

### 6. **RESPONSIVE DESIGN**

#### Desktop (1200px+)
- Full 3-column document grid
- Wide upload section
- Full navigation bar
- Side-by-side modals and content

#### Tablet (768px - 1199px)
- 2-column document grid
- Adjusted padding and spacing
- Optimized button sizes
- Full functionality

#### Mobile (320px - 767px)
- Single-column document grid
- Full-width buttons and inputs
- Touch-friendly spacing (minimum 44px tap targets)
- Optimized font sizes
- Stacked layout for modals
- Reduced padding for screen space

#### Mobile-Specific Optimizations
- Full-width file upload area
- Large touch buttons (14px+ padding)
- Optimized form inputs with larger text
- Simplified navigation
- Bottom-aligned notifications
- Responsive modals that scale to fit screen

---

## 🛠️ TECHNICAL IMPLEMENTATION

### Backend: Supabase Configuration

#### Authentication (`supabase.js`)
```javascript
// Client initialization
import { createClient } from '@supabase/supabase-js@2.39.0'
const supabase = createClient(SUPABASE_URL, SUPABASE_KEY)
```
- Email/password authentication
- Session management with localStorage
- User context tracking
- Real-time user state updates

#### Database Schema

**users table**
```sql
- email (primary key)
- user_id (unique identifier)
- created_at (timestamp)
- updated_at (timestamp)
```

**documents table**
```sql
- id (unique identifier)
- user_id (foreign key to users)
- filename (document name)
- storage_path (path to file in storage)
- file_size (in bytes)
- file_type (MIME type)
- created_at (upload timestamp)
- updated_at (modification timestamp)
```

**shared_links table**
```sql
- id (unique token)
- document_id (document reference)
- expires_at (expiration timestamp)
- created_at (creation timestamp)
- created_by (user who created share)
```

#### Storage Structure
```
Bucket: documents
Path: {userId}/{filename}
```

#### Row-Level Security (RLS) Policies
```sql
-- Documents RLS
- Users can only view/edit their own documents
- INSERT: Requires user authentication
- SELECT: Only owner can view
- UPDATE: Only owner can modify
- DELETE: Only owner can remove

-- Shared Links RLS
- Anyone can view share links
- Only document owner can create/delete shares
```

---

## 📱 MOBILE APP INTEGRATION

### Android APK Wrapper
The application is packaged as an Android application for mobile distribution:

**Structure:**
```
/android/
├── app/
│   ├── src/main/
│   │   ├── java/com/securevault/app/MainActivity.kt
│   │   ├── assets/                      (Bundled web app)
│   │   │   ├── index.html
│   │   │   ├── dashboard.html
│   │   │   ├── shared.html
│   │   │   ├── login.html
│   │   │   ├── css/
│   │   │   └── js/
│   │   ├── AndroidManifest.xml
│   │   └── res/
├── build.gradle
└── gradle/wrapper/
```

**Features:**
- Native Android wrapper using WebView
- Bundled web app files (no network required for UI)
- Supabase backend communication
- Full file access permissions
- Camera and storage permissions
- Hardware acceleration enabled

**Gradle Configuration:**
```gradle
- Android Gradle Plugin: 8.7.0
- Kotlin: 1.9.24
- Min SDK: 24
- Target SDK: 34
- Java: 11
```

---

## ⚙️ KEY FUNCTIONALITY DETAILS

### Upload Process Flow
1. User selects files (drag-drop or click)
2. Files validated (size, type)
3. UI shows selected files with sizes
4. User clicks "Upload All"
5. Progress bar shows upload status
6. Files sent to Supabase in chunks
7. Success notification + document list refreshed
8. Files appear in dashboard grid

### Download Process Flow
1. User clicks download on document card
2. File retrieved from storage path
3. Browser triggers download with original filename
4. Success notification shown
5. User receives file

### Share Process Flow
1. User clicks share on document
2. Share modal opens with expiry options
3. User selects expiration time
4. System generates unique token
5. Link created in database with expiry
6. Share link displayed to user
7. User copies link to clipboard
8. Recipient receives link via external method
9. Recipient visits `/shared.html?shareToken={token}`
10. System validates token and expiry
11. Recipient can view/download without account

### Delete Process Flow
1. User clicks delete on document
2. Confirmation dialog appears
3. On confirm: File removed from storage
4. Document entry removed from database
5. Associated share links deleted
6. Document list refreshed
7. Success notification shown

---

## 🔒 SECURITY FEATURES

### Authentication Security
- Password-based with Supabase Auth (industry standard)
- Session tokens stored in localStorage
- Automatic logout on tab close (optional)
- HTTPS-only communication (production)

### Data Security
- Row-Level Security on all database tables
- Users cannot access others' documents
- Storage paths tied to user IDs
- Share tokens are one-time use (validated per request)

### File Security
- File type validation
- File size limits (50MB max)
- Filename sanitization
- Original file permissions preserved

### URL Security
- Share tokens are cryptographically random
- Share links expire after set time
- No account enumeration possible
- CORS properly configured

---

## 📊 USER WORKFLOWS

### New User Workflow
1. Visit `/index.html` (login page)
2. Click "Create Account"
3. Enter email and password
4. Account created in Supabase
5. Automatically logged in
6. Redirected to dashboard
7. Empty state shown
8. Ready to upload documents

### Existing User Workflow
1. Visit `/index.html`
2. Login credentials remembered (if browser allows)
3. Automatically logged in
4. Redirected to dashboard
5. Previous documents displayed
6. Can upload, view, share, or delete

### File Sharing Workflow (Recipient)
1. Receive share link via email/message
2. Click link (visits `/shared.html?shareToken={token}`)
3. File preview displayed
4. Can view in browser
5. Can download file
6. No account required

---

## 🎨 DESIGN SYSTEM

### Spacing Scale
```
4px, 8px, 12px, 16px, 20px, 24px, 32px, 40px, 48px
```

### Border Radius
```
4px (small elements)
8px (buttons, inputs)
10px (cards, containers)
12px (sections, modals)
16px (larger sections)
50% (avatars, circles)
```

### Shadow System
```
Subtle: 0 2px 8px rgba(0,0,0,0.05)
Medium: 0 4px 12px rgba(0,0,0,0.1)
Large: 0 8px 24px rgba(0,0,0,0.15)
Hover: 0 12px 32px rgba(0,0,0,0.2)
```

### Typography Scale
```
H1: 32px, 800 weight, -0.7px letter-spacing
H2: 18px, 600 weight
Body: 14px, 400 weight
Small: 12px, 500 weight
```

---

## 📋 FILE STRUCTURE

```
secure-doc-share-pwa/
├── index.html                    # Login page
├── dashboard.html                # Main application
├── shared.html                   # Public share viewer
├── login.html                    # Authentication
├── login-firebase.html           # Firebase alternative (legacy)
├── dashboard_firebase.html       # Firebase version (legacy)
├── css/
│   └── styles.css               # Shared styles (if needed)
├── js/
│   ├── supabase.js              # Supabase client config
│   └── firebase.js              # Firebase config (legacy)
├── android/                      # Android PWA wrapper
│   ├── app/
│   │   ├── src/main/
│   │   │   ├── java/com/securevault/app/MainActivity.kt
│   │   │   ├── assets/          # Bundled web app
│   │   │   ├── AndroidManifest.xml
│   │   │   └── res/
│   │   └── build.gradle
│   ├── build.gradle
│   └── gradle/
├── README.md                     # Setup documentation
├── SUPABASE_SETUP.md            # Supabase configuration guide
└── PROJECT_DESCRIPTION.md        # This file
```

---

## 🚀 DEPLOYMENT OPTIONS

### 1. **Web (PWA)**
- Deploy to Netlify/Vercel/Firebase Hosting
- Install as app on mobile (add to home screen)
- Works offline with service worker

### 2. **Android App**
- Build APK with: `./gradlew build`
- Release APK: `./gradlew build --release`
- Generate signing key for Play Store
- Upload to Google Play Store

### 3. **Progressive Web App**
- Service worker caching
- Manifest.json for icon/name
- Installable on any platform

---

## ✨ PERFORMANCE OPTIMIZATIONS

### Frontend
- Lazy loading of document previews
- CSS animations using GPU-accelerated transforms
- Event delegation for document actions
- Efficient DOM updates

### Backend
- Indexed queries on user_id and created_at
- Connection pooling with Supabase
- Strategic use of caching
- Optimized RLS policies

### Storage
- Chunked file uploads for large files
- Automatic cleanup of orphaned files
- Efficient storage path structure

---

## 🔄 FUTURE ENHANCEMENT POSSIBILITIES

1. **Advanced Features**
   - Document versioning history
   - Collaborative editing
   - Comments and annotations
   - File encryption at rest

2. **Search & Discovery**
   - Full-text search with Postgres FTS
   - Tags and categories
   - Advanced filtering
   - Recent documents widget

3. **Sharing Enhancements**
   - Password-protected links
   - Download count limits
   - Recipient notifications
   - Share with specific users

4. **Analytics**
   - Document access analytics
   - Share link usage tracking
   - Storage utilization dashboard
   - User activity logs

5. **Integrations**
   - Google Drive sync
   - Dropbox integration
   - Microsoft OneDrive
   - Email notifications

---

## 📞 SUPPORT & MAINTENANCE

### Common Issues & Solutions
- **Upload fails**: Check file size (max 50MB) and file type
- **Share link expired**: Generate new link with appropriate expiry
- **Can't view PDF**: Ensure PDF is valid and not corrupted
- **Slow uploads**: Check internet connection speed

### Monitoring
- Supabase logs for errors
- Browser console for client-side issues
- Storage usage tracking
- User session monitoring

---

## 🎓 LEARNING RESOURCES

### Technologies Used
- **Supabase**: https://supabase.io/docs
- **PWA**: https://web.dev/progressive-web-apps/
- **Vanilla JavaScript**: https://developer.mozilla.org/en-US/docs/Web/JavaScript/
- **CSS Modern Layouts**: https://web.dev/responsive-web-design-basics/

---

**Version**: 1.0.0  
**Last Updated**: April 2026  
**Status**: Production Ready  
**License**: MIT (if applicable)

