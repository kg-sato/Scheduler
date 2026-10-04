# UI direction: energized yet focused

## Agreed direction

The experience should feel energized yet focused. Liquid Glass alone felt too generic; the design needs an identity rooted in the scheduler's recurring template and independent weeks.

Working concept: **Your day, in motion.**

## Proposed next design iteration

- Cool off-white canvas with ink-colored text, electric blue events, and a restrained lime accent for the current moment and primary action.
- A prominent Now / Next section showing the current event, the following event, and the gap between them.
- A daily timeline with event lengths reflecting duration and visible free-time gaps.
- A floating glass week selector and add button; readable event surfaces with stronger body.
- Large times, short labels, fewer borders, and deliberate spacing.
- Quick, restrained transitions: selected days slide into place; events expand into their editor. Respect reduced motion and reduced transparency preferences.
- Make the existing recurring-template model understandable through “My rhythm” and “This week.” Edits must preserve the existing distinction between template changes and saved weeks.

These are brainstorming proposals to develop and review, not completed application features.

## Earlier ideas retained for exploration

- “Your rhythm”: show the shape of a day, breaks, and breathing room.
- “Weekly studio”: movable schedule blocks, a reusable routine drawer, and indicators for departures from the usual week.
- “Quiet focus”: current and upcoming events take priority, with the full schedule readily accessible.
- Optional curated palettes: Glacier, Dusk, Graphite.
- Schedule-derived summaries such as “Your evening is open”; no AI service is required for simple summaries.

## Current preview

Open [scheduler-ui-preview/index.html](scheduler-ui-preview/index.html) directly in a browser. It is a standalone, static concept with representative sample events and no external dependencies.

The current preview contains the earlier Liquid Glass-inspired direction: desktop week grid, phone agenda, and edit-event sheet. It includes increased translucency, bright surface edges, background color, and rounded glass controls. It does **not yet implement** the proposed electric-blue/lime Now / Next redesign above. Buttons in this preview are illustrative.

The material is a CSS approximation, not Apple's native Liquid Glass. Native adoption and supported iOS versions require a separate implementation decision.

## Implementation sequence

1. Refine and review the energized-yet-focused mockup.
2. Implement the approved design in the root Application.html while preserving scheduling behavior, offline storage, import/export, and accessibility.
3. Sync the HTML into the iPhone wrapper using scripts/sync_app.py.
4. Review native layout and behavior on Apple hardware, then complete signing and TestFlight preparation described in docs/TESTFLIGHT.md.

## Figma

An empty design workspace was created at https://www.figma.com/design/NkpzViO6SG5SldON0aamgR . Local HTML preview work can continue independently of Figma tool quotas. The embedded workspace does not itself guarantee a higher account quota. No personal schedule data is included in this design preview.
