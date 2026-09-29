# Scheduler — iPhone / TestFlight package

This is a native SwiftUI/WKWebView container for the included self-contained Application.html. It works offline, uses persistent WebKit localStorage, and connects Import/Export to the iOS Files picker. The UI and scheduling logic use vanilla HTML, CSS and JavaScript, with no external dependencies. The native wrapper uses only Apple system frameworks. Deployment target: iOS 16 or later; iPhone.

## Current status

The HTML app passed automated desktop Chromium and 375px mobile-emulation checks. The native project has been prepared on Windows and has **not been compiled, signed, tested on iOS, or uploaded**. Xcode, a Mac, and an authorized Apple Developer account are needed to complete those steps. No Apple account credentials are included. This source package is not an installable IPA.

## Build and test on a Mac

1. Install a current App Store Connect-supported Xcode, launch it once, and sign in under Xcode > Settings > Accounts.
2. Open `Scheduler.xcodeproj`. Select the Scheduler target > Signing & Capabilities; select your team and replace `com.example.scheduler` with your unique registered bundle identifier.
3. Run on an iPhone simulator and then a physical iPhone. Check first launch, drag with touch, dialog focus, the keyboard, Files import/export, relaunch persistence, and the Reduce Motion setting. The desktop automation does not substitute for native device testing.
4. In App Store Connect, create the app record matching this bundle identifier. Use your own app name if the proposed name is unavailable.

## No Mac: build on GitHub's hosted Mac

The included `.github/workflows/testflight.yml` runs on GitHub's macOS runner. You do not need to own a Mac. This workflow is prepared but has not run yet. A GitHub repository/connection and your signing setup are still required; private-repository macOS usage may consume billable GitHub Actions minutes according to your plan.

1. Put **the contents of this folder** at your repository root, including the hidden `.github` folder. `Scheduler.xcodeproj` must be at the root.
2. Open Actions > Build and upload to TestFlight > Run workflow. Leave Upload unchecked for a native compilation check; this needs no Apple secrets.
3. Create the app's bundle identifier, an Apple Distribution signing certificate, an App Store distribution provisioning profile, and the matching App Store Connect app record in your Apple account. The P12 must contain the certificate and corresponding private key. These signing materials can also be prepared from Windows using OpenSSL and Apple's Developer portal.
4. In repository Settings > Secrets and variables > Actions, add the following variables and secrets. Do not put private keys or passwords into source files or chat.

| Kind | Name | Value |
| --- | --- | --- |
| Variable | `APPLE_TEAM_ID` | Your 10-character Apple Developer team ID |
| Variable | `APPLE_BUNDLE_ID` | Your registered bundle identifier |
| Secret | `BUILD_CERTIFICATE_BASE64` | Base64 of the Apple Distribution P12, including private key |
| Secret | `P12_PASSWORD` | Password protecting that P12 |
| Secret | `BUILD_PROVISION_PROFILE_BASE64` | Base64 of the matching App Store provisioning profile |
| Secret | `ASC_KEY_ID` | Your App Store Connect API key ID |
| Secret | `ASC_ISSUER_ID` | Issuer ID for the API key |
| Secret | `ASC_PRIVATE_KEY` | Full contents of the corresponding `.p8` file |

5. Run the workflow with Upload checked. It first checks native compilation, then imports the signing credentials into a temporary keychain, archives, signs and uploads. Signing files are cleaned up afterward. It does not invite testers or submit a public App Store release.
6. After Apple's processing finishes, select the build in TestFlight and enable the intended testers. External testers may require beta review.

The repository must have Actions enabled. Your API key must have sufficient access for the app upload. If you have never created signing materials before, completing this account-specific setup is required before an automatic upload can succeed.

Reference: [GitHub's Apple signing guide](https://docs.github.com/en/actions/how-tos/deploy/deploy-to-third-party-platforms/sign-xcode-applications).

## Automated archive and upload

Once the account, app record and signing are configured, run from this folder in Terminal:

```bash
TEAM_ID="YOURTEAMID" BUNDLE_ID="com.yourname.weekbyweek" bash upload-testflight.sh
```

The script archives, signs using your team and uploads through Xcode to App Store Connect. It generates a time-based build number by default; Xcode can adjust it during upload. It does not submit a public App Store release, add testers, or send invitations. App Store Connect must process the build before it appears in TestFlight. External testing can require Apple's beta review.

For App Store Connect API-key authentication, set `ASC_KEY_PATH`, `ASC_KEY_ID` and `ASC_ISSUER_ID` in the environment. Keep the `.p8` key outside this project. Without these variables, the script uses the account configured in Xcode. Your role must permit signing and uploading builds.

Alternatively, choose Product > Archive, then Distribute App > App Store Connect in Xcode.

## Schedule behavior and assumptions

- Four editable starter events represent classes, study, work, and personal time.
- Days are integers 0–6 (Monday–Sunday); event times are `HH:mm` in 30-minute steps, between 06:00 and 23:00.
- Week keys are local calendar Monday dates. Date arithmetic uses calendar days rather than fixed 24-hour durations.
- Each saved week is independent. “Also update template” changes or deletes the corresponding template event, identified by a stable ID, and affects weeks first visited later. Previously saved weeks remain unchanged.
- Dragging changes only the displayed week. To also update the template, open the moved event, check the checkbox, then save.
- Export/import replaces the full schedule; invalid imports preserve existing data. Import/export works without a server.
- Storage is local to each installation/browser; there is no automatic PC/iPhone synchronization. Transfer using JSON files. Uninstalling the native app or clearing its website data can remove its local schedule.
- No analytics, tracking, account system, backend, third-party SDKs, or network requests are used by the app.
- Native Reduce Motion is respected through CSS `prefers-reduced-motion`.

The `Scheduler/Application.html` file can also be opened directly in a desktop browser. Keep a stable location for browser use and use the same browser profile; file-origin storage behavior is browser-dependent.

## Apple references

- [Upload builds](https://developer.apple.com/help/app-store-connect/manage-builds/upload-builds)
- [Distribute apps in Xcode with cloud signing](https://developer.apple.com/videos/play/wwdc2021/10204/)
- [TestFlight overview](https://developer.apple.com/help/app-store-connect/test-a-beta-version/testflight-overview/)
