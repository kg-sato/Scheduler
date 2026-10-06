# Study Observatory — October 5, 2026

## Direction

Keep the slate, mint, lilac and apricot materials. Give each useful surface its own related form: course planets, a seven-day sculpture, crescent study windows and the existing class/timer rings. Reserve dense glass for temporary search and dialogs; keep reading and editing surfaces stable. Decorative shapes never capture pointer input or replace text labels.

## Research translated into implementation

- **Things: project headings.** [Official guide](https://culturedcode.com/things/support/articles/2803577/) explains grouping complex projects into smaller parts. Applied as course-level organization and visible assignment steps rather than one undifferentiated task list.
- **Notion: sub-tasks and dependencies.** [Official guide](https://www.notion.com/en-gb/help/guides/tasks-manageable-steps-sub-tasks-dependencies) informed the separation of assignments from their study steps. Scheduler preserves step order, presents proposed bookings and requires a save action.
- **Linear: command-bar access.** [Official issue-creation documentation](https://linear.app/docs/creating-issues) describes keyboard and command-bar actions. Applied as local Ctrl/Command K search with course, assignment, current-week event and workspace results. Results use ordinary buttons, keyboard navigation and explicit labels.
- **iCalendar.** [RFC 5545](https://www.rfc-editor.org/info/rfc5545/) is the reference for calendar-file output. The typed exporter escapes text, uses CRLF, folds at 75 UTF-8 octets and emits UTC event times plus all-day deadlines. Export is a snapshot, not a subscription or sync connection.
- **Installed web apps.** [web.dev manifest guidance](https://web.dev/learn/pwa/web-app-manifest) and [MDN installability guidance](https://developer.mozilla.org/en-US/docs/Web/Progressive_web_apps/Guides/Making_PWAs_installable) informed the manifest, standalone display, PNG icon sizes and home-screen shortcuts. [web.dev updates](https://web.dev/learn/pwa/update) informed the decision not to force activation or reload while drafts may be open.
- **Apple file export.** [SwiftUI fileExporter](https://developer.apple.com/documentation/swiftui/view/fileexporter(ispresented:document:contenttype:defaultfilename:oncompletion:)) remains the native destination for JSON and ICS exports. No calendar-account permission is requested for a file export.

## Original assets and motion

The orbital icon is original mathematical artwork from `scripts/build_icons.py`; it uses the Python standard library and creates opaque PNGs. No stock image or external font is required. Course sculptures and study-window crescents are CSS geometry. Hover movement is short and transform-based; reduced-motion disables movement. Reflections and course notes are explicitly saved, and private search stays on-device.

## What is still provisional

Desktop and 390px phone layouts were visually inspected in the in-app browser. This is not a full interaction, accessibility, performance or installation audit. Native builds, notification permission/timing, calendar imports in other apps, offline recovery and SQL policies have not been exercised. HTTPS hosting and account sync are not connected. WidgetKit remains planned.

## Next design work

1. Course archive/rename flows that preserve existing assignments and event links.
2. A consistent empty-data onboarding flow using a student's actual semester.
3. Semester-scale deadlines and exam preparation, built on the existing step planner.
4. More deliberate desktop composition for dense schedules, long course names and many overlapping events.
5. Consolidate the accumulated CSS layers after the current visual direction is approved.
