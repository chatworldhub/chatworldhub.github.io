-- CHATWORLD: BAN A USER AND HIDE THEIR PROFILE USING SUPABASE ONLY
-- 1) Replace USERNAME_HERE below with the exact username.
-- 2) Run this entire script in Supabase > SQL Editor.
-- No website/index.html update is required.
--
-- This keeps the user's profile, username, and messages. It hides their
-- profile from other authenticated users through a restrictive SELECT policy
-- and bans their Supabase Auth account.

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS is_banned boolean NOT NULL DEFAULT false;

-- Restrictive policies are combined with existing SELECT policies using AND.
-- A banned user's profile remains visible to that user, but not to others.
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
     SET is_banned = true
   WHERE id = matched_user_id;

  UPDATE auth.users
     SET banned_until = 'infinity'::timestamptz,
         updated_at = now()
   WHERE id = matched_user_id;

  RAISE NOTICE 'Banned and hidden profile for username: %', target_username;
END
$$;

-- Note: refresh ChatWorld after running this. Existing access tokens may remain
-- valid until they expire; the profile is filtered from new profile SELECTs.

