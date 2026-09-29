# Scheduler

A personal weekly planner with a calm glass-style interface. Runs on a PC as a single offline HTML file, with an iPhone container and a GitHub Actions workflow for native builds and TestFlight uploads.

## Run on your PC

Open `Application.html` in Edge, Chrome, or another modern browser. No installation, backend, package manager, or external libraries are needed. Keep the file at a stable location and use the same browser profile for localStorage persistence.

To serve it locally during development, run `python -m http.server 8000 --bind 127.0.0.1` from this folder and open `http://127.0.0.1:8000/Application.html`. This URL has separate storage from the directly opened file. Use Export/Import to transfer your schedule between locations or devices.

## Continue development

- Edit the root `Application.html`; it contains the HTML, CSS, and JavaScript in one file.
- Run `python scripts/sync_app.py` before committing to update the identical HTML bundled in the iPhone project.
- Commit changes on a branch and push to GitHub. The TestFlight workflow runs only when manually started.
- On a Mac, open `Scheduler.xcodeproj`. Signing and cloud build setup are documented in [docs/TESTFLIGHT.md](docs/TESTFLIGHT.md).

```sh
git switch -c my-change
# Edit Application.html
python scripts/sync_app.py
git add .
git commit -m "Describe the change"
git push -u origin my-change
```

## Files

| Path | Purpose |
| --- | --- |
| `Application.html` | Main application and source of truth |
| `Scheduler/` | SwiftUI/WebKit iPhone wrapper, app icon, bundled HTML |
| `Scheduler.xcodeproj/` | Xcode project and shared scheme |
| `.github/workflows/testflight.yml` | Hosted Mac compilation and optional upload |
| `scripts/ci_testflight.py` | Signing and upload using repository secrets |
| `upload-testflight.sh` | Upload from a Mac with Xcode configured |

## Behavior

Monday–Sunday weeks use the local ISO date of Monday. First visits copy the recurring template. Changes stay in the displayed week unless “Also update template” is checked; existing saved weeks remain unchanged. Stable event IDs connect weekly occurrences to template events.

Events use 30-minute steps between 06:00 and 23:00. Four editable starter events cover classes, study, work, and personal time. Overlaps share horizontal space. Editing, mouse/touch movement, deletion, keyboard dialogs, validation, and full JSON import/export are supported. Data stays in localStorage with no device sync.

## Verification and current limitations

The application passed 25 desktop Chromium/mobile-emulation checks, covering persistence, week isolation, template changes, overlaps, dragging, keyboard focus, validation, JSON restoration and 375px layout. No console errors were observed. JavaScript bridge checks also passed.

The native project has not yet been compiled or run on an iPhone. No TestFlight build has been uploaded. Apple signing credentials and an App Store Connect app record must be configured before uploading. Use GitHub repository secrets for signing material; credential files are excluded by `.gitignore`.
