# Full Audit Protocol

Read when running `/guard` with no argument, or a scoped `/guard <area>`.
This is an audit of an **existing** project. Never treat it as greenfield. Never rebuild it.

---

## Phase order

Each phase feeds the next. Skipping is allowed only under the stated condition.

| # | Phase | Module | Skip when |
|---|---|---|---|
| 1 | Recon & fingerprint | `01-recon.md` | Never |
| 2 | Route / role / data map | `01-recon.md` | Never |
| 3 | Security & authorization | `02-security.md` | No auth and no user data at all |
| 4 | Performance & data growth | `03-performance.md` | Static site under ~20 pages |
| 5 | SEO & indexability | `04-seo.md` | No public pages (internal tool only) |
| 6 | Design, responsive, a11y | `06-design.md` | Headless / API-only |
| 7 | i18n & RTL | `07-i18n-rtl.md` | Single-language, LTR only |
| 8 | Analytics & recommendations | `05-insight.md` | Not requested and no discovery surface exists |
| 9 | Dashboard / control plane | `08-dashboard.md` | No admin surface |
| 10 | Implement fixes | — | Never |
| 11 | Verify & regression | — | Never |
| 12 | Report | this file | Never |

**Phase 8 gate.** Tracking, analytics and recommendation systems are built **only** when the user asked
for them, or the business model obviously depends on discovery (store, marketplace, LMS catalogue,
content platform). Otherwise: note the opportunity in the report and build nothing.

---

## Severity model

| P | Meaning | Action in an unattended audit |
|---|---|---|
| **P0** | Live exposure or loss — auth bypass, private data public, payment manipulation, whole site deindexed, data-destroying bug | Fix now, fix first |
| **P1** | Seriously exploitable or broken — IDOR on a real endpoint, broken canonical system, unbounded query that will time out, primary flow broken on mobile | Fix in this pass |
| **P2** | Real but bounded — missing indexes, missing metadata, inconsistent components, weak error states | Fix if cheap and safe, else report |
| **P3** | Cosmetic / hardening / nice-to-have | Report only. Never spend time here while P0/P1 exist |

A vulnerability that is theoretically possible but has no reachable path in this codebase is
**Informational**, not P0. Inventing findings to look thorough is a failure mode, not diligence.

---

## Evidence rule

Every finding carries evidence that exists: a file and line, a query plan, a response body, a status
code, a rendered width, a test output. If you did not observe it, it is a **hypothesis** and must be
labelled as one. Never write "tested" for something you did not run. Never write "fixed" for something
you did not execute after changing.

---

## Fix rules

- Smallest correct change, at the layer where the root cause lives.
- Preserve existing public behaviour and API contracts unless changing them **is** the fix.
- Security fixes go server-side, even when a client fix would hide the symptom.
- Database changes go through the project's migration system, never by hand.
- Do not bundle: UI + security + SEO + schema in one commit is a review failure. Group logically.
- Anything shared (Button, Table, layout, theme, auth middleware, base query scope) → identify consumers
  before changing it, and spot-check the riskiest consumer after.

---

## Verification

Run what the project actually has, in this order, stopping to fix on failure:

```
typecheck → lint → unit → integration/feature → build
```

Then, targeted to what changed:
- Auth change → re-test unauthenticated, wrong user, wrong role, wrong tenant.
- Query/index change → re-run the query plan and confirm it improved.
- Public page change → title, canonical, robots state, and that the content is in the server-rendered HTML.
- Shared UI change → smallest supported width, largest, dark mode, RTL, loading, long content.
- Migration → confirm it is reversible, or that a recovery path exists.

Never suppress an error to make a suite pass.

---

## Report format

Chat: **one screen maximum.** Everything below goes into a file (`AUDIT.md`) and is handed over.

```markdown
# Audit — <project> — <date>

## 1. Assessment
<3–6 sentences: what this project is, its real state, the honest headline.>

## 2. Findings
| ID | Sev | Area | Location | Finding | Status |
|----|-----|------|----------|---------|--------|
| S-01 | P0 | Security | api/orders/[id].ts:42 | Any authenticated user can read any order | Fixed & verified |

## 3. Detail (P0 / P1 only)
### S-01 — <title>
- Attack surface / impact:
- Evidence:
- Root cause:
- Fix applied:
- Verification:

## 4. Changed files
| File | Change | Why |

## 5. Dependencies
Added / removed / updated, with the reason. "None" is a good answer.

## 6. Validation run
| Check | Command | Result |

## 7. Predicted risks
Only risks this architecture actually implies, each with a trigger condition.
| Risk | Triggers when | Impact | Mitigation |

## 8. Not done
| Item | Why | Recommendation |
Categories: Accepted (low value) · Needs a decision from you · Needs credentials/environment ·
Unsafe without more requirements · Out of scope.

## 9. Deliberately not added
What this audit refused to build, and why.
```

Section 9 is not optional. It is the proof the audit exercised judgement instead of applying every rule
as a feature.
