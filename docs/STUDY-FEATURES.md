# Study features and source ownership

## Build
Run `npm ci` once, then `npm run build:core`. TypeScript 5.9.3 is pinned. The build compiles `src/study-core.ts`, replaces the generated `study-core` script in root Application.html, then synchronizes the native HTML and fictional preview and updates the offline shell version. Web-only installation metadata is stripped from those copies. Edit the typed core in src, never in the generated script. The remaining UI and styles are authored in root Application.html. All runtime code is embedded: no CDN or build tools are needed to open the app.

## Added workflows
- Assignment editor: expand Study steps, add named steps or starter steps, choose durations and completion. Save the assignment, then choose Plan steps to preview up to 30 days of available time through the due date. Save creates linked calendar blocks; existing linked blocks are kept. Changing a step does not automatically reschedule its block.
- Room to think: seven-day occupied/free view within configurable study hours. Over-target means planned study minutes exceed the daily study target; unscheduled assignments are not counted as calendar time.
- Capture + or Ctrl/Command Shift K opens a small form without switching pages. The shortcut is inactive inside inputs and dialogs.
- Personalize: accent, material, study window and daily target. Accent/material preview reverts if the dialog is cancelled.
- Focus: selecting an assignment attaches its ID to completed sessions. The timer offers complete-assignment and break actions on completion. Completing a timer does not automatically mark the assignment done.
- iPhone preferences: optional haptics and focus-completion notifications. Permission is requested on saving the reminder preference. Pause/reset replaces or cancels the pending notification. Apple build and device review still required.

## Course and reflection workflows

- Atlas collects courses from assignments, recurring events and saved weeks. A course can also be created directly. Its orbital ring reflects completed assignments; notes and confidence use an explicit Save action. Draft notes survive in-app navigation but are not part of exports until saved. Imports ask before discarding unsaved notebooks/reflections and offer a short Undo window afterward.
- Search (Ctrl/Command K) finds workspace actions, courses, assignments and events in the selected week. All search is local. Arrow keys move through results; Escape closes. The shortcut leaves text inputs and open dialogs alone.
- Week in orbit shows completed focus sessions for the selected week and current completion state of assignments due that week. It does not claim when an assignment was completed. Reflections are keyed by the week's Monday.
- Find study time offers up to six fitting windows across seven days. It respects occupied time, study hours and today's current time. Choosing one opens an event editor; it does not silently book it. A window after the selected assignment's deadline is labeled.
- Export opens JSON backup, calendar snapshot and web-install options. ICS times use the exporting device's timezone and include optional all-day open deadlines. Exported calendar events do not sync back. See WEB-APP.md for hosting and offline behavior.
- The phone toolbar exposes import, export, preferences and reflection via the compact menu. Search, capture and new-event actions stay directly available.

## Data compatibility
Old backups without the new optional fields remain valid. Assignments can now contain steps; preferences can contain theme/study-window/native settings; timer and sessions can contain taskId. Study data can also contain up to 80 course notebooks and 260 weekly reflections. New backups may not work in older app versions. Existing schedule storage keys are unchanged. No cloud migration occurs.

## Backend
backend/migrations/001_scheduler.sql and 002_notebooks.sql are unapplied Supabase/Postgres schema drafts. It includes ownership policies, versions and tombstones, but does not implement authentication, sync, an offline queue or account deletion. Requires a configured backend and review before use.

## Remaining review
No automated tests, native build or SQL execution performed. TypeScript compiled and HTML formatted. Desktop and 390px phone visuals (Atlas, weekly review and study-window suggestions) were inspected in the in-app browser after that connection became available. This was a limited visual review, not a full interaction audit. Next: inspect layouts and interaction states, review permission-denial and notification timing on iPhone, and finish widgets/account sync before release.

## Research and visual identity
See design/RESEARCH-OCT05.md for primary sources, design decisions and remaining design work. `python scripts/build_icons.py` regenerates the original orbital PNGs using Python's standard library. No external images, fonts or runtime dependencies are required.
