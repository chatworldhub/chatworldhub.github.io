-- ChatWorld: restore a previously banned user by username.
-- Change USERNAME_HERE, then run this in Supabase SQL Editor.
-- This removes the Auth ban. The user keeps the same account and username.

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

  UPDATE auth.users
     SET banned_until = NULL,
         updated_at = now()
   WHERE id = matched_user_id;

  RAISE NOTICE 'User "%" has been restored. They can log in with their original username and password.', target_username;
END
$$;
