# Security & Authorization

Read when the task touches auth, roles, ownership, tenancy, uploads, payments, secrets, paid content, or
any API that returns or mutates user data.

Priority order inside this module: **broken access control → business logic → injection/XSS → transport
and hardening.** Access control is where real breaches live; scanners find the rest.

---

## 1. Access control (the highest-yield area)

**Object-level authorization (IDOR/BOLA).** For every endpoint that takes an identifier — numeric ID,
UUID, slug, filename, nested resource ID — verify the server checks that *this* actor may act on *this*
object. Test read, update, delete, download, export and custom actions, not only GET.

The correct shape is a scoped query, not a fetch-then-check:

```
BAD   order = Order.find(id);            if (!user.canView(order)) 403
GOOD  order = Order.where(id, tenant_id: user.tenant_id, user_id: user.id).firstOrFail()
```

Scoping at the query layer survives refactors; a forgotten `if` does not.

**Function-level authorization.** Every admin/staff endpoint checks role server-side. Hidden UI is not
permission control. A route that is only reachable "because the link is not shown" is unprotected.

**Privilege escalation.** Can a user set their own `role`, `is_admin`, `tenant_id`, `plan`, `status`,
`price` or `permissions` through a create/update body? That is mass assignment — allowlist the fields
that may be written, never denylist.

**Tenant isolation (SaaS).** Tenant scope must hold in: queries, search, reports, exports, files, cache
keys, queue jobs, notifications, webhooks and analytics. Test `Tenant A → Tenant B` on every one of
those paths, including indirect ones. Never trust a client-supplied tenant ID.

**Information leakage in responses.** Inspect API payloads, not the rendered UI: cost price, margin,
supplier data, internal notes, other users' emails, password hashes, tokens. The UI hiding a field is
not the same as the API not returning it.

---

## 2. Authentication lifecycle

Trace: register → verify → login → session/token → refresh → logout → revoke → password reset → recovery.

- Passwords hashed with Argon2id, bcrypt or scrypt. Never plaintext, reversible encryption, or a fast hash.
- Reset tokens: high entropy, short expiry, single use, invalidated after use; no account enumeration in responses or timing.
- Email change requires verification of the *new* address before it becomes the login identity; notify the old one.
- Sessions: expire, invalidate on logout, rotate on privilege change, survive nothing after password change unless policy says so. Cookies: `HttpOnly`, `Secure`, `SameSite` appropriate to the flow.
- Tokens: verify signature, issuer, audience and expiry — never decode-and-trust. Refresh tokens rotate, revoke on logout and password change, and detect reuse. Do not put sensitive data in a token payload.
- OAuth/SSO: exact `redirect_uri` allowlist, single-use `state` bound to the session, PKCE for public clients, verified ID token signature/issuer/audience/nonce. Account linking must never merge an external identity into an existing password account on matching email alone.
- Rate limit login, registration, reset, OTP and any expensive or message-sending endpoint. Per-user, per-IP, per-tenant as appropriate. Return 429.

---

## 3. Business logic

Generic scanners never find these. Test them deliberately:

- Price, discount, quantity, total and currency supplied by the client → recompute server-side from authoritative data.
- Negative quantity, negative amount, zero-price, overflow values.
- Coupon reuse, expired coupon, stacking beyond policy, coupon on ineligible items.
- Refund greater than paid; double refund; refund after chargeback.
- State transitions out of order — pay after cancel, ship before pay, approve own request, publish without review.
- Subscription: proration on mid-cycle change, dunning and grace period on failed payment, exact access cut-off, what happens to data on downgrade.
- Replay: the same action submitted twice must not create two orders, two payments, two enrolments.

**Concurrency.** Stock decrement, wallet balance, seat allocation, coupon usage, enrolment and payment
capture all need a transaction plus row lock, a unique constraint, or an idempotency key. A read-then-write
without one is a lost-update bug under real traffic.

**Idempotency.** Payment creation, order creation, refunds, webhooks, emails and background jobs must be
safe to retry. A timeout never means the operation did not happen.

**Webhooks.** Verify the signature. Treat every delivery as possibly duplicated and possibly out of
order. Never let an unsigned webhook change payment state. A payment screenshot or user-submitted proof
is a claim, not a confirmation.

---

## 4. Injection & output

- Parameterized queries or ORM bindings everywhere. Raw SQL with string concatenation is a finding even when the input "looks safe".
- NoSQL: reject operator objects (`$ne`, `$gt`) from client input.
- Command execution: never build a shell string from user input; use argument arrays.
- XSS: encode per output context — HTML body, attribute, URL, JavaScript, CSS are different. `dangerouslySetInnerHTML` / `v-html` / `innerHTML` on anything user-supplied needs a sanitizer with an allowlist. Rich-text and admin-entered fields are stored-XSS surfaces too.
- Template injection where templates take user input.
- CSV/Excel export: neutralize values starting with `=`, `+`, `-`, `@`.
- SSRF: any server-side fetch of a user-supplied URL needs protocol allowlist, private-IP and metadata-endpoint blocking, and redirect re-validation after each hop.
- Path traversal: canonicalize, then verify the resolved path is inside the allowed root, then authorize.
- Open redirect: validate redirect targets against an allowlist; never redirect to a raw query parameter.

---

## 5. Files & paid content

- Validate extension, real content type (magic bytes), and size. Never trust the filename or the client MIME type.
- Store outside the web root, or on object storage with private ACLs. Generate a new stored name; keep the original name as metadata only.
- SVG is executable — sanitize it or serve it with a content type that will not execute.
- **Every** protected media request is authorized, not only the page that links to it. Use signed, expiring URLs; no permanently public URL for paid content.
- Revoked purchases and expired subscriptions lose access on the next request — check at request time, not at page render.
- Downloadable PDFs, slides and attachments share the authorization boundary of their course/order.
- Stream identifiers must not be guessable or shareable. Anti-recording measures are deterrents, not guarantees — never claim otherwise.

---

## 5b. Content protection — courses, paid media, private data (layered)

Goal: make theft **hard, traceable and revocable**, and make cross-user data leaks structurally
impossible. No single control is enough; stack these, scaled to how valuable the content is (a free
blog needs none; a paid course library needs most).

**Layer 0 — authorize at request time, everywhere.** Enrollment/subscription/ownership is checked on
the page, the API, the video manifest, every segment/key request, every file download and every export —
not once at render. A UUID in a URL is not authorization. Revoked or expired access stops at the next request.

**Layer 1 — never serve a raw file URL for protected video.**
- Use adaptive streaming (HLS/DASH) with **encrypted segments**; the decryption key is served only by an authorized endpoint, per user/session. For high-value libraries use a managed video host or multi-DRM (Widevine / FairPlay / PlayReady) — DRM is the only layer that also constrains capture on supported players.
- Signed, **short-lived** URLs (minutes) for manifest, segments and files; refresh during playback; bind to the user/session. Do not hard-bind to IP (mobile networks change IPs).
- No public bucket, no directory listing, no predictable paths, hotlinking blocked by signature (a Referer check alone is weak).

**Layer 2 — session and sharing controls.** Cap concurrent sessions/devices per account; list and revoke
sessions; flag account sharing (simultaneous streams, many devices, impossible travel); rate-limit
segment/file requests and alert on a sweep of sequential segments or bulk downloads (scraper signature).

**Layer 3 — deterrence and traceability.** A dynamic, moving on-screen watermark (user id / masked
email, changing position) on video and on rendered PDFs; forensic watermarking only for very
high-value content. Platform capture controls where they exist (Android `FLAG_SECURE`, iOS capture
detection, DRM-enforced black frames) — **state plainly that they are deterrents**. Disabling right-click
or dev tools is theatre; do not rely on it and do not claim it protects anything.

**Layer 4 — documents.** PDFs, slides and attachments stream through an authorized endpoint with a
per-user watermark and short-lived signed URL; they share the course's authorization boundary.

**Layer 5 — data must not cross users or tenants.** Scope in the query, not after the fetch. Check every
side channel: search index (tenant/user filter in the query itself), cache keys, CDN, exports, reports,
notifications, webhooks, background jobs, analytics views, logs (redact PII), error messages, and email
links (signed and expiring). API responses omit fields the role cannot see — hiding in the UI is not enough.

**Layer 6 — detect and respond.** Audit-log access to protected content; alert on anomalies; have a
working way to revoke one user, revoke all tokens, and rotate signing/encryption keys without downtime.

**Public teaser vs paid body.** Public marketing pages may show title, summary, curriculum outline and a
free preview. The paid body never appears in server-rendered HTML, the sitemap, structured data values,
or any crawler-facing response. Do not show crawlers something users cannot get — that is cloaking
(`04-seo.md` §9).

Verify like an attacker: as unauthenticated, as another student, as an expired subscriber, replay an old
signed URL, fetch a segment/key directly, enumerate IDs, hit the download endpoint without the page.

---

## 5c. Also apply when relevant (full text in `deep/ProjectGuard.md`)

- **Privacy** (Appendix A2): data map, consent before non-essential collection, deletion/export, retention, minors get extra scrutiny.
- **Payments** (A3): processor-hosted fields/tokenization, no raw card data anywhere, signed idempotent webhooks, reconciliation of refunds/chargebacks, manual proof is a claim.
- **Supply chain** (A4) and **infrastructure/CI** (A5): scheduled dependency scans, lock files, least-privilege cloud credentials, no publicly listable storage.
- **Race conditions, idempotency, mobile security, offline sync**: §21–§22, §62–§63.
- **Search and import/export leakage**: §60–§61 — search must never return unauthorized records.

---

## 6. Secrets, headers, dependencies

- No secrets in source, git history, logs, error payloads, client bundles or mobile app packages. Anything shipped to a client is public.
- Debug mode off in production; no stack traces to users; source-map exposure is a deliberate decision.
- Headers where applicable: HSTS, `Content-Security-Policy`, `X-Content-Type-Options: nosniff`, `Referrer-Policy`, frame protection, `Permissions-Policy`. Do not stack conflicting policies blindly.
- CORS: explicit origin allowlist; never `*` with credentials; no development origins in production. CORS is not authorization.
- CSRF applies to cookie/session auth on state-changing requests. For pure bearer-token APIs, assess whether it applies before adding machinery.
- Dependencies: lock files committed and honoured in CI; vulnerability scanning on a schedule, not once; review new dependencies for maintenance, licence and supply-chain risk.
- Cloud: object storage not publicly listable unless intended; least-privilege runtime credentials; admin/database services not exposed publicly; CI secrets in the provider's secret store.

---

## 7. AI features (only if the product embeds AI)

- Treat user, file and web content as untrusted model input; prompt injection must not cross a tenant or permission boundary.
- Treat model output as untrusted: sanitize before rendering, and never pass it to shell, SQL, `eval` or a file path.
- Per-user and per-tenant request/token caps to bound cost.
- RAG retrieval respects the same authorization boundary as the source documents.

---

## 8. Audit logging

Record actor, action, target, timestamp, scope and result for: login and security events, permission and
role changes, deletions, financial actions, exports of sensitive data, approvals, and critical
configuration changes. Never store passwords, tokens or secrets in the log. Audit records are not runtime
logs; keep them separate and harder to tamper with.

---

## 9. Reporting a finding

```
ID · Category · Severity · Location (file:line or endpoint)
Attack surface: who can reach it, with what
Evidence: what was actually observed
Exploitable here? yes / no / needs conditions   ← a "no" makes it Informational
Root cause
Fix applied, at which layer
Verification: what was run, and the result
```

Do not invent vulnerabilities to look thorough. Do not mark something confirmed that was not observed.
