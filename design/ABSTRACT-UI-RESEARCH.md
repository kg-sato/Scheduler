# Abstract UI research and first implementation — October 5, 2026

## Reference access and interpretation

- [Adobe Stock 569707840](https://stock.adobe.com/fr/templates/web-ui-design-layout-with-3d-abstract-form/569707840): direct retrieval was unavailable. The supplied URL describes a 3D abstract web layout, but the actual artwork was not inspected.
- [VectorStock 14630966](https://www.vectorstock.com/royalty-free-vector/abstract-geometric-ui-screens-mockup-and-one-page-vector-14630966): listing and geometric UI metadata were accessible; opening the preview image failed. Do not describe this as a visual inspection.
- [Dreamstime 376965827](https://www.dreamstime.com/print-image376965827): accessible description emphasizes a dark landing page, flowing central gradient and minimal navigation. The actual preview image could not be opened. Applied broad flowing highlights near the edges of our functional surfaces, with neutral foreground text.
- [Magnific abstract UI collection](https://www.magnific.com/free-photos-vectors/abstract-ui): retrieval failed; no claims about its examples.
- [Vecteezy 26395763](https://www.vecteezy.com/vector-art/26395763-abstract-background-dynamic-wave-colorful-is-used-for-ui-ux-design-particularly-on-websites-apps-and-digital-interfaces): listing identifies a dynamic colourful wave background for digital interfaces. Used as a conceptual direction for subtle curved accents; artwork was not downloaded or reused.

These are stock-art references, not verified usability standards. All new decoration is original CSS. No stock purchase, licensing assumption or third-party asset embedding is involved.

## Original direction implemented

Keep the dark slate base with existing mint, lilac and apricot accents. Make the orbit beside the current event visibly three-dimensional using a masked conic gradient. Give the assignment overview a diagonal relief and the cards varied cropped arcs. Carry the same curve language into recurring rhythm and focus views. No continuously running decorative animations. Reduced-motion and high-contrast styling constrain the effects.

Preserve the existing calendar interactions, data, current-event text, buttons and timer. This is the first pass of a larger overhaul, not a completed redesign of every screen. Visual browser inspection is still outstanding.

## Engineering research

- [TypeScript outFile](https://www.typescriptlang.org/tsconfig/outFile.html): supports bundling global script output with the appropriate module configuration. A typed core can be built and embedded into the current offline HTML distribution; the build/source boundary must be documented before migration.
- [Apple notification permission](https://developer.apple.com/documentation/usernotifications/asking-permission-to-use-notifications): native reminders require permission handling and checking current authorization. Do not request permissions automatically on launch.
- [Apple local notifications](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/SchedulingandHandlingLocalNotifications.html): future reminder work needs stable request identifiers plus cancellation and rescheduling.
- [Official scheduled-task documentation](https://learn.chatgpt.com/docs/automations?surface=app): consulted for continuation options. This session exposes neither the automation-update tool nor an account usage meter; a checklist or saved prompt is not an active automation.

## Resume boundary

See TODO.md for ordered deliverables and pending usage-limit clarification. No features from the next phases should be represented as implemented yet. No tests, native build, commit, push or scheduled continuation was performed in this pass.
