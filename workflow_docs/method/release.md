# Release and watch

Part of [the method](../method.md). Snapshot of the "Release" tab of the Claude Doc ["Building apps with Claude: the method"](https://claude.ai/artifact/CNNN4eUxaLSfQh2ohtNAP4), revision 1, taken on 2026-11-17 (see [DEC-5](../decisions.md#dec-5)).

Step 11: getting a merged feature to users, then learning from real use. Merging is not releasing. A feature is deployed with its flag off, released to a growing share of users while someone watches, and only then is it done. Read this part when preparing a release or investigating a problem in production. Checks that run before this point are in [Verification](verification.md).

Two things make release matter more for this app than for a website. App store review means a fix cannot reach phones in minutes, so a feature flag is the only fast way back. And old app versions stay installed for months, so the server must keep serving them.

## Deploy: installed, not yet exposed

| Practice | Applies to | What it means here |
| --- | --- | --- |
| Integration tests | App and server | The app against a real server, in a staging environment |
| Config tests | App and server | Build, signing and environment settings checked for each platform and each server environment |
| Beta channels | Apps | TestFlight, Play internal testing and a desktop beta channel; every release candidate goes there first |
| Shadowing | Server | The new server version receives a copy of real traffic; its answers are thrown away |
| Tap compare | Server | The shadow's answers are compared with the current version's; any difference is explained before release |
| Load and soak tests | Server | See [Verification](verification.md); they run against staging before each server release |

## Release: exposed gradually, reversible

| Practice | Applies to | What it means here |
| --- | --- | --- |
| Feature flags | App and server | One flag per registry feature, named after its ID (`F-012`). New features ship with their flag off and are turned on gradually |
| Staged rollout | Apps | App Store phased release and Play staged rollout: a new version reaches a growing percentage of users, and can be paused |
| Canary | Server | A new server version runs on a small share of servers first, compared with the rest on errors and latency |
| Traffic shaping | Server | A chosen share of users or regions is routed to the new version |
| Exception tracking | App and server | Crashes and errors grouped by version and by feature |
| Release gates | App and server | Error rate, latency and crash-free rate are watched at each step; a step that crosses its threshold stops the rollout |

## Post-release: learning from real use

| Practice | What it means here |
| --- | --- |
| Logs and events | Named after feature and criterion IDs, e.g. `F-012.coupon_applied`, so a crash or a drop in use traces back to the registry |
| Tracing | One request followed from the app through the server, tagged with its feature ID |
| Real user monitoring | Start time, screen load time, crashes and freezes on real devices |
| Profiling | Where time and memory go under real load, on the server and in `.hot.ts` code |
| A/B tests | Only when a decision (`D`) needs data; the decision records the result |
| Chaos testing | Server: instances killed, a slow database, a network cut. App: offline and flaky network. Run on staging first |
| Auditing | Who did what, for the sensitive actions the threat model names |
| On-call | Every alert reaches a person and links to the feature it concerns and what to check first |

## Rules

- Claude never releases, turns a flag up or starts a rollout on its own: it prepares the step, and you decide.
- A problem found in production becomes a backlog task citing the feature and the rule or criterion it broke. If the description was wrong, "[When the design changes](build.md#when-the-design-changes)" in [Build the app](build.md) applies.
- A bug that reached users gets a test before its fix ships, and a proof block or a TLA+ rule if it fits.
- The server supports a stated range of app versions; dropping the oldest one is a decision (`D`).
- Once a feature is fully released, its flag is removed. A flag kept on purpose is written in the workarounds log.

## Pitfalls

| Pitfall | Why it hurts | Instead |
| --- | --- | --- |
| Releasing to everyone at once | One bad build reaches every user, and on phones the fix waits for store review | Flag off by default, staged rollout, release gates |
| Events and logs without IDs | A crash cannot be traced to a feature or a rule | Event names start with the feature ID |
| Flags that never go away | Every old flag doubles the paths to test | Remove the flag once the feature is fully released |
