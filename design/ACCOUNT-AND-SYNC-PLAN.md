# Website and Apple account sync

Research: October 4, 2026. Proposed architecture; no services provisioned or deployed.

## Current state
The canonical HTML stores schedules locally. The SwiftUI project wraps a bundled copy using WKWebView. Hosting the HTML alone will not synchronize device data. Localhost data also remains separate from a new domain, so migration must preserve existing records.

## Proposed architecture
Website on Cloudflare Pages at app.<chosen-domain>, and the existing Apple app, both use one Supabase Auth project and Postgres database. Each account owns its events, recurring templates, assignments, preferences and completed focus sessions. Active timers need timestamp-based state and a single-session rule across devices.

## Implementation sequence
1. Refactor persistence behind a shared data interface while preserving offline use and JSON export.
2. Create account and per-record tables, ownership policies using auth.uid(), and server-side account deletion. Never embed privileged service keys in either client.
3. Add email sign-in and Sign in with Apple; map both platforms to the same user identity. Account linking must require authenticated proof, not just matching email text.
4. Add queued offline writes, unique operation IDs, record versions and deletion tombstones. Reject conflicting versions and let users resolve meaningful conflicts instead of replacing an entire schedule snapshot.
5. On first sign-in, offer an explicit import of existing local data with a backup and duplicate prevention. Partition local caches by user; clear private cached data on sign-out.
6. Deploy only production web assets, configure HTTPS/domain and auth callback URLs. Keep deployments manual until approved. Never publish fictional preview data as the production app.
7. Integrate native sign-in and secure session storage with the existing webview. Build and sign with a Mac or macOS CI. Review notifications, offline behavior and lifecycle handling on physical Apple devices, then distribute through TestFlight.

## Release considerations
Apple review assesses functionality beyond a repackaged website. The existing wrapper is a starting point, not proof of approval. Include in-app account deletion, a privacy policy, accurate privacy disclosures and review access. Verify Apple Developer Program/App Store Connect team access for signing and uploads; installing TestFlight alone does not provide it.

## Official references
- Static HTML hosting: https://developers.cloudflare.com/pages/framework-guides/deploy-anything/
- Domain setup: https://developers.cloudflare.com/pages/configuration/custom-domains/
- Authentication: https://supabase.com/docs/guides/auth
- Apple login across web/native: https://supabase.com/docs/guides/auth/social-login/auth-apple
- Data isolation: https://supabase.com/docs/guides/database/postgres/row-level-security
- Swift integration: https://supabase.com/docs/guides/getting-started/tutorials/with-swift
- Review requirements: https://developer.apple.com/app-store/review/guidelines/
- Account deletion: https://developer.apple.com/support/offering-account-deletion-in-your-app
- Beta distribution: https://developer.apple.com/testflight/

## Decisions before implementation
Domain name, Apple developer team access, login choices and desired offline behavior. Hosting, domain and backend costs depend on selected plans and usage; no purchases or commitments made.
