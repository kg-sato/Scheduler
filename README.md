# Scheduler · Study edition

An offline planner for a university student's classes, assignments, focused work, and breathing room. A single HTML application powers both the browser and a SwiftUI/WebKit iPhone container.

## Open locally

Open `Application.html` in a modern browser, or serve the project with:

```sh
python -m http.server 8002 --bind 127.0.0.1
```

- **Your workspace:** http://127.0.0.1:8002/Application.html
- **Fictional student preview:** http://127.0.0.1:8002/design/scheduler-ui-preview/

VS Code also has a **Preview Scheduler** task. If port 8002 is already serving this project, use the existing server rather than starting a second one.

Browser storage is specific to the file location/browser profile or server origin. Use Export/Import to move your real schedule between locations or ports. The preview has its own session storage and does not replace your schedule.

## What is included

- Selected-day agenda, full week grid, free-time gaps, and current/upcoming event context.
- Course labels and event types; event editing, overlapping lanes, mouse/touch dragging in week view, and keyboard slot navigation.
- Recurring **My rhythm** template with independent saved weeks.
- Assignment desk with deadlines, completion, and study-block planning.
- Focus timer, assignment intentions, completed-session history, and a configurable weekly goal.
- Name, reduced-motion, and solid-surface preferences; system accessibility preferences are respected.
- Local storage, full JSON backup/restore, and native Files import/export in the iPhone wrapper.

## Development workflow

Read `AGENTS.md`. Leave work local and uncommitted for the owner to review in VS Code. Do not push unless explicitly asked.

The root `Application.html` is the source of truth. After editing it:

```sh
python scripts/sync_app.py
python scripts/sync_preview.py
```

| Path | Purpose |
| --- | --- |
| `Application.html` | Main application: UI, styling, scheduling, and study workspace |
| `Scheduler/` | SwiftUI/WebKit wrapper, app icon, bundled HTML, privacy manifest |
| `Scheduler.xcodeproj/` | Xcode project and shared scheme |
| `design/UI-DIRECTION.md` | Current direction and retained brainstorm |
| `design/RESEARCH-AND-DESIGN.md` | Research, visual identity, motion, compatibility, and review notes |
| `design/scheduler-ui-preview/index.html` | Generated interactive sample workspace |
| `.vscode/tasks.json` | Local preview and sync tasks |
| `.github/workflows/testflight.yml` | Manually triggered native build/upload workflow |
| `docs/TESTFLIGHT.md` | Signing and TestFlight setup |

## Data behavior

New weeks copy the recurring template. Edits remain in the displayed week unless **Also update my rhythm** is selected. Editing in **My rhythm** affects future, uninitialized weeks only. Already saved weeks keep their plans.

Events use 30-minute steps between 06:00 and 23:00. Assignment planning opens a proposed event for review and does not mark the assignment complete. Courses are derived from the labels on events and assignments.

The updated importer accepts the previous schedule format. New backups include optional study data and course/type fields, which the older app's strict importer cannot read. Import replaces the workspace represented by that backup; importing an old backup does not preserve newer study records.

The timer uses elapsed wall-clock time and catches up on return. It provides no native background alarm or notification. Only completed sessions contribute to the goal. Data remains on the device, with no cloud sync or telemetry.

## Review and release status

This redesign has had visual browser review and source inspection. No automated test suite was added or run for this iteration. Earlier verification claims for the previous interface do not validate these changes.

The iPhone HTML bundle has been synced, but this revision has not been compiled or run on an iPhone. It is not yet ready to claim TestFlight or App Store approval. Native layout, accessibility, data recovery, scheduling, timers, and signing still need a release validation pass. See [TestFlight setup](docs/TESTFLIGHT.md).
