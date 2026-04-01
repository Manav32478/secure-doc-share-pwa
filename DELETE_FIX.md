# 🔧 IMMEDIATE FIX: Delete Document Problem

## The Problem
RLS (Row Level Security) policies in Supabase are blocking delete operations.

## ⚡ QUICK FIX (2 minutes)

### Step 1: Go to Supabase Console
1. Open: https://supabase.com/dashboard
2. Select your project: **doc-share-55636**
3. Click **SQL Editor** (left sidebar)

### Step 2: Disable RLS (Temporary Fix for Testing)
Copy & paste this in the SQL Editor, then click **Run**:

```sql
ALTER TABLE documents DISABLE ROW LEVEL SECURITY;
ALTER TABLE shared_links DISABLE ROW LEVEL SECURITY;
```

✅ **Click Run** - wait for success message

### Step 3: Test Delete
Go back to your app and try deleting a document now. It should work!

---

## 🔐 PROPER FIX (Better Security - Do This Next)

If you want to KEEP RLS enabled but fix the policy, run this instead:

```sql
-- First, ENABLE RLS if disabled
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;

-- Drop old policies (if any exist)
DROP POLICY IF EXISTS "Users can read own documents" ON documents;
DROP POLICY IF EXISTS "Users can create documents" ON documents;
DROP POLICY IF EXISTS "Users can delete own documents" ON documents;
DROP POLICY IF EXISTS "Users can update own documents" ON documents;

-- CREATE PROPER RLS POLICIES
-- Allow users to READ their own documents
CREATE POLICY "Users can read own documents"
ON documents FOR SELECT
USING (auth.uid() = owner_id);

-- Allow users to INSERT documents
CREATE POLICY "Users can create documents"
ON documents FOR INSERT
WITH CHECK (auth.uid() = owner_id);

-- Allow users to DELETE their own documents
CREATE POLICY "Users can delete own documents"
ON documents FOR DELETE
USING (auth.uid() = owner_id);

-- Allow users to UPDATE their own documents
CREATE POLICY "Users can update own documents"
ON documents FOR UPDATE
USING (auth.uid() = owner_id)
WITH CHECK (auth.uid() = owner_id);
```

---

## ✅ VERIFY THE FIX
1. Visit your app: http://localhost:8000/dashboard.html
2. Try deleting a test document
3. Should delete instantly ✓
4. Check browser console (F12) for logs

---

## 🆘 If It STILL Doesn't Work

1. **Check auth.uid() issue:**
   - The RLS policy checks if `auth.uid() = owner_id`
   - You must login with **same email** used to upload the document
   - Or check that your `owner_id` column in database actually contains a UID (not email)

2. **Check owner_id column:**
   - Go to Supabase → Documents Table
   - Make sure `owner_id` contains actual USER IDs (UUIDs), not emails
   - If it contains emails, the policy won't work!

3. **Contact Support:** 
   - Email: your-support@example.com
   - Include the document IDs you're trying to delete

---

## 📝 Which Option to Choose?

| Option | Speed | Security | Complexity |
|--------|-------|----------|-----------|
| **Disable RLS** | Instant ✅ | Low ⚠️ | Easy (1 command) |
| **Fix RLS Policy** | Same | High ✅ | Medium (10 lines SQL) |

**Recommended:** Do the **Proper Fix** to keep your data secure.

---

**Already tested?** Let me know if it works! 🚀
