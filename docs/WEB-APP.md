# Installed website and offline shell

## Local development

From the Scheduler directory, run `npm ci`, then `npm run build:core`. Start `python -m http.server 8002 --bind 127.0.0.1` and open `http://127.0.0.1:8002/Application.html`. The fictional preview remains at `/design/scheduler-ui-preview/`. A localhost address on this PC is not a phone-accessible hosted website.

## Hosting preparation

Publish only a reviewed static release containing `Application.html`, `manifest.webmanifest`, `sw.js` and `web/icons/`. Use HTTPS. Do not publish the entire repository, Git directory, native signing materials, environment files or backend migration tooling as the public site. The current entry point is `/Application.html`; configure the domain root to redirect there if desired. No deployment has been performed.

The manifest uses relative paths so a subdirectory deployment can work if all four paths remain together. Serve the manifest as `application/manifest+json`. Keep the service worker at the same directory level as Application.html. Use `Cache-Control: no-cache` for HTML and the worker so clients can discover updates.

## Installation

Export & install exposes instructions and, when the browser supplies it, an install prompt. Safari on iPhone/iPad uses Share → Add to Home Screen. Supported desktop/Android browsers may expose Install app. The manifest includes shortcuts to Atlas and Focus; support varies by platform. The native TestFlight app remains a separate delivery path.

## Offline behavior

The web app registers its worker only on HTTPS, outside the fictional preview and native shell. The worker caches a small allowlist of public application assets, never backup files or API responses. A content-derived version is updated by `npm run build:core`. Requests prefer the network and fall back to cached assets. A new worker waits for existing app windows to close; it does not force reloads. The first successful online visit is required before offline reopening is possible.

The application stores personal data in local storage, independently from the cached app shell. Clearing browser data can remove it. JSON export is the backup/migration path. Browser, installed-web-app and native storage may be separate; do not promise cross-device or cross-container synchronization. Account authentication, conflict handling, deletion and offline upload queues still need implementation.

## Icon generation

`python scripts/build_icons.py` creates web PNGs at 180, 192 and 512 pixels and replaces the Apple 1024px app icon. It uses standard-library math, PNG chunks and zlib only. Generated icons are opaque and use the study palette. Source geometry remains reviewable alongside the code.

## Required release review

No installation/offline or native-device testing was performed in this pass. Review installation on iPhone and Android, first-load failure, offline relaunch, upgrade with drafts open, cache eviction, multiple windows and backup recovery before publishing. Calendar export also needs round-trip review in Apple Calendar, Google Calendar and Outlook, including non-ASCII names and daylight-saving boundaries.
