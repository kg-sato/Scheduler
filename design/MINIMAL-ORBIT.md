# Quiet Orbit — October 4, 2026

## Research translated into the interface
- [Justinmind](https://www.justinmind.com/ui-design/neumorphism): match surface and component colours; choose a non-black base and consistent lighting. Implemented slate #292b33, top-left highlights, bottom-right shadows, and inverted shadows for recessed controls.
- [UX Design Institute](https://www.uxdesigninstitute.com/blog/neumorphism-in-ui-design/): use depth selectively, preserve readable labels and visible focus, and simplify surrounding content. Timer and date controls carry depth; calendar rows remain clear. Selected dates have colour and depth cues. Contrast and reduced-transparency overrides retained.
- [Design Studio UI/UX](https://medium.com/@designstudiouiux/blending-glassmorphism-neumorphism-for-modern-ui-580e0272952f): both effects can impair hierarchy and readability. Glass is limited to dialogs and floating navigation; the main workspace uses opaque surfaces.
- [Nielsen Norman Group](https://www.nngroup.com/articles/aesthetic-minimalist-design/): prioritize task-relevant content. Removed promotional headings, decorative tiles, duplicate task rail and motivational copy from the daily view. Assignments remain in their labeled destination; weekly progress is on Focus. Event notes remain in the event editor.

## Hierarchy
Current event → selected day and agenda → optional focus timer. Retain the In your orbit identity. Colour appears in course markers and active controls rather than large competing tiles. Existing calendar, backup, assignment and focus workflows retained.

## Scope
Root app, native HTML bundle and fictional browser preview synchronized. Local edits only. No automated tests or native build run. Real-user usability and native device review remain necessary before release.
