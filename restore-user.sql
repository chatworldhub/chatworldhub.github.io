-- CHATWORLD: RESTORE A USER USING SUPABASE ONLY
-- 1) Replace USERNAME_HERE below with the exact username.
-- 2) Run this entire script in Supabase > SQL Editor.
-- No website/index.html update is required.
--
-- The user's original profile, username, and messages are preserved.

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS is_banned boolean NOT NULL DEFAULT false;

-- Keep the same filtering policy in place for any other banned accounts.
DROP POLICY IF EXISTS chatworld_hide_banned_profiles ON public.profiles;
CREATE POLICY chatworld_hide_banned_profiles
  ON public.profiles
  AS RESTRICTIVE
  FOR SELECT
  TO authenticated
  USING (is_banned = false OR id = (SELECT auth.uid()));

DO $$
DECLARE
  target_username text := 'USERNAME_HERE';
  matched_user_id uuid;
  matched_count integer;
BEGIN
  SELECT count(*)
    INTO matched_count
    FROM public.profiles
   WHERE lower(username) = lower(trim(target_username));

  IF matched_count = 0 THEN
    RAISE EXCEPTION 'No profile found for username: %', target_username;
  ELSIF matched_count > 1 THEN
    RAISE EXCEPTION 'More than one profile matches %. No changes made.', target_username;
  END IF;

  SELECT id
    INTO matched_user_id
    FROM public.profiles
   WHERE lower(username) = lower(trim(target_username))
   LIMIT 1;

  UPDATE public.profiles
     SET is_banned = false
   WHERE id = matched_user_id;

  UPDATE auth.users
     SET banned_until = NULL,
         updated_at = now()
   WHERE id = matched_user_id;

  RAISE NOTICE 'Restored username: %', target_username;
END
$$;

