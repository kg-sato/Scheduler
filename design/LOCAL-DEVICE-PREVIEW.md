# Local hosting - updated security boundary

Run `npm run dev` from the Scheduler folder for accounts and SQLite sync.
Open http://127.0.0.1:8003/Application.html, then Profile > Account & sync.

The account server binds exclusively to 127.0.0.1. The earlier LAN listener was stopped. Firewall settings remain unchanged. Phones cannot connect to this loopback address; HTTPS hosting or a separately approved private-network setup is required first.

`npm run dev:lan` is retained for compatibility but now starts a **loopback-only static preview** without accounts. Do not run both on port 8003. Stop an interactive server with Ctrl+C. Restart the account server after rebuilding HTML because its Content Security Policy hashes are computed at startup.

The real application and fictional preview remain separate. Opening a server URL does not automatically copy schedules from a file URL or another origin: use the existing export/import tools once to migrate your local schedule. Data is never automatically uploaded at sign-in.

See ACCOUNT-SECURITY.md for implementation boundaries and the deployment backlog.
