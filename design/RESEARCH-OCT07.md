# Observatory UI — October 7, 2026

## Direction

Keep the mint, lilac and apricot palette and the sculpted calendar, class card and timer. Give the rest of the application a recognizable setting: a dark study observatory with intersecting orbital ribbons, restrained glass navigation and stable surfaces for reading. The artwork is original inline SVG; no reference artwork or commercial kit assets were copied.

## Implemented

- Floating sidebar with an inset glass lens that travels to the selected page. Its position follows actual button geometry through a ResizeObserver. Tablet navigation collapses to labelled icons; phones retain five labelled destinations.
- Compact command bar with a recessed search field, platform-specific shortcut hint, capture, new event and an options menu. Import/export remain available through that menu.
- Shaded mint/lilac/apricot ribbon sculpture, fine background texture and bounded pointer parallax. Background angle follows the current page; Focus reduces the visual intensity.
- Finite panel and dialog entrance animations, button feedback, course-card lift and an interactive class-card orbit. No continuous decorative animation loop.
- Cleaner system typography, shorter Atlas and assignment copy, neutral slate inputs and consistent dialogs/notices. Calendar interactions and existing student data remain intact.
- Focus beacon derived from the existing timer: active/paused time, progress ring and a return action. It sits in the desktop toolbar and above phone navigation. It does not independently save or operate the timer.
- Solid surfaces, reduced motion and higher contrast remain supported. Solid mode retains subdued artwork; higher contrast removes it. Preferences explains which device settings are active.
- Root HTML regenerated into the bundled Apple interface and fictional preview; offline shell fingerprint refreshed.

## Research and decisions

### Apple: materials as a functional layer

Read the complete accessible [Meet Liquid Glass WWDC25 transcript](https://developer.apple.com/videos/play/wwdc2025/219/). Apple describes a separate navigation/control layer, contextual contrast and restrained material use. Applying glass to every content card would weaken the separation. Scheduler therefore gives the sidebar and command bar glass, while calendar and task text remain on steadier surfaces. CSS blur, gradients and borders approximate depth; this is not Apple's native refractive material.

### Linear: less competition between controls

Read [A calmer interface for a product in motion](https://linear.app/now/behind-the-latest-design-refresh), by Charlie Aufmann and Maxime Heckel, March 12, 2026. The useful lesson is predictable action placement and different visual weights for navigation and work. Applied through quieter course filters, fewer permanent toolbar actions and consistent page headings. Scheduler keeps more expressive artwork because its study-space identity differs from an issue tracker.

Read [A Linear spin on Liquid Glass](https://linear.app/now/linear-liquid-glass), by Robb Böhnke. It describes adapting materials to the product, including custom highlights, restrained refraction and accessibility variants. Applied the principle of controlling material strength and contrast. Their SwiftUI/shader implementation was not copied or added to this web interface.

### Motion engineering

Read [web.dev's animation guide](https://web.dev/articles/animations-guide). Prefer transform/opacity for motion and avoid assuming that blur is cheap. New transitions primarily move/fade existing layers; pointer updates are coalesced into one requested frame, stop when the document is hidden and reset when motion preferences change. Blur remains static. Real-device frame-time and battery measurements remain outstanding; these choices are not a measured 60fps guarantee.

Reviewed Three.js's official [rendering on demand](https://threejs.org/manual/pages/rendering-on-demand.html) and [responsive design](https://threejs.org/manual/pages/responsive.html) guidance. Rendering only when needed is appropriate for productivity software. This pass uses scalable SVG/CSS geometry, which stays offline and does not introduce a WebGL runtime for a decorative background. A genuine interactive 3D course map would justify a separate Three.js prototype with capped resolution, context-loss fallback and a measured device budget.

## Supplied references: access and interpretation

| Reference | What was available | Application / qualification |
| --- | --- | --- |
| [Medium: Apple's new Liquid Glass UI](https://medium.com/design-bootcamp/apples-new-liquid-glass-ui-the-power-of-perception-or-how-to-innovate-when-you-can-t-21951ea70661) | Article body read | Treat as a critical opinion, not evidence of Apple's motives. Its readability and hierarchy concerns informed the opaque reading surfaces and reduced-motion support. |
| [Motion The Agency: Apple Liquid Glass](https://www.motiontheagency.com/blog/apple-liquid-glass-design) | Article body read | Useful discussion of brand continuity, material depth and feedback. Early-release terminology and accessibility claims require independent verification; Apple documentation took precedence. |
| [Figma iOS 26 Control Center kit](https://www.figma.com/community/file/1515608601108987500/apple-liquid-glass-ios-26-control-center-ui-kit) | Access blocked by robots restrictions | No claim to have inspected or implemented the actual kit. No Figma file was created or altered. |
| [Nixtio lodge booking](https://dribbble.com/shots/27389159-Landing-Page-Design-for-Lodge-Booking) | Page description read; actual shot media unavailable | Described cinematic setting and floating controls informed the ambient frame. No claim of visual or motion inspection. |
| [Nixtio gaming dashboard](https://dribbble.com/shots/27301580-Gaming-Dashboard-UI-Animation) | Page description read; actual animation unavailable | The described combination of dark surfaces and playful dimension supports expressive accents around clear workflows. No copied layout or animation. |
| [Nixtio marketing dashboard](https://dribbble.com/shots/27320782-Marketing-Analytics-Mobile-Dashboard-UI) | Page description read; actual shot media unavailable | Retain focused summaries and clear content priority. A promotional shot does not establish usable touch targets or real performance. |
| [Ronas recruitment dashboard](https://dribbble.com/shots/25605862-Recruitment-Dashboard) | Page description read; actual shot media unavailable | Consider modular organization and tonal separation. Do not import recruiting-specific metrics into a student planner. |
| [3D UI kits video](https://www.youtube.com/watch?v=7d9p1HFamaQ) | Public title identifies Punit Chawla's 2020 Design Essentials video. English caption track was advertised but returned an empty response. | Not watched/transcribed successfully. No detailed teaching attributed to it. Its age also means tool availability would need current verification. |
| [VectorStock 3D UX illustration](https://www.vectorstock.com/royalty-free-vector/ui-ux-design-mobile-prototype-3d-user-experience-vector-46475090) | Listing metadata read; full illustration unavailable | Licensed stock reference, not a production asset. Scheduler's geometric artwork was created in code. |
| [3D tools video](https://www.youtube.com/watch?v=kiIh1tCwAxU) | Public title identifies Punit Chawla's 2022 Design Essentials video. English caption track returned an empty response. | Not watched/transcribed successfully. No unsupported claim that its tools were researched or adopted. |

## Local review

The normal shell sandbox and in-app browser automation failed to initialize. Approved local shell execution was used to edit the canonical repository. A separate headless Edge profile rendered only fictional preview data; no personal browser profile or account was used.

Reviewed desktop (1440px), tablet (900px), phone (390px), solid surfaces and reduced-motion variants. Inspected My day, Assignments, Atlas, Rhythm, Focus and the contextual focus indicator. This caught and corrected Atlas horizontal overflow, a cramped tablet search field and a fixed-position indicator being constrained by a blurred ancestor.

The current Windows environment reports reduced transparency. The app respects that setting. Full-material review images use a browser-only media preference emulation; no Windows accessibility settings were changed. The full glass appearance is available when the device allows transparency.

TypeScript compilation and HTML formatting completed. No automated test suite, native Apple build, physical-device performance measurement or deployment was run. Browser screenshots do not establish cross-browser or screen-reader correctness.

## Next focused pass

1. Consolidate the accumulated CSS layers after the visual direction is approved; avoid changing working event/task behavior during that extraction.
2. Review keyboard navigation, zoom, long course names, large data sets and all dialog states in Firefox and Safari, then on an actual iPhone.
3. Profile blur and pointer response on older Apple hardware before considering a Three.js scene.
4. Prototype a meaningful 3D relationship view only if it helps students understand their work; keep all actions available in the ordinary course list.
5. Continue the separately documented account/sync and signing work before a TestFlight release.

All changes are local and uncommitted. No push, deployment or automatic continuation was scheduled.

## October 8 closeout

Finished the remaining small polish: shortened preference labels and the device-appearance explanation, and moved keyboard focus to the page heading when the focus beacon opens the Focus room. Regenerated the app copies. The October 7 pass was interrupted by an automatic approval-review usage limit; this closeout completes the local handoff without expanding the redesign scope.
