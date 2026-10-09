# Folded light — background refinement

## Direction

The user rejected floating sculptural objects and supplied references showing flowing illuminated surfaces and monochrome paper relief. The new backdrop is an original full-viewport vector composition: a broad mint crest, a lilac sheet curling down the right edge, and a warm pearl lower fold. An open dark center supports the calendar and reading surfaces. Existing mint/lilac/apricot accents and raised controls remain.

The attached reference images were reviewed visually. The supplied [Dreamstime page](https://www.dreamstime.com/modern-ui-ux-dashboard-background-neon-blue-glowing-d-wireframe-mesh-tunnel-geometric-perspective-grid-technology-image443017126) and [Magnific image URL](https://img.magnific.com/free-vector/paper-style-white-monochrome-background_23-2149010273.jpg) could not be fetched in this session. No stock artwork, promotional lettering, or watermark was copied.

## Implementation

- Original SVG paths, directional multistop gradients, soft cast shadows, and thin edge highlights create illustrated depth. These are shaded vector surfaces, not physically rendered 3D geometry.
- Removed the superseded WebGL renderer and its initialization. No graphics context, dependency, texture download, or perpetual animation loop is needed.
- Retained bounded pointer parallax through the existing coalesced animation-frame handler. Motion uses a transform; filters and artwork do not animate. This follows the transform/opacity guidance in [web.dev's animation guide](https://web.dev/articles/animations-guide).
- A separate phone width/crop keeps multiple folds visible. SVG fills the viewport and scales its original abstract forms responsively.
- Focus dims the artwork. Quiet material subdues it. Reduced motion removes parallax. Higher contrast hides the decorative layer. Reduced transparency keeps solid reading/navigation surfaces while retaining the opaque artwork.
- Decorative SVG is hidden from assistive technology and cannot receive focus. No labels or controls were added.

## Review and limits

Formatted the root HTML, compiled StudyCore, and regenerated the native HTML copy, fictional preview, and offline fingerprint. Visually reviewed desktop and phone fictional-data previews; phone review included reduced transparency. The artwork remains outside the content flow. No automated tests or native build were run, and real iPhone/Safari performance remains to be reviewed. Gradients and soft shadows can vary by browser.

All changes remain local and uncommitted. The root Application.html is the editable source; generated copies should be updated through npm run build:core.

## Wider composition

Expanded the SVG field of view from 1600 × 1000 to 2080 × 1300 (folds appear about 23% smaller on desktop). Extended the sheet boundaries to prevent exposed artwork edges, added restrained contour lines for surface detail, and reduced the phone overscan from 150% to 115%. The app controls and content keep their existing size.
