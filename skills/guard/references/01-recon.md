# Recon & Mapping

Read on first contact with a codebase. Goal: enough understanding to make correct decisions, using the
fewest possible reads. Stop as soon as the map is good enough to act on.

---

## 1. Fingerprint the stack (cheap reads only)

Read manifests first, never source files:

```
package.json · pubspec.yaml · composer.json · requirements.txt · go.mod · Gemfile
tsconfig.json · next.config.* · vite.config.* · nuxt.config.* · angular.json
.env.example · docker-compose.yml · Dockerfile · Procfile · vercel.json · netlify.toml
prisma/schema.prisma · migrations/ · database/migrations/ · schema.sql
README.md · CLAUDE.md · AGENTS.md · CONTRIBUTING.md
```

From these, settle:
- Framework and major version; runtime; package manager.
- **Rendering model** — SSR, SSG, ISR, CSR, server-rendered templates, native. This decides everything about SEO and caching.
- ORM / query layer / database engine.
- Auth strategy — session cookie, JWT, OAuth/SSO, framework-native, third-party provider.
- Multi-tenancy model, if any — column-scoped, schema-per-tenant, database-per-tenant, none.
- File/media storage — local disk, S3-compatible, CDN, signed URLs.
- Deployment target and whether infrastructure is under project control.
- What already exists: tests, CI, linting, logging, error tracking, analytics, caching, queues, i18n, a design system.

Write the fingerprint down once. Never re-derive it later in the session.

---

## 2. Route map

List routes with `Glob` over the routing convention, not by reading files:

```
app/**/page.* · pages/**/* · src/routes/** · routes/*.php · **/urls.py · lib/**/screens/**
app/api/**/route.* · pages/api/** · routes/api.php · **/controllers/**
```

For each route record only: **path · public or private · what it renders · what it mutates.**

The one output that matters: **the public/private boundary.** Anything that renders user-specific or
paid content but is reachable without auth is a P0 candidate.

---

## 3. Role × resource × action matrix

Find the authorization vocabulary:

```
grep -r "role|permission|can(|authorize|policy|guard|middleware|ability|@PreAuthorize|is_admin"
```

Build the matrix for the resources that actually matter (usually 5–15, not all of them):

| Resource | Guest | User | Owner | Staff | Admin |
|---|---|---|---|---|---|
| Order | — | own | own | read all | all |

Expected outcomes must be explicit: allowed → correct result; authenticated but forbidden → 403;
unauthenticated → 401; nonexistent → 404 without leaking existence.

Note where authorization lives. If it lives in more than one place (middleware *and* controller *and*
component), that inconsistency is itself a finding.

---

## 4. Critical flow trace

Trace 2–4 flows end to end — client → API → service → database → response → UI. Never review files in
isolation; bugs live in the seams.

Typical flows by product type:
- E-commerce: browse → product → cart → checkout → payment → webhook → order state.
- LMS: enrol → course → lesson/video → progress → assessment → certificate.
- SaaS: signup → workspace → invite → core action → billing/limit → export.
- ERP: login → record → transaction → approval → report.

For each flow note: where authorization is enforced, where money or state changes, what happens on
retry/timeout, and what is cached.

---

## 5. Growth map

For every table and collection, ask: **what grows without a bound?**

Usual suspects: events, logs, notifications, sessions, audit records, messages, uploads, cart items,
search history, webhook deliveries, job records, recently-viewed lists.

For each: is there pagination, a max page size, retention, cleanup, or aggregation? Missing bounds are
P1/P2 findings *before* they are incidents.

---

## 6. Stop condition

Recon is done when you can answer, without more reading:
1. What is this product and what is its rendering model?
2. Which routes are public and which are private?
3. Where is authorization enforced, and is it consistent?
4. Where does money or irreversible state change?
5. What grows unbounded?
6. What does the project already have, so nothing gets rebuilt?

If three targeted searches fail to answer one of these, state the assumption in the report and continue.
Do not crawl the repo.
