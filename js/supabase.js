import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2.39.0/+esm';

const SUPABASE_URL = 'https://zlqcnihgwmybltesajuq.supabase.co';
const SUPABASE_KEY = 'sb_publishable_Gq1cYqjI3fJgcpSLksmaEA_ATr8iznT';

export const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

export { SUPABASE_URL, SUPABASE_KEY };
