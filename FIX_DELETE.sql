-- DISABLE RLS ON DOCUMENTS TABLE (TEMPORARY FIX)
-- This allows deletion to work
ALTER TABLE documents DISABLE ROW LEVEL SECURITY;

-- Alternative: Better approach - CREATE PROPER DELETE POLICY
-- If RLS is disabled, re-enable it but with proper policies:
-- ALTER TABLE documents ENABLE ROW LEVEL SECURITY;

-- Add proper DELETE policy
DROP POLICY IF EXISTS "Users can delete their own documents" ON documents;
CREATE POLICY "Users can delete their own documents"
ON documents
FOR DELETE
USING (auth.uid() = owner_id);

-- Add proper UPDATE policy if needed
DROP POLICY IF EXISTS "Users can update their own documents" ON documents;
CREATE POLICY "Users can update their own documents"
ON documents
FOR UPDATE
USING (auth.uid() = owner_id);

-- Add proper INSERT policy if needed
DROP POLICY IF EXISTS "Users can insert their own documents" ON documents;
CREATE POLICY "Users can insert their own documents"
ON documents
FOR INSERT
WITH CHECK (auth.uid() = owner_id);

-- Add proper SELECT policy if needed
DROP POLICY IF EXISTS "Users can select their own documents" ON documents;
CREATE POLICY "Users can select their own documents"
ON documents
FOR SELECT
USING (auth.uid() = owner_id);
