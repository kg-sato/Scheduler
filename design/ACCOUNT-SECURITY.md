# Local accounts and SQL sync

## Implemented

- Loopback-only Python account server, explicit Host allowlist, no firewall changes.
- SQLite users, sessions and workspace tables. Parameterized queries scope every workspace operation to the authenticated user ID.
- scrypt passwords (N=131072, r=8, p=1) with per-user 32-byte random salts. Passwords are not stored or logged in plaintext.
- Random 256-bit session tokens; only SHA-256 token hashes are stored. HttpOnly/SameSite=Strict cookies expire after 12 hours, rotate at login, and are revoked on logout.
- Same-origin checks and JSON-only requests; authenticated writes require a session-bound CSRF token.
- Sign-in/registration rate limit, bounded password work, request timeouts, 2 MB payload cap.
- CSP with hashes for inline application scripts, same-origin external scripts, frame denial, no-referrer and restricted browser permissions. Style inline allowance remains required by the existing UI.
- Explicit upload/download; SQL revision comparison rejects stale writes. Account data does not automatically replace a device workspace at login.
- Account downloads pass the existing full client-side import validation and preserve one pre-load local backup, downloadable from the account dialog. Server validation currently enforces payload size and top-level workspace structure; detailed event validation remains client-side.
- Private database outside the repository at `%LOCALAPPDATA%/Scheduler/server/accounts.sqlite3`. Database/key files are ignored by Git. The HTTP file allowlist cannot serve the database or repository source.

## Operating instructions

1. Run `npm run dev` and open http://127.0.0.1:8003/Application.html.
2. Profile > Account & sync > Create account. Use a unique username and a passphrase of at least 15 characters.
3. Confirm the destination replacement and choose Save device to account or Load account to device.
4. Sign out to revoke the browser session. The local schedule remains in that browser, as the dialog explicitly states.

This first version provides manual snapshot sync, not automatic merging or live collaboration. A conflict requires reviewing/loading the newer account copy before saving again. Different accounts are isolated in SQL; the device workspace is deliberately independent of account login. Local schedule data remains readable by people with access to that browser profile.

## Deployment boundaries / remaining work

This is local development infrastructure, not a production security certification. The account server cannot bind to a LAN/public interface. HTTP is used only on loopback; cookies need Secure and HTTPS before any network deployment. Do not reverse-proxy this development server into public access.

Before phone/cloud access: choose managed HTTPS hosting and production application server; use verified origins and Secure cookies; extend schema validation; add password reset and verified recovery, account deletion, durable/shared abuse protection, session/device management, backups and retention controls, and security review. Consider managed authentication/passkeys rather than maintaining production password infrastructure. SQLite is unencrypted at rest; protect the Windows account/disk and backups. No email identity verification, MFA, end-to-end encryption or native Apple account integration is claimed.

No automated security or functional test suite was run for this change. Source formatting/build are separate from deployment readiness. Restart after HTML rebuilds to refresh CSP hashes.

## Primary guidance

- https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html
- https://cheatsheetseries.owasp.org/cheatsheets/Session_Management_Cheat_Sheet.html
- https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html
