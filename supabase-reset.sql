-- =====================================================================
--  ChatWorld - supabase-reset.sql   (DELETE EVERYTHING PEOPLE CREATED)
--
--  !!  THIS PERMANENTLY DELETES ALL ACCOUNTS, PROFILES, GROUPS AND
--  !!  MESSAGES. IT CANNOT BE UNDONE. Your own account is deleted too.
--
--  Run it ONCE in: Supabase -> SQL Editor -> New query -> paste -> Run.
--  Your tables, security rules and settings stay exactly as they are.
-- =====================================================================

do $$
begin
  if to_regclass('public.messages')      is not null then delete from public.messages;      end if;
  if to_regclass('public.group_members') is not null then delete from public.group_members; end if;
  if to_regclass('public.groups')        is not null then delete from public.groups;        end if;
  if to_regclass('public.profiles')      is not null then delete from public.profiles;      end if;
  delete from auth.users;      -- every login account (also clears their sessions)
end $$;

-- Done! You should see "Success. No rows returned".
-- Photos are stored separately: see the README (Part 13) to empty the two photo folders.
