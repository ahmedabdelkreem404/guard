# Performance, Data Growth & Capacity

Read when something is slow, when a list or table can grow, or when adding a query, an index, a cache or
a heavy UI surface.

**Measure before optimizing.** An optimization without a measured bottleneck is over-engineering with
extra steps. Optimize the biggest measured cost, one change at a time, and measure again.

---

## 1. Database — the usual root cause

**N+1 queries.** Look for a loop that queries, a serializer that lazy-loads a relation, a component that
fetches per row, and nested resource resolvers. Fix with eager loading or a batched query — not a cache
over a bad query.

**Indexes.** Add an index for a column that is actually filtered, joined, sorted or made unique on, at
real cardinality. Composite index column order follows the query: equality columns first, then range,
then sort. Do not index everything; every index costs write throughput and storage.

**Query plans.** Confirm a fix with the plan (`EXPLAIN ANALYZE` or the ORM's equivalent), not by feel.
Look for sequential scans on large tables, sorts without an index, and joins with exploding cardinality.

**Query hygiene.** No `SELECT *` on wide tables across a join. No unbounded `IN` lists. No counting an
entire large table on every page load — cache or approximate it. No aggregation over full history on a
request path; pre-aggregate.

**Integrity is also performance.** Foreign keys, unique constraints and correct nullability prevent the
data corruption whose cleanup queries become the slow ones.

---

## 2. API

- Every collection endpoint paginates, with a **default** page size and an enforced **maximum**. Cursor pagination once offsets get deep.
- Response shape is purpose-built. Do not serialize the full model graph because the ORM makes it easy.
- Measure p95 and p99, never the average — the average hides the failures users actually notice.
- Bound payload size, request body size, upload size, and export row count.
- Timeouts on every outbound call, with retries that are bounded, backed off and idempotent.
- Cache only what is correct to cache. **Cache keys must include every dimension that changes the response** — user, tenant, role, locale, currency, feature flags. A personalized response in a shared cache is a security bug, not a performance bug.

---

## 3. Frontend (web)

- Ship less JavaScript before optimizing what ships. Check the bundle first: duplicated libraries, a whole icon pack imported for four icons, moment/lodash-style full imports, unused polyfills.
- Route-level code splitting; lazy-load heavy, below-the-fold or rarely used modules (charts, editors, maps, media libraries).
- Images: correct dimensions, `srcset`, modern formats, compression, explicit width/height to prevent layout shift, lazy loading below the fold — and **eager, high priority for the LCP image**.
- Fonts: subset, preload the one used above the fold, `font-display: swap`, and a metric-compatible fallback to limit reflow.
- Long lists: virtualize only when the list is genuinely long (hundreds+) and profiling shows a cost.
- Re-renders: fix the cause (unstable references, context carrying too much, state placed too high) rather than sprinkling memoization.
- Avoid request waterfalls: fetch in parallel; do not chain one request on the render of the previous one.
- Third-party scripts are the most common cause of a slow page. Audit each one for weight, blocking behaviour, duplication and failure mode.

**Web Vitals** — LCP (the real element, its request chain, server response), INP (long tasks, heavy
handlers, hydration cost), CLS (missing dimensions, late-injected content, font swap). Optimize the real
user experience on the pages that matter, not a synthetic score.

---

## 4. Mobile / Flutter

- Cold start, warm start and screen transition are the metrics that decide perceived quality.
- Profile in **release/profile mode**; debug-mode timings are meaningless.
- Build methods do no work: no allocation, no I/O, no sorting, no layout maths inside `build`.
- Long lists use a builder with lazy construction, stable keys, and a fixed extent where possible; `const` constructors wherever the widget is constant.
- Avoid rebuilding a large subtree for a small state change — push state to the smallest widget that needs it.
- Expensive work goes off the UI thread; heavy decode/parse work goes to an isolate.
- Images: resolution-appropriate decode, caching, and a bounded cache size.
- Test on a low-end device and a poor network, not only the simulator. Handle offline start, request failure, network switch, resume from background, and termination mid-request without corrupting local state.

---

## 5. Background work & queues

Retry with backoff, a timeout, a dead-letter path, and idempotent handlers. Watch queue depth as a
first-class metric; an unbounded queue is an outage waiting for traffic. Never blindly retry a
non-idempotent operation. Notification or email failure must not corrupt the primary business
transaction.

---

## 6. Capacity thinking (no destructive testing)

Predict rather than hammer production:

1. Which endpoint is hit most per user action?
2. Which query grows linearly with the largest table?
3. What happens at 10× current rows — which query stops being sub-second?
4. What is the first resource to exhaust — connections, memory, disk, queue, third-party rate limit?
5. What is the failure mode when it exhausts — degrade, error, or corrupt?

Safe load testing against a staging environment is fine. Destructive stress testing against production is
not, unless explicitly authorized and controlled.

---

## 7. Growth bounds checklist

Every one of these needs a deliberate bound — pagination, retention, cleanup, aggregation or a cap:

```
events · logs · audit records · notifications · sessions · messages · uploads
search history · recently viewed · webhook deliveries · job records · cart items
export rows · cache entries · client-side stores
```

Unbounded growth is a P1 finding before it is an incident.
