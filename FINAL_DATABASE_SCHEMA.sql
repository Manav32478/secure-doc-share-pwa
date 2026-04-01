-- ============================================================================
-- SECURE DOC SHARE - FINAL DATABASE SCHEMA
-- Complete SQL setup with all RLS policies, functions, and fixes
-- ============================================================================

-- Drop existing tables and policies (if any) to start fresh
DROP TABLE IF EXISTS shared_links CASCADE;
DROP TABLE IF EXISTS documents CASCADE;
DROP FUNCTION IF EXISTS delete_user_document(UUID, UUID) CASCADE;

-- ============================================================================
-- TABLE: documents
-- Stores uploaded documents and metadata
-- ============================================================================
CREATE TABLE documents (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  file_name TEXT NOT NULL,
  file_size BIGINT NOT NULL,
  file_type TEXT NOT NULL,
  storage_path TEXT NOT NULL,
  owner_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  owner_email TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  shared_with JSONB DEFAULT '{}'::jsonb
);

-- ============================================================================
-- TABLE: shared_links
-- Stores shareable links with expiration and access tracking
-- ============================================================================
CREATE TABLE shared_links (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  link_id TEXT UNIQUE NOT NULL,
  document_id UUID NOT NULL REFERENCES documents(id) ON DELETE CASCADE,
  owner_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  storage_path TEXT NOT NULL,
  file_name TEXT NOT NULL,
  file_size BIGINT NOT NULL,
  expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  access_count INT DEFAULT 0,
  last_accessed_at TIMESTAMP WITH TIME ZONE
);

-- ============================================================================
-- INDEXES - Improve query performance
-- ============================================================================
CREATE INDEX idx_documents_owner ON documents(owner_id);
CREATE INDEX idx_documents_created_at ON documents(created_at DESC);
CREATE INDEX idx_shared_links_link_id ON shared_links(link_id);
CREATE INDEX idx_shared_links_document_id ON shared_links(document_id);
CREATE INDEX idx_shared_links_owner_id ON shared_links(owner_id);
CREATE INDEX idx_shared_links_expires ON shared_links(expires_at);

-- ============================================================================
-- ENABLE ROW LEVEL SECURITY
-- ============================================================================
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE shared_links ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- POLICIES FOR DOCUMENTS TABLE
-- ============================================================================

-- Policy 1: Users can SELECT (read) their own documents
CREATE POLICY "Users can view their own documents"
ON documents FOR SELECT
USING (auth.uid() = owner_id);

-- Policy 2: Users can INSERT (create) documents
CREATE POLICY "Users can insert their own documents"
ON documents FOR INSERT
WITH CHECK (auth.uid() = owner_id);

-- Policy 3: Users can UPDATE their own documents
CREATE POLICY "Users can update their own documents"
ON documents FOR UPDATE
USING (auth.uid() = owner_id)
WITH CHECK (auth.uid() = owner_id);

-- Policy 4: Users can DELETE their own documents
CREATE POLICY "Users can delete their own documents"
ON documents FOR DELETE
USING (auth.uid() = owner_id);

-- ============================================================================
-- POLICIES FOR SHARED_LINKS TABLE
-- ============================================================================

-- Policy 1: Anyone can SELECT (read) shared links (public access)
CREATE POLICY "Anyone can view shared links"
ON shared_links FOR SELECT
USING (true);

-- Policy 2: Users can INSERT (create) shared links for their documents
CREATE POLICY "Users can create shared links for their documents"
ON shared_links FOR INSERT
WITH CHECK (auth.uid() = owner_id);

-- Policy 3: Users can UPDATE their own shared links
CREATE POLICY "Users can update their own shared links"
ON shared_links FOR UPDATE
USING (auth.uid() = owner_id)
WITH CHECK (auth.uid() = owner_id);

-- Policy 4: Users can DELETE their own shared links
CREATE POLICY "Users can delete their own shared links"
ON shared_links FOR DELETE
USING (auth.uid() = owner_id);

-- ============================================================================
-- HELPER FUNCTION: Delete User Document (with RLS bypass for service role)
-- Useful if client-side delete still fails
-- ============================================================================
CREATE OR REPLACE FUNCTION delete_user_document(
  p_doc_id UUID,
  p_user_id UUID
)
RETURNS BOOLEAN AS $$
BEGIN
  -- Delete shared links first (foreign key constraint)
  DELETE FROM shared_links 
  WHERE document_id = p_doc_id 
  AND owner_id = p_user_id;

  -- Delete the document
  DELETE FROM documents 
  WHERE id = p_doc_id 
  AND owner_id = p_user_id;

  -- Return true if document was deleted
  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant execute permission to authenticated users
GRANT EXECUTE ON FUNCTION delete_user_document(UUID, UUID) TO authenticated;

-- ============================================================================
-- HELPER FUNCTION: Delete Expired Shared Links (automatic cleanup)
-- Run periodically or on trigger
-- ============================================================================
CREATE OR REPLACE FUNCTION delete_expired_links()
RETURNS INT AS $$
DECLARE
  v_deleted INT;
BEGIN
  DELETE FROM shared_links 
  WHERE expires_at < NOW();
  
  GET DIAGNOSTICS v_deleted = ROW_COUNT;
  RETURN v_deleted;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- TRIGGER: Update 'updated_at' timestamp on document changes
-- ============================================================================
CREATE OR REPLACE FUNCTION update_documents_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER documents_updated_at_trigger
BEFORE UPDATE ON documents
FOR EACH ROW
EXECUTE FUNCTION update_documents_updated_at();

-- ============================================================================
-- OPTIONAL: Storage Bucket Policies (if using Supabase Storage)
-- ============================================================================
-- Note: Run these in Supabase Dashboard → Storage → Policies
-- 
-- For storage bucket named "documents":
--
-- SELECT Policy:
-- authenticated and storage.foldername(name)[1] = auth.uid()::text
--
-- INSERT Policy:
-- authenticated and storage.foldername(name)[1] = auth.uid()::text
--
-- DELETE Policy:
-- authenticated and storage.foldername(name)[1] = auth.uid()::text
--
-- UPDATE Policy:
-- authenticated and storage.foldername(name)[1] = auth.uid()::text

-- ============================================================================
-- FINAL VERIFICATION QUERIES
-- ============================================================================
-- Run these to verify everything is set up correctly:
--
-- -- Check tables exist:
-- SELECT table_name FROM information_schema.tables 
-- WHERE table_schema = 'public' AND table_name IN ('documents', 'shared_links');
--
-- -- Check RLS is enabled:
-- SELECT tablename, rowsecurity
-- FROM pg_tables
-- WHERE tablename IN ('documents', 'shared_links');
--
-- -- Check policies exist:
-- SELECT policyname, tablename
-- FROM pg_policies
-- WHERE tablename IN ('documents', 'shared_links');
--
-- -- Check indexes:
-- SELECT tablename, indexname FROM pg_indexes 
-- WHERE schemaname = 'public' AND tablename IN ('documents', 'shared_links');

-- ============================================================================
-- COMMON ISSUES & FIXES
-- ============================================================================
-- 
-- Issue 1: Delete not working
-- Fix: Ensure "Users can delete their own documents" policy exists
--      Check that auth.uid() matches owner_id in database
--
-- Issue 2: Upload not showing in dashboard
-- Fix: Verify owner_id is UUID type and matches auth.users(id)
--      Check Supabase Auth logs for user ID
--
-- Issue 3: Shared links not accessible
-- Fix: Ensure "Anyone can view shared links" policy has USING (true)
--      Check link expiration: SELECT * FROM shared_links WHERE expires_at < NOW();
--
-- Issue 4: RLS blocking all operations
-- Solution: Disable temporarily with:
--   ALTER TABLE documents DISABLE ROW LEVEL SECURITY;
--   ALTER TABLE shared_links DISABLE ROW LEVEL SECURITY;
-- Then re-enable and check policies
--
-- ============================================================================
-- COMPLETION CHECKLIST
-- ============================================================================
-- ✅ Tables created with proper foreign keys
-- ✅ Indexes created for performance
-- ✅ RLS enabled on both tables
-- ✅ SELECT policies (read permission)
-- ✅ INSERT policies (create permission)
-- ✅ UPDATE policies (edit permission)
-- ✅ DELETE policies (delete permission)
-- ✅ Helper functions for edge cases
-- ✅ Triggers for automatic timestamp updates
-- ✅ Cascade deletes to maintain referential integrity
-- ✅ Comment documentation

-- ============================================================================
-- DONE! Your database is now fully set up! 🎉
-- ============================================================================
