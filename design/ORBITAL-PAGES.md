# Orbital pages — October 5, 2026

## Direction

Preserve the existing calendar controls, class hero, tabs and focus timer. Bring the schedule and assignment surfaces into that same visual family. Dark slate remains the material; mint is a small accent, with neutral text. Abstract circles form quiet relief behind content instead of competing with it.

## Implemented

- Assignment overview: real open count, estimated effort across all open work, and completed/total orbit. Estimates are workload, not a promise that everything fits today. Zero assignments displays 0/0 without claiming progress.
- Assignment groups: overdue, due today, next seven days, further out; completed work remains a separate tab. Deadline ordering is preserved.
- Assignment cards: recessed completion control, raised surface, cropped circular relief, visible Plan and Focus actions. No hover-only essential controls.
- Schedule: non-current event rows gain sculpted edges. A small time map locates events on the existing 06:00–23:00 range. It is decorative and hidden from assistive technology because the accessible agenda already supplies the information. Overlapping segments are not a workload chart.
- Motion: brief card lift on interaction, no perpetual decorative animation, and reduced-motion support. High-contrast borders remain available.
- Completion returns keyboard focus to an available task control or the visible add-assignment control.

## Supplied references

- [OpenAI Community](https://community.openai.com/t/5-ways-i-use-chatgpt-as-a-ui-ux-design-assistant/1387951): reviewed the discussion about copy, screen planning, requirements, accessibility and iteration. Applied concise labels and explicit empty/completed states. This is community advice, not an accessibility certification.
- [Unity discussion](https://discussions.unity.com/t/how-to-improve-ui-design-skills/818174): reviewed the distinction between interaction structure and visual styling. Kept consistent completion/edit/plan actions and a predictable hierarchy beneath the ornament.
- [Rohan Mishra on LinkedIn](https://www.linkedin.com/posts/iamrohanmishra_this-is-the-best-way-to-become-incredible-activity-7292418305405992960-kQq7): the original post describes copywork as a private learning exercise. Studied the reasons behind patterns and created original CSS composition; did not clone another product or reuse its artwork.
- [Facebook post](https://www.facebook.com/groups/2788777944712613/posts/3629677627289303/): direct retrieval failed and an exact-ID search returned no accessible result. Its content has not been reviewed. A screenshot or pasted text would let us incorporate it later.

## Product patterns adapted

- [Things: date-based lists](https://culturedcode.com/things/support/articles/4001304/): time horizons make large task collections easier to scan. Our groups represent due dates, not Things' separate planned-start dates.
- [Sunsama: daily planning](https://www.sunsama.com/daily-planning): make time estimates visible beside planning. We show aggregate estimated effort and retain the existing event-draft workflow. No automatic capacity planner is claimed.
- [Amie: tasks](https://amie.so/documentation/features/tasks): tasks and calendar should be close in the workflow. Each card keeps direct Plan and Focus actions. External calendar integration and AI scheduling are not implemented.

## Review status

Canonical HTML formatted and copied into the native bundle and isolated preview. No automated tests or native build run. Browser inventory returned no available browsers and opening the in-app browser failed, so this revision has not been visually inspected. Review desktop/mobile composition, long titles, empty/completed groups and focus states before release. No commit, push, deployment or account sync was performed.
