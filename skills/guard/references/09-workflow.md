# Workflow — ask in Arabic, propose answers, plan, execute

Read at the **start** of any Build mode task, any `/guard` audit, and whenever a decision is genuinely
the user's. This module governs *when* and *how* to talk to the user. It does not override the
autonomy contract (`SKILL.md` §4): ask few, high-leverage questions at fixed checkpoints, then work
without interruption.

---

## 1. Rules for every question

- **Language:** ask in **Arabic** (simple, direct; the user's dialect if they write in one). Code, identifiers, commands and file paths stay in English. If the user writes in another language, follow theirs.
- **Recon before asking.** Never ask what the codebase, config, README, logo file or an earlier answer already tells you. Ask only what recon cannot answer.
- **Propose, don't interrogate.** Every question carries 2–4 concrete options, the recommended one first and marked `(موصى به)`, each with a one-line consequence. The user can always type something else.
- **Batch.** One `AskUserQuestion` call (1–4 questions) per checkpoint, not one question per message. If the tool is unavailable, send a short numbered list and stop.
- **One decision per question.** No compound questions, no open-ended "what do you want?".
- **Never ask twice.** Record each answer once (top of the work, or `docs/identity.md` for design decisions) and refer to it by ID afterwards; do not restate the spec.
- **No answer = recommended default.** If the user says "كمّل" / "من غير أسئلة", or the run is non-interactive, take the recommended option, log it in one line, and continue.

Token discipline: short questions, short options, no recap of what the user just said, plans as compact
tables, no re-reading of files to "confirm" (`SKILL.md` §3).

---

## 2. Checkpoints (the only times to ask)

```
C0 Intake → C1 Spec sign-off → C2 Plan approval → (execute) → C3 Blockers → C4 Finish
```

**C0 — Intake.** After recon, one batched call for only the unknowns, chosen from:
- Goal / project type, if not obvious. Audience and main conversion.
- Brand: logo, colours, fonts supplied? Otherwise derive from the logo, or pick a restrained default.
- Languages and directions (Arabic/English, RTL/LTR).
- Content sensitivity: any paid, private or per-user content? (drives `02-security.md` §5b)
- Scale/risk tolerance for an audit: fix P0/P1 only, or also P2?
- Execution style (asked at C2, not here).

Example (Arabic, with a suggested answer):

> **السؤال:** المحتوى في المنصة مدفوع أو خاص بكل مستخدم؟
> 1. **أيوه، كورسات مدفوعة (موصى به لو فيه اشتراكات):** هفعّل حماية الفيديو والملفات بروابط موقعة ومشفّرة وحد للأجهزة.
> 2. **جزء بس مدفوع:** هحمي الجزء ده والباقي عام.
> 3. **لا، كله عام:** هتخطى طبقة حماية المحتوى.

**C1 — Spec sign-off (Build mode).** Turn the answers into a spec and show it in **short chunks**
(each ≲ 12 lines): 1) الهدف والمستخدمين · 2) الصفحات/الشاشات والأدوار · 3) البيانات والصلاحيات
والمحتوى المحمي · 4) الهوية البصرية (Identity Lock) · 5) SEO واللغات · 6) الداشبورد. Then **one**
question: موافق على المواصفات؟ — `موافق، كمّل (موصى به)` / `عدّل جزء معين` / `ابدأ من الأول`. If they pick
a chunk, revise only that chunk.

**C2 — Plan approval.** After sign-off, write a plan clear enough for a capable engineer with no context
of this repo: a compact table of **tasks of ~2–5 minutes**, each with exact file paths, what changes, the
verification command, and the expected result. Principles: YAGNI and DRY (they are the Anti-Over gate);
**test-first for logic that must not break** — authorization, payments, pricing, ranking/recommendation
algorithms, data migrations (write the failing test, watch it fail, minimal code, watch it pass); pure UI
and static content are verified by rendering and the responsive/RTL checks instead of forced unit tests.
Then one question:

> **السؤال:** أنفّذ الخطة إزاي؟
> 1. **مباشرة في الجلسة دي (موصى به):** أوفر توكنات وأقدر أعدّل بسرعة.
> 2. **بمساعدين (subagents) لكل مهمة:** أسرع في المشاريع الكبيرة لكن بيستهلك توكنات أكتر (كل مساعد بيبدأ من الصفر).
> 3. **عدّل الخطة الأول.**

Use subagents **only** if the user picks option 2. In that mode: one fresh subagent per independent
task, then review its work for spec compliance first, code quality second, before the next task.
Also ask (same call) whether to work on a **new git branch** (موصى به) or the current one.

**Execute.** Follow the plan without interrupting. Tick tasks off silently. No narration between tool
calls. Do not expand scope: a discovered extra idea goes to the report, not the code.

**C3 — Blockers (only these).** Stop and ask, with options and a recommendation, when: an action is
irreversible and ambiguous (data deletion, destructive migration, force push, DNS/domain change); two
readings lead to materially different products; a credential or account is needed; a finding can only be
confirmed by live exploitation of production; or the plan is provably wrong. Everything else: decide,
log the assumption, continue.

**C4 — Finish.** One-screen report (`00-audit-protocol.md` format; detail in `AUDIT.md`). Then one
question: `اعمل commit (موصى به)` / `اعمل commit وPR` / `سيبه من غير commit`. Never commit, push, open a PR
or publish without that answer.

---

## 3. `/guard` audit checkpoints (autonomous run)

An audit is autonomous, so it asks at only three moments:

1. **C0-lite** — only unknowns that change what is safe to do (may this touch production data? which
   environment has tests? are there paid/private contents?). Skip entirely if recon answers them.
2. **After diagnosis** — one question showing the finding counts by severity:
   > لقيت 2 P0 و5 P1 و9 P2. أصلح إيه؟
   > 1. **P0 وP1 وP2 الرخيصة (موصى به)** 2. **P0 وP1 بس** 3. **تقرير بس من غير تعديل**
3. **C3 blockers** and **C4 finish**, as above.

Between those, it works uninterrupted and reports at the end.

---

## 4. Anti-patterns

Asking a question the code answers · asking one question per message · open-ended questions without
options · asking permission for something a senior engineer would simply do · asking again after the
user said "كمّل" · re-presenting the approved spec · offering five options where two suffice · using
subagents by default · running the plan while a checkpoint is still unanswered.
