# Dashboard — Admin Control Plane

Read when building or auditing an admin panel, CMS, permissions UI, content/media/SEO/payment control
surface, reporting, or system-health/audit view.

**The dashboard is a control plane, not a code editor.** Administrators configure business outcomes
through structured controls. Normal workflows never require HTML, CSS, JS, SQL, raw JSON, or a hex color
input. A highly restricted technical-admin capability may exist only if explicitly required and
separately authorized — it is never the default workflow.

---

## 1. Scope discovery — build only what's needed

Possible modules: Overview · Users · Roles & Permissions · Tenants · Content/Pages/Sections · Products ·
Orders · Payments · Subscriptions · Languages/Translations · Media · SEO · Navigation · Notifications ·
Analytics · Search · Recommendations · Reports · System Health · Logs · Audit Log · Maintenance · Error
Pages · Backups · Feature Flags · Integrations · Settings.

A small site needs Overview + Pages + Media + SEO + Settings. A multi-tenant ERP needs most of the list.
Run the Anti-Over gate (`SKILL.md` §7) on every module before building it — "who reads/uses this" applies
directly to dashboards and metrics.

---

## 2. Authorization (this reuses `02-security.md`, never reinvents it)

```
Authenticated identity → server-side authorization → allowed operation → THEN UI visibility
```

Hidden buttons are not authorization. Every mutation and read endpoint the dashboard calls gets the same
IDOR/tenant-isolation/RBAC scrutiny as any other API — see `02-security.md` §1. Business-sensitive fields
(cost price, margin, internal notes) must be excluded from the API response for unauthorized roles, not
just hidden in the UI.

**Dangerous actions** — tenant deletion, permanent data deletion, backup restore, payment config, domain
changes, secret rotation, maintenance mode, destructive migrations — get proportional friction:
confirmation, explicit impact statement ("Affected tenants: 4 · Affected users: 612" — only if the count
is real, never invented), and an audit record. Not every setting needs this; apply friction proportional
to actual risk.

**Least privilege by default**: a new role or new admin user starts with minimal/no permissions unless
the product explicitly has a template mechanism.

---

## 3. View / Edit / Delete pattern

For every manageable entity, show only the actions the current administrator's permissions actually
allow. Prefer reversible lifecycle operations (archive → restore) over hard delete where the business
allows it. Before deleting something referenced elsewhere (a role with assigned users, a language with
content, a media asset used on a live page), show the impact and require confirmation or reassignment.

**Historical integrity**: dashboard actions never silently rewrite historical facts — past invoice
prices, completed order totals, past payment methods. Use snapshots/versioned references, not live joins
to current config, when displaying historical records.

---

## 4. Large data, tables, bulk actions

Every list gets pagination with a max page size, server-side filtering/sorting, and (for genuinely large
data) virtualization. Never load an unbounded dataset into the browser because the API technically can
return it. Bulk actions show an accurate affected count before executing (when the system can compute
it) and verify selection scope, tenant scope, and permissions before running.

---

## 5. Languages, translations, content — structured, never code

Translation fields expand dynamically to match enabled languages; an editor fills in text per language,
never JSON. Show translation completeness per entity ("Arabic ✓ · English ✓ · French !") so gaps are
findable. Disabling a language should not destroy its stored translations — prefer disable over delete.
See `07-i18n-rtl.md` for the runtime rendering side.

Content sections (hero, features, testimonials, etc.) use structured fields (title, subtitle, CTA,
media, order, visibility) — never raw HTML/CSS/JS fields for normal editing. Ordering is drag-and-drop or
move-up/move-down, never a manually typed position number.

---

## 6. Media

Upload / replace / remove / safe URL entry, with preview, progress, and clear error states. Before
deleting a referenced asset, warn and identify where it's used if practically possible. Remote media URL
fetching goes through the same SSRF controls as any other server-side fetch (`02-security.md` §4).

---

## 7. SEO controls — structured fields, generated output

Expose title, description, slug, canonical strategy, robots state, OG fields, and structured-data source
fields as plain inputs. The application generates the actual meta tags / JSON-LD — never ask an
ordinary administrator to hand-write markup or schema JSON. Never invent reviews, ratings, prices, or
identifiers to fill a schema field. Full detail in `04-seo.md`.

---

## 8. Payments — only if payments exist

Online provider config: never display stored secrets after saving (mask them); webhooks are
signature-verified (`02-security.md` §3); refunds are permission-controlled. Offline/manual methods
(bank transfer, mobile wallet, etc.) only when the business flow genuinely supports them, with a clear
workflow: submitted proof → pending → authorized review → approve/reject → status update. **A payment
proof is a claim, not confirmation** — duplicate-proof submissions must not create duplicate payment
records. Disabling a method affects future transactions only; historical records stay accurate.

---

## 9. Health, logs, audit — three distinct things

- **Health**: current dependency status (db, cache, queue, storage, email, payment provider) — healthy/degraded/unavailable, reusing existing monitoring rather than building a second one.
- **Logs**: operational, filterable, paginated, never millions of rows dumped to a browser; secrets/PII masked.
- **Audit**: accountability trail for high-impact actions specifically — actor, action, target, timestamp, scope, result. Separate from runtime logs; secrets never appear here either.

---

## 10. Printing

Print real structured data — never a screenshot scaled to paper. Invoices, receipts, reports, and
certificates get an actual print layout with real text. If the product supports thermal/80mm printers,
give that a dedicated layout sized for the real paper width, not a shrunk desktop page.

---

## 11. Maintenance & production safety

Maintenance mode should be scoped to what's actually independent in the architecture — do not claim a
module is unaffected if it shares infrastructure with what's down. Before any production-impacting
setting change: identify affected users/tenants/data/integrations, confirm a rollback or recovery path,
apply, then monitor and verify. New/breaking dashboard features that touch the schema go through the
project's migration system with backward-compatible rollout where the architecture supports it — never a
hand-edited database change.

---

## 12. Visual & responsive — inherits, never forks

The dashboard uses the exact same design tokens, components and responsive rules as the rest of the
product (`06-design.md`) — no second visual identity. Same width matrix (320px through 4K), same RTL/LTR
handling (`07-i18n-rtl.md`), same accessibility bar. Sidebar collapses to a drawer/rail/bottom nav on
small screens; tables get a real mobile strategy; no accidental horizontal overflow.

---

## 13. Cross-module handoff

A dashboard change that touches permissions → apply `02-security.md`. Touches public content/routing/
metadata → apply `04-seo.md`. Touches recommendations/tracking/search ranking → apply `05-insight.md`.
Touches shared UI/theme/responsive → apply `06-design.md`. A change is not exempt from these just because
it lives under `/admin`.

---

## 14. Definition of done

Authorized operators can control the areas the product actually needs; every action is
permission-checked server-side; View/Edit/Delete are permission-aware; dangerous actions are
proportionally protected and audited; large lists are bounded; languages/translations work without code;
media is manageable without code; SEO is configurable without markup; payments (if present) are secure
and historically accurate; printing produces real data; the dashboard is responsive, accessible, and
visually identical in system to the rest of the product; and no module exists that nobody will act on.
