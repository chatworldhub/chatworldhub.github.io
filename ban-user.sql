-- ChatWorld: permanently ban a user by username.
-- Change USERNAME_HERE, then run this in Supabase SQL Editor.
-- This preserves the profile and messages. It blocks future sign-ins and
-- removes existing refreshable sessions for the matched account.

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
    RAISE EXCEPTION 'No ChatWorld user found with username: %', target_username;
  ELSIF matched_count > 1 THEN
    RAISE EXCEPTION 'More than one profile matched username: %. No changes made.', target_username;
  END IF;

  SELECT id
    INTO matched_user_id
    FROM public.profiles
   WHERE lower(username) = lower(trim(target_username))
   LIMIT 1;

  -- Supabase Auth checks banned_until when issuing new sessions.
  UPDATE auth.users
     SET banned_until = 'infinity'::timestamptz,
         updated_at = now()
   WHERE id = matched_user_id;

  -- Revoke currently stored sessions/refresh tokens for this account.
  DELETE FROM auth.sessions
   WHERE user_id = matched_user_id;

  RAISE NOTICE 'User "%" has been banned. Their profile and messages were kept.', target_username;
END
$$;
