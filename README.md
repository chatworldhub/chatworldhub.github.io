LINK TO THE WEBSITE:

chatworldhub.github.io
---------------------------------------------------------------------
🌍 ChatWorld

A free, real-time chat website: public Global Chat, private one-to-one messages, online indicators, profiles and message history. Built with plain HTML, CSS and JavaScript, powered by Supabase Free, hosted on GitHub Pages Free.

You do not need to know how to program. Follow the steps below in order. Take your time. It usually takes 30–45 minutes the first time.

What's in this project
File	What it does
index.html	The whole website in ONE file (pages, look and code). You edit 2 lines in here.
style.css	Optional. The same styling, already included inside index.html.
script.js	Optional. The same code, already included inside index.html.
supabase.sql	Sets up your database and its security rules. You paste it into Supabase once.
supabase-photos.sql	The photo update: run it once in Supabase after supabase.sql (see Part 8).
supabase-friends.sql	The nicknames + blocking update: run it once after the groups file (see Part 14).
supabase-groups.sql	The group chats update: run it once after the other SQL files (see Part 12).
supabase-reset.sql	DANGER: deletes every account, group and message (see Part 13).
supabase-names.sql	The display name + username limit update: run it once after the other two (see Part 9).
README.md	This guide.
Big picture (how it fits together)
Supabase = your free "backend": it stores accounts and messages and pushes new messages live.
GitHub Pages = free hosting for your website (the single file index.html).
The website talks to Supabase using a publishable key. This key is designed to be public. It is safe to put in your website. Your data is protected by the security rules in supabase.sql, not by hiding the key.

🔐 Golden rule: never paste a key called secret or service_role anywhere in your website. The website will refuse to work and warn you if you do.

PART 1 — Create your free Supabase project
Go to https://supabase.com and click Start your project.
Sign up (the easiest way is Continue with GitHub).
Click New project.
Name: chatworld
Database password: click Generate a password, then copy it somewhere safe (a notes app is fine). You will rarely need it, but don't lose it.
Region: choose the one closest to you and your friends.
Plan: make sure Free is selected.
Click Create new project and wait 1–2 minutes until the dashboard appears.
PART 2 — Build the database (run supabase.sql)
In your Supabase project, click SQL Editor in the left menu (the >_ icon).
Click New query.
Open the file supabase.sql on your computer with Notepad / TextEdit, press Select All (Ctrl+A / Cmd+A) then Copy.
Paste it into the Supabase SQL box.
Click the green Run button (bottom right).
You should see "Success. No rows returned". 🎉

If you see an error, see Troubleshooting at the bottom. It's safe to run the file again.

PART 3 — Authentication settings
3a. Turn off email confirmation (recommended for a beginner)

By default Supabase makes every new user click a link in an email. The free plan only sends a few emails per hour, so sign-ups can get stuck. For learning and for a small friends-and-family chat, turn it off:

Left menu → Authentication.
Open Sign In / Providers (older dashboards: Providers).
Click Email.
Turn OFF the switch named Confirm email.
Make sure Allow new users to sign up stays ON.
Click Save.

If you keep "Confirm email" ON, ChatWorld still works. New users just have to click the link in their email before logging in.

3b. Tell Supabase your website address
Left menu → Authentication → URL Configuration.
Site URL: https://chatworld.github.io
Under Redirect URLs click Add URL and add: https://chatworld.github.io/**
Click Save.

(If your GitHub username isn't chatworld, use your own address: https://YOUR-USERNAME.github.io.)

PART 4 — Copy your Project URL and Publishable key
Left menu → Project Settings (gear icon) → API Keys (older dashboards: API).
Find and copy these two things:
Project URL — looks like https://abcdefghijk.supabase.co (It may be on the Data API / General page of Project Settings.)
Publishable key — starts with sb_publishable_… (On older projects it is called the anon public key and starts with eyJ…. That also works.)

✅ Use: Project URL and Publishable (or anon) key. 🚫 Never use: secret key, service_role key, database password.

PART 5 — Put your two values into index.html
Open index.html in Notepad (Windows) or TextEdit (Mac), then press Ctrl+F (Cmd+F) and search for YOUR_SUPABASE_URL. (Or do this step on GitHub in Part 6 using the pencil ✏️ icon.)
You'll find these two lines:
js
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_PUBLISHABLE_KEY = 'YOUR_SUPABASE_PUBLISHABLE_KEY';
Replace the text between the quote marks with your values. Keep the quote marks and the semicolon. Example:
js
const SUPABASE_URL = 'https://abcdefghijk.supabase.co';
const SUPABASE_PUBLISHABLE_KEY = 'sb_publishable_xxxxxxxxxxxxxxxxxxxxx';
Save the file.
PART 6 — Upload to GitHub and publish with GitHub Pages
6a. Create the repository
Go to https://github.com and log in (create a free account if you don't have one).
Click the + at the top right → New repository.
Repository name: must be exactly chatworld.github.io (This special name works only if your GitHub username is chatworld. For a different username, name it YOUR-USERNAME.github.io.)
Choose Public.
Tick Add a README file (this makes the next step easier).
Click Create repository.
6b. Upload the files
Inside your new repository, click Add file → Upload files.
Drag and drop these files from your computer into the page:
index.html (the one with your two values filled in!)
README.md
supabase.sql (optional, handy to keep as a backup)
(style.css and script.js are not needed any more. Everything is inside index.html.)
Scroll down and click Commit changes. (If GitHub asks about replacing the existing README, that's fine.)

⚠️ The files must be at the top level of the repository, not inside a folder.

6c. Turn on GitHub Pages
In the repository click Settings (top row of tabs).
Left menu → Pages.
Under Build and deployment → Source, choose Deploy from a branch.
Branch: pick main, folder / (root), then click Save.
Wait 1–3 minutes. Refresh the Pages screen until it says "Your site is live at https://chatworld.github.io".
6d. Editing a file later (e.g. fixing your key)

Open the file in your repository → click the pencil ✏️ icon → change it → Commit changes. The site updates in about a minute.

PART 7 — Test it! ✅
Open https://chatworld.github.io. You should see the ChatWorld login screen.
Click Sign up, make an account (a username and a password with 8+ characters. No email needed).
You land in Global Chat. Send a message.
Open the site in a second browser (or a private/incognito window) and sign up as another person.
Check these:
✅ Both people see the Global Chat messages instantly.
✅ The other person appears under Online with a green dot.
✅ Click their name → Send a private message. Only you two see it.
✅ Click your name at the bottom-left to edit your bio and colour.
✅ The logout icon (bottom-left) logs you out.
Open it on your phone. The ☰ menu button opens the people list.
PART 8 — Photos update (profile pictures + sending photos)

Do these in this order. If you upload the new index.html first, the site will show a message asking you to run the database update.

8a. Run the photo database update (once)
Supabase → SQL Editor → New query.
Open supabase-photos.sql, copy everything, paste it in, click Run.
You should see "Success. No rows returned". (Safe to run again.)

This creates two storage folders and the security rules:

Folder	Used for	Who can see it
avatars	Profile pictures	Anyone with the picture's link (profile pictures are not secret inside ChatWorld)
chat-images	Photos sent in chats	Private. Public-chat photos: logged-in users only. Private-chat photos: only the two people in that chat
8b. Upload the new index.html

On GitHub: Add file → Upload files, drag in the new index.html, Commit changes. Wait a minute or two, then refresh with Ctrl+Shift+R (Cmd+Shift+R on a Mac).

8c. Try it
Profile photo: click your name (bottom-left) → Upload photo → pick a picture → Save profile. Use Change photo or Remove photo later.
Send a photo: click the picture icon next to the message box → choose a photo → (optionally type a caption) → send. Click any photo in the chat to see it full size.
How photos stay safe and small
Every picture is shrunk and re-saved on your device before upload (photos max 1600 pixels wide, profile pictures 320 x 320). This keeps storage small and also removes hidden data such as GPS location from photos.
Only JPG, PNG, WebP and GIF files are accepted. Animated GIFs become still pictures.
You can only upload into your own folder, and no more than 10 photos per minute.
Nobody can attach someone else's photo to a message, and nobody can delete other people's pictures.
Private-chat photos are shown using temporary links that stop working after about an hour.
When you change or remove a profile photo, the old file is deleted. Photos sent in chats are kept (there is no delete button yet).
Free storage

Supabase's free plan includes a limited amount of file storage and download traffic (check supabase.com/pricing for the current numbers). Because photos are shrunk before upload (most end up well under 1 MB), a small or medium community should fit comfortably. You can see usage in Supabase under Project Settings → Usage (or Storage).

Photo troubleshooting
"Photos need a one-time database update" — do step 8a.
"Photos are not set up yet" — step 8a did not finish. Run supabase-photos.sql again.
"Photo not sent. You may be sending too many photos" — you hit the 10 per minute limit. Wait a minute.
A photo shows "Photo unavailable" — the person may have uploaded it before the update, or the link expired. Refresh the page.
Part 9 - Display names and the 5-day username limit

What's new

A display name is how your name shows in chat (spaces, capitals and emoji are fine, up to 30 characters). Change it any time.
Your username (what you log in with) can only be changed once every 5 days. Your first change is free.
After you change your username, you log in with the new one.

9a. Run the new SQL file (do this FIRST)

Open Supabase -> SQL Editor -> New query.
Open supabase-names.sql, copy everything, paste it in, click Run.
You should see Success. No rows returned.

9b. Upload the new website file

On GitHub, open your repository, click Add file -> Upload files.
Drag in the new index.html (it replaces the old one), then click Commit changes.
Wait 1-2 minutes, then refresh with Ctrl+Shift+R (Mac: Cmd+Shift+R).

9c. Try it

Click your name at the bottom left -> type a Display name -> Save profile.
Change your username once. Afterwards the box locks and shows the date you can change it again.

Good to know

If you upload index.html before running the SQL, the site shows a hint to run supabase-names.sql.
Only you (the site owner, in the Supabase dashboard) can bypass the 5-day limit.
Part 10 - Global Call (group voice call)

What's new: a purple phone item called Global Call sits under Global Chat. Click it, press Start Call, and allow your microphone. Anyone else who clicks it joins the same call. The call window has Mute and Leave buttons, and a green ring shows who is talking.

Setup: nothing in Supabase! There is no SQL to run. Just upload the new index.html to GitHub (Add file -> Upload files -> Commit changes), wait 1-2 minutes, then hard refresh (Ctrl+Shift+R, Mac: Cmd+Shift+R).

To test: open ChatWorld on two devices (or two browsers) with two different accounts, start the call on one and join on the other. Use headphones, otherwise you will hear echo.

Good to know

Voice goes straight between people's browsers (WebRTC). Supabase only passes the small connection notes, so it costs nothing extra.
Up to 8 people per call (everyone connects to everyone).
It uses free public STUN servers. On a few strict networks (some school/work/mobile networks) two people may not be able to connect. Fixing that needs a TURN server, which is not free.
Calls only work on the https GitHub Pages address, and the browser must be allowed to use the microphone.
The call channel is open to anyone who has the site's public key, like the rest of a static site. Voice is encrypted, but treat the call as a public room.
Part 11 - Private voice calls

What's new: open a private chat with someone and a purple phone button appears at the top right. Click it and their screen shows "is calling you" with Accept and Decline. If they accept, you are connected by voice. Either person can Mute or End call.

Setup: nothing in Supabase. Just upload the new index.html to GitHub (Add file -> Upload files -> Commit changes), wait 1-2 minutes, then hard refresh (Ctrl+Shift+R, Mac: Cmd+Shift+R).

Good to know

You can only call people who are online (green dot). The phone rings for 30 seconds, then gives up.
If they are already on a call, you are told they are busy.
You can only be in one call at a time (private or Global Call).
Use headphones to avoid echo. Same network limits as Global Call (Part 10).
Calls are set up over a shared channel, so a very technical person with your site's public key could try to listen in. For a hobby site this is fine. If privacy matters a lot, ask for the "locked-down calls" upgrade.
Part 12 - Group chats

What's new: a Groups section in the sidebar (under Global Call) with a + button. Click +, type a name, tick the people you want, and press Create group. Only the people in a group can see its messages, emoticons and photos.

12a. Run the SQL files (do this FIRST) Groups build on the earlier updates, so run these in this order. Each one is safe to run again, so if you are not sure whether you ran one, run it anyway:

supabase-photos.sql
supabase-names.sql
supabase-groups.sql

For each file: Supabase -> SQL Editor -> New query -> paste the whole file -> Run. You should see Success. No rows returned. If you run groups too early it tells you which file to run first.

The steps for the groups file:

Open Supabase -> SQL Editor -> New query.
Open supabase-groups.sql, copy everything, paste it in, click Run.
You should see Success. No rows returned. (Run it after supabase.sql, supabase-photos.sql and supabase-names.sql.)

12b. Upload the new website file

On GitHub, open your repository, click Add file -> Upload files.
Drag in the new index.html (it replaces the old one), then click Commit changes.
Wait 1-2 minutes, then refresh with Ctrl+Shift+R (Mac: Cmd+Shift+R).

Using groups

Click a group's name at the top to see its members, add more people, rename it (owner), remove people (owner), leave, or delete it (owner).
Anyone in a group can add more people. A group holds up to 50 people.
If the owner leaves, the person who has been in the group longest becomes the owner. If the last person leaves, the group is deleted.
You can make up to 20 groups, and 5 per hour.

Good to know

If you upload index.html before running the SQL, the Groups section shows a hint to run supabase-groups.sql. Everything else keeps working.
Group voice calls are not part of this update. Global Call and private calls work as before.
Part 13 - Fixing sign-up ("address is invalid") and starting fresh

Why sign-up failed: Supabase only accepts sign-up addresses whose domain can receive email. ChatWorld hides an address behind each username, and the old made-up domain could not receive email. It now uses username@gmail.com behind the scenes. People still only type a username and a password, and no email is ever sent.

Do these in order

Run supabase-photos.sql, then supabase-names.sql, then supabase-groups.sql (Supabase -> SQL Editor -> New query -> paste -> Run). The names file was updated, so run the new copy.
To delete ALL accounts (this cannot be undone): run supabase-reset.sql the same way. It permanently deletes every account (including yours), profile, group and message. Your tables and security rules stay.
Empty the photo folders: Supabase -> Storage -> open avatars, tick all files, click Delete. Do the same in chat-images. (Supabase does not allow deleting photos with SQL.)
Upload the new index.html to GitHub, wait 1-2 minutes, and hard refresh (Ctrl+Shift+R, Mac: Cmd+Shift+R).
Make a new account to test.

Good to know

Skip step 2 if you want to keep existing accounts. Accounts made with the old address would then need supabase-names.sql from before, so deleting everything is simpler.
Keep Confirm email OFF in Supabase (Authentication -> Sign In / Providers -> Email). Because the hidden address is not a real inbox, features such as "forgot password by email" will not work.
"Too many attempts": Supabase limits sign-ups and logins per network address. The site now pauses its buttons for a minute after that error so repeated clicks do not make it last longer.
Part 14 - Private nicknames and blocking

What's new: click anyone's name or picture to open their profile. You will now see:

Rename (only you can see this): type a name and press Save. That person now shows up with your name for them everywhere (sidebar, chats, groups, calls). Nobody else sees it, including them. Press Reset to bring their real name back.
Block (red button): after you confirm, that person cannot send you private messages, cannot call you, and you stop seeing their messages in Global Chat and groups. They are not told. Press Unblock in the same place to undo everything straight away.

14a. Run the new SQL file (do this FIRST)

Make sure you have already run supabase-photos.sql, supabase-names.sql and supabase-groups.sql.
Supabase -> SQL Editor -> New query, paste all of supabase-friends.sql, click Run. You should see Success. No rows returned.

14b. Upload the new website file

On GitHub: Add file -> Upload files, drag in the new index.html, click Commit changes.
Wait 1-2 minutes, then hard refresh (Ctrl+Shift+R, Mac: Cmd+Shift+R).

Good to know

If you upload index.html before running the SQL, renaming and blocking show a hint to run supabase-friends.sql. Everything else keeps working.
While you have someone blocked you cannot message them either. The message box in your private chat is greyed out until you unblock.
Blocking does not remove people from groups. You just will not see their messages there.
Calls are checked by the website, so blocking works for normal use. It cannot stop a technical person who changes the website code from trying to ring you; they still cannot message you.
Part 15 - Updating the site without logging people out

Good news: people stay logged in when you upload a new index.html. Their login is saved in their own browser and renewed automatically. They only log out when they press the logout button.

How to update safely

If the update comes with a new .sql file, run it in Supabase FIRST.
Then upload the new index.html to GitHub and wait 1-2 minutes.
People just refresh the page (or reopen the site) and they are still logged in.

Things that DO log people out (so avoid them)

Running supabase-reset.sql: it deletes every account.
Pointing the site at a different Supabase project (changing the URL/key lines in index.html): the old logins belong to the old project.
Moving the site to a different web address (for example a custom domain): each address keeps its own saved logins.
Someone clearing their browser data, or logging in on a new device.

If the site and the database are out of step (for example the new index.html is live before you ran the new SQL), a logged-in person now sees "ChatWorld could not load your profile" with a Try again button. They are NOT logged out. Run the SQL, then they press Try again.

Features
Register / log in / log out with a username and password
Profile photos (upload, change or remove from your device)
Photo sharing in Global Chat and private chats
Display names and a 5-day username change limit
Group chats with members, photos and emoticons
Private nicknames and blocking
Global Call: group voice call (WebRTC)
Private voice calls with a call button in private chats
Usernames and profiles (bio and avatar colour, editable)
Global Chat that everyone can read and write in
Private one-to-one messages with unread badges
Live online indicators (green dot, online counter)
Message history (last 50 messages, with a "Load older messages" button)
Mobile-friendly responsive dark design inspired by Discord / ChatGPT
Spam protection and security (see below)
Security explained simply
Row Level Security (RLS): The database checks every request. You can only read the global chat, your own private chats, and public profiles. Nobody can read other people's private messages. Logged-out visitors can read nothing at all.
No impersonation: The database only accepts messages whose sender is you.
No editing others: You can only change your own profile. Nobody can delete messages from the website.
Spam limits (enforced by the server): max 5 messages / 10 seconds, 200 / hour, and no repeating the same text more than twice in 30 seconds.
Message size limit: 1–1000 characters.
Safe display: Messages are shown as plain text, so nobody can inject code into the page.
Sign-up bot trap: a hidden form field catches simple spam bots. Login attempts are slowed down after 5 wrong tries.
Keys: only the publishable key is used in the website.

Honest limits to know about:

Private messages are protected from other users, but they are not end-to-end encrypted. You, as the Supabase project owner, can see them in the dashboard. Don't use ChatWorld for highly sensitive secrets.
For extra bot protection on sign-up you can later switch on CAPTCHA in Authentication → Attack Protection (Supabase supports free options such as Cloudflare Turnstile).
Free plan limits (roughly)

Supabase and GitHub change their free limits from time to time, so check supabase.com/pricing for the latest numbers. In general the free tier is plenty for a friends-and-community chat. Two things worth knowing:

Free Supabase projects are paused after about 1 week of no activity. If your chat stops working after a quiet period, open the Supabase dashboard and click Restore project. Your data is kept.
Free projects have limits on simultaneous live connections and monthly messages. A small or medium community will be fine.
Troubleshooting

The login screen shows a yellow "Setup needed" warning. You haven't filled in the two lines (search for YOUR_SUPABASE_URL) inside index.html (or GitHub hasn't updated yet — wait a minute and hard-refresh with Ctrl+Shift+R / Cmd+Shift+R).

"You pasted a SECRET key" warning. Replace it with the publishable (or anon) key. If you ever committed a secret key to GitHub, go to Supabase → Project Settings → API Keys and rotate/regenerate it.

The page is blank or shows a 404 on GitHub Pages.

The repository name must be exactly YOUR-USERNAME.github.io.
index.html must be at the top level of the repository.
In Settings → Pages, the source must be main / (root).
Wait up to 5 minutes after the first publish.

"Could not check the username. Did you run supabase.sql?" Run Part 2 again.

Sign-up says "email rate limit exceeded" or "Supabase did not accept the sign-up address". Supabase's free built-in email service sends only a few emails per hour. Turn off Confirm email (Part 3a) or wait an hour.

Messages don't appear live (only after refresh). Run supabase.sql again (it re-enables real-time). Then in Supabase go to Database → Publications and check that supabase_realtime includes messages and profiles.

"Message not sent" / "Slow down!". You hit the spam limit. Wait ten seconds and try again.

I changed something and it's not showing. Hard-refresh (Ctrl+Shift+R / Cmd+Shift+R). GitHub Pages can take a minute to update.

Still stuck? Open your browser's developer console (press F12 → Console tab), copy any red error text, and ask for help with that text.

Easy customisations
Site name / emoji: search for ChatWorld and 🌍 in index.html.
Colours: inside index.html, search for --accent and --bg-1 and change the colour values.
Message length / history size: inside index.html, search for MAX_LEN and PAGE_SIZE. If you raise MAX_LEN above 1000, also change the number 1000 in supabase.sql and run it again.
Spam limits: in supabase.sql, find messages_before_insert and change the numbers 5, 10 seconds, 200, then run the file again.

Enjoy ChatWorld! 🌍💬
