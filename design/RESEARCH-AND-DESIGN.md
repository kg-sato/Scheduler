# Scheduler / Design record

## Current revision: After Hours — October 4, 2026

This dark revision supersedes the light paper palette described in the earlier iteration below. The owner requested a more abstract identity, neumorphism, dimensional forms, and bento grids, while retaining the In your orbit / Now event panel.

- Palette: midnight plum #15141d, surface plum #24202d, lilac #c5afff, mint #a5dbcc, apricot #efb49c, and acid yellow #dfff89.
- Layout: an asymmetric bento places the main orbit panel above two contrasting information tiles, alongside a tall focus dial. Calendar, assignments, and momentum continue below. It reorganizes into a two-column tile row and single-column calendar on phones.
- Dimensional design: a CSS chrome orbital ring, shaded sphere, recessed mint form, and apricot radial sculpture. These are lightweight CSS illustrations, not an external 3D engine or downloaded assets.
- Neumorphism: paired directional shadows, an inset timer well, raised primary controls, and pressed states. Borders and text contrast remain visible rather than relying only on shadows.
- Live data: Room to wander calculates unoccupied time between 09:00 and 21:00 on the selected date, merging overlaps. On the horizon shows the earliest unfinished assignment. Both have functional actions.
- Glass: dark translucent navigation and dialogs; steady blur and restrained hover/press motion. Reduced-motion and solid-material options remain available.
- The native wrapper now requests a dark appearance and uses the same midnight background. Native compilation and real-device validation have not been performed.

Reference: [the supplied UI trend video](https://www.youtube.com/shorts/CaFnJ6NGPEk) was inspected in the browser, including its liquid-glass, neumorphism, hyperrealism, brutalism, and bento-grid frames. The rendered new layout was visually reviewed at desktop and phone widths. No console errors were observed in the preview; no automated tests were run. All work remains local and uncommitted.

---
# Scheduler / Study edition

Design and implementation notes · October 4, 2026

## Intent

**Energized yet focused.** A university student's desk, with enough structure to begin and enough space to think. The distinguishing workflow is moving from an assignment to a deliberate study block, then into a focused session. The recurring rhythm supports a semester timetable without locking each week to it.

This is an implemented local iteration, ready for the owner's review. It has not been committed, pushed, submitted to Apple, or validated on an iPhone.

## Research → decisions

| Source | Relevant finding | Design decision |
| --- | --- | --- |
| [Figma: web design trends for 2026](https://www.figma.com/resource-library/web-design-trends/) | Expressive typography, vivid color, motion, and tactile surfaces are recurring directions. | Combine editorial serif headlines with practical sans-serif controls. Reserve electric blue and lime for selected and active states; keep the working surface quiet. |
| [Design Studio UI/UX: AI-driven trends, supplied reference](https://medium.com/@designstudiouiux/ai-driven-trends-in-ui-ux-design-2025-2026-7cb03e5e5324) | Discusses personalization, adaptive interfaces, and the need for accessibility and trust. | Personal name, goal, course labels, and material/motion preferences. Context comes from the actual schedule. No speculative AI claims, account, or remote data processing. |
| [Apple: Materials](https://developer.apple.com/design/human-interface-guidelines/materials) | Liquid Glass establishes a floating control layer; broad use in content can obscure hierarchy. | Glass date navigation, mobile dock, modal surfaces, and transient controls. Event cards retain solid readable colors. This is a web approximation, not native Liquid Glass. |
| [web.dev: high-performance animations](https://web.dev/articles/animations-guide) | Transform and opacity are the preferred starting point for efficient animation; blur and shadows can require painting. | Short transforms/fades for scenes and dialogs. Blur is static and localized. No continuously animated backdrop blur, mouse-following shader, external animation package, or decorative looping scene. |
| [Notion: using Calendar with Notion](https://www.notion.com/en-us/help/use-notion-calendar-with-notion) | Tasks can be given dates and updated alongside calendar work. | A compact assignment desk with course, deadline, completion, and a Plan action that opens an editable calendar block. Scheduling never silently completes an assignment. |

These are product and design references, not evidence of measured usability or learning outcomes. No student interviews, accessibility audit, or comparative performance study has been conducted.

## Visual identity

- **Orbit mark:** two intersecting ellipses and a blue point. Repeated as fine-line artwork in the current-event panel and a measured ring in the focus timer.
- **Paper:** `#f4f5f0`. Ink: `#192620`. Electric blue: `#265be8`. Lime: `#d2f76a`.
- **Academic palette:** muted plum, olive, teal, and clay for subject differentiation. Labels supplement color.
- **Typography:** offline system sans serif for working text; Georgia for expressive headlines; system monospace for time and metadata. No font downloads.
- **Voice:** concise, humane, and encouraging. Open time is breathing room. No streak punishment or productivity score.
- **Structure:** slim navigation, central schedule, and study rail on desktop; selected-day agenda and floating navigation on mobile. Full week remains available as an explicit secondary view.

## Motion and material specification

| Interaction | Treatment |
| --- | --- |
| Button press | 160 ms, small scale change; visible keyboard focus remains separate |
| Day selection | 280 ms number settle; selected state also uses shape and color |
| Page/day switch | 350 ms opacity and 7 px vertical entrance |
| Event/task editor | 320 ms opacity/scale/translation; steady backdrop blur |
| Task completion | 220 ms feedback before the list updates; focus moves to an available task control |
| Focus session | Timestamp-based display, updated once per second; progress ring changes smoothly |
| Hover | Subtle lift on event cards; no movement required to discover actions |

System reduced-motion preference and the in-app calmer-motion setting suppress transitions. System reduced-transparency preference and the solid-surfaces setting remove the main glass effects. Increased-contrast styling strengthens boundaries. These provisions need a formal accessibility review before release.

## Implemented workflows

1. **My day:** select a date, see current/upcoming context, edit duration-aware agenda cards, and plan into open gaps. Day lengths are visually bounded to keep long events manageable; exact times are always shown. The week grid retains true proportional placement, overlapping lanes, dragging, and keyboard slot navigation.
2. **Assignments:** capture a title, course, due date, and study-block estimate; edit, complete, reopen, or delete. Upcoming work sorts by date. Plan finds a gap on the selected day and opens a draft for confirmation. Existing classes are considered when finding that gap.
3. **My rhythm:** edit recurring template events directly. Changes affect newly initialized weeks. Already saved weeks retain their events. Regular event editing can update both the displayed week and the rhythm when the checkbox is selected.
4. **Focus room:** choose 25, 50, or 90 minutes, start/pause/resume/reset, optionally select an assignment as the intention. Completed sessions count toward a configurable weekly goal.
5. **Personalize:** name, weekly target, calmer motion, and solid surfaces.

## Data and compatibility

- The existing `week-by-week.schedule.v1` browser storage key is preserved.
- Existing `{template, weeks}` backups remain accepted. Optional `course` and `kind` event fields and an optional `study` root object hold the new features.
- Export includes the entire workspace, including assignments, focus sessions, preferences, and timer state. An old backup that lacks study data restores only that old schedule; it does not retain newer study records.
- The older app version's strict importer does not understand the new fields. Use this updated version to reopen new exports.
- Normal saves refuse to overwrite storage changed by another window since loading; reload to pick up those changes. Explicit import remains a replacement operation.
- No server, analytics, CDN, online account, or cloud sync is introduced.
- Browser storage belongs to its origin. `file://`, port 8000, port 8001, and port 8002 are separate contexts. Export from the old context and import into a new one when moving real data.
- The preview uses a separate session-storage key, a fixed illustrative date/time (October 5, 2026 at 10:20), and fictional student records. It cannot replace normal app storage.

## Review performed and release boundaries

The rendered preview was visually reviewed at phone and narrow desktop sizes, including the agenda, assignment desk, focus room, and event dialog. Source inspection covered storage compatibility, template isolation, filtered-gap handling, focus restoration, and timer persistence. No automated test suite was added or run.

Before release, verify CRUD, imports/exports, recovery, overlapping events, dragging, keyboard navigation, VoiceOver, larger text, reduced settings, and timer behavior on real iPhone hardware. Native compilation and TestFlight signing remain separate work. Browser timing is based on elapsed wall-clock time and catches up when the app resumes; it does not provide a native background alarm or push notification. Paused/unfinished sessions do not count toward the focus goal. The timer is a personal aid, not a measurement of attention.

## Continue locally

- Edit `Application.html` as the source of truth.
- Run `python scripts/sync_app.py` to update the iPhone bundle.
- Run `python scripts/sync_preview.py` to regenerate the isolated preview.
- In VS Code, run **Tasks: Run Task → Preview Scheduler**. Open `http://127.0.0.1:8002/design/scheduler-ui-preview/` for the sample workspace or `/Application.html` for your actual local workspace.
- Leave changes uncommitted. The owner reviews and decides when to commit and push.
