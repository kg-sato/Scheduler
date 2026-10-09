# Dimensional observatory — October 9, 2026

> Historical first iteration: the floating WebGL knot described below was replaced after user feedback. The current implementation is the folded-light composition documented in `FOLDED-LIGHT.md`; no WebGL backdrop remains.

## What changed

The earlier backdrop used flat SVG rings with gradients. This pass adds actual 3D geometry: a continuous (2,3) torus knot, a thin lilac orbit, peach/mint satellites and a secondary cropped ring. A small inline WebGL renderer supplies perspective, depth testing, smooth surface normals, directional key/fill lighting, sharp highlights and a view-dependent colored rim. The scene and shader are original code; the torus-knot construction is a standard mathematical form.

The UI gets brighter upper edges, deeper lower shadows, more distinct mint/lilac lighting across the hero and timer, raised calendar selection and stronger navigation/control elevation. Text stays on opaque surfaces. The background has more color while retaining the existing mint, lilac, peach and dark slate direction.

## Research applied

- [Three.js: MeshPhysicalMaterial](https://threejs.org/docs/pages/MeshPhysicalMaterial.html) explains clearcoat, reflectivity, iridescence and transmission, including their cost and environment-lighting needs. The useful lesson is that changing light across a surface makes volume legible. This implementation uses a deliberately simpler stylized shader; it is not physically based transmission, true glass refraction or a Three.js material. No runtime package or external asset was added.
- [Three.js: rendering on demand](https://threejs.org/manual/pages/rendering-on-demand.html) distinguishes continuously animated scenes from interfaces that only need new frames after changes. The renderer responds to resize and fine-pointer input, eases toward a bounded orientation, then stops. There is no idle animation loop.
- [MDN: WebGL best practices](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/WebGL_best_practices) informed the single static geometry buffer, capped drawing-buffer resolution, shader/program checks, one allocation-time error check and cached uniform locations. Expensive synchronous checks do not run in the movement loop.
- [MDN: WebGL context lifecycle](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_lose_context) describes context loss/restoration. The code reveals the SVG fallback when a context is lost and rebuilds its resources when restored. No new data or calendar behavior depends on the canvas.
- [web.dev: high-performance animations](https://web.dev/articles/animations-guide) recommends limiting UI movement to transform/opacity when possible. Existing panel motion remains finite, and the new material shadows are static. The 3D scene necessarily redraws its small GPU scene during interaction; that still needs actual-device profiling.

Also reviewed the light-model and Fresnel sections of [Maxime Heckel's shader-lighting article](https://blog.maximeheckel.com/posts/refraction-dispersion-and-other-shader-light-effects/). Its practical distinction between diffuse volume, concentrated highlights and grazing-angle reflection supports the three lighting cues used here. Its multi-pass refraction approach is a possible future experiment, but was not added to a background behind study text. The shader uses standard lighting equations with original parameters and geometry.

## Limits and appearance behavior

- Drawing buffer capped at 1600 × 1200 and at 1.5 device-pixel ratio; CSS still fills the viewport.
- Fine-pointer tilt is bounded; touch devices use the static scene. Reduced-motion mode renders without pointer movement.
- Hidden documents stop requesting frames. Uniforms and mesh data are reused.
- Quiet material hides the canvas and shows the subdued SVG fallback. Higher contrast hides background artwork.
- Reduced transparency preserves opaque navigation and reading surfaces. The 3D objects themselves are opaque, so this setting does not erase them.
- Focus reduces the canvas intensity.
- Unsupported WebGL, failed shader setup, allocation errors and context loss leave the fallback artwork available. These failure paths are implemented but were not fault-injection tested.
- Lighting is stylized. There are no real environment reflections, ambient-occlusion pass, shadow maps or transmission effects.

## Local review

The repository was clean at the start of this pass. Work began around 1:48 a.m. EDT against the requested 2 a.m. cutoff. HTML formatting and TypeScript compilation succeeded, and the bundled Apple HTML, fictional preview and service-worker fingerprint were regenerated.

Visually inspected fictional-data renders of My day on desktop and phone, desktop Atlas, and phone Focus with reduced motion. The 3D scene rendered successfully in local Edge. The phone review included reduced transparency. No automated test suite, native Apple build, Safari/Firefox device review or frame-rate/battery benchmark was run. The app still needs physical-device performance and accessibility review before release.

All changes remain local and uncommitted. No push, deployment or scheduled continuation.
