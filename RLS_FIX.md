# DELETE ISSUE FIX - RLS Policy

The delete is not working because the RLS policy for DELETE on the `documents` table is missing or incorrect.

## FIX: Add DELETE RLS Policy

1. **Go to Supabase Dashboard** → https://app.supabase.com
2. **Select your project** → `secure-doc-share`
3. **Navigate to:** SQL Editor
4. **Run this SQL command:**

```sql
-- Add DELETE policy for documents table
CREATE POLICY "Users can delete their own documents"
ON documents
FOR DELETE
USING (auth.uid() = owner_id);
```

That's it! This policy allows users to delete only documents they own (where owner_id matches their user ID).

## If you already have a policy, check it:

1. Go to **Authentication** → **Policies** in Supabase
2. Select **documents** table
3. Look for DELETE policies
4. If none exists, click **+ New Policy** → **For Deletes** → Paste the SQL above

## After Adding Policy:

1. Refresh the browser
2. Try deleting a document again
3. It should work now!

## Verify in Console:

Open Browser Console (F12) and look for:
- ✅ `"Database delete response: { error: null, data: null, count: 1 }"`
- If you see `count: 1`, the delete worked!
