# guard

A senior-engineer doctrine, packaged as a Claude Code plugin: security & authorization, performance,
SEO/indexability, responsive design & accessibility, Arabic/English RTL, search/recommendation
intelligence, and admin-dashboard rules — enforced automatically, not offered as a suggestion.

Modeled on the enforcement mechanism in [obra/superpowers](https://github.com/obra/superpowers): a
small `using-guard` skill makes invocation mandatory, and `guard` itself loads only the reference
modules a given task actually touches, instead of paying the full doctrine's token cost on every turn.

---

## اقرأ هنا أولاً (Arabic quick-start)

**إيه ده؟** بلجن لـ Claude Code فيه سكيلين:
- **`using-guard`** — سكيل صغير شغلته الوحيدة إنه يجبر الإيجنت يستدعي `guard` قبل أي رد على طلب بناء/تعديل/مراجعة/فحص — مش اقتراح، قاعدة إلزامية، بنفس أسلوب `using-superpowers` في مشروع superpowers.
- **`guard`** — العقيدة نفسها: أمان وتفويض، أداء، SEO، تصميم متجاوب وهوية بصرية، عربي/إنجليزي RTL، تريكينج وتوصيات، ولوحة تحكم — كل ده كـ router صغير (`SKILL.md`) + 8 موديولز (`references/`) بيتحملوا حسب المهمة بس، مش كلهم مع بعض.

**التركيب:**
1. اعمل ريبو على GitHub وارفع الفولدر ده فيه (تعليمات تحت في "Publish this repo").
2. جوه Claude Code:
   ```
   /plugin marketplace add YOUR_GITHUB_USERNAME/guard
   /plugin install guard@guard
   ```
3. من هنا، أي طلب بناء أو فحص أو تعديل — الإيجنت هيستدعي `guard` تلقائي من غير ما تكتب حاجة زيادة. تقدر كمان تكتب `/guard` لفحص كامل للمشروع، أو `/guard security` / `/guard seo` / `/guard rtl` ... لفحص مجال واحد بس.

**تركيب سريع من غير مارکت‌بليس (لمشروع واحد بس):** انسخ فولدر `skills/guard` و `skills/using-guard` جوه `.claude/skills/` بتاعة المشروع، من غير ما تحتاج تعمل ريبو أو مارکت‌بليس خالص.

---

## What's inside

```
guard/
├── .claude-plugin/
│   ├── plugin.json          # plugin identity
│   └── marketplace.json     # lets this repo self-host its own marketplace
├── skills/
│   ├── using-guard/
│   │   └── SKILL.md         # the enforcer: makes invocation mandatory
│   └── guard/
│       ├── SKILL.md         # router: precedence ladder, anti-over-engineering gate,
│       │                    #   non-negotiables, always loaded
│       └── references/
│           ├── 00-audit-protocol.md   # full/scoped audit phases, severity, report format
│           ├── 01-recon.md            # stack fingerprint, route/role/data mapping
│           ├── 02-security.md         # auth, IDOR, tenancy, payments, uploads, secrets
│           ├── 03-performance.md      # N+1, indexes, bundle size, capacity, Flutter jank
│           ├── 04-seo.md              # crawlability, canonicals, structured data
│           ├── 05-insight.md          # tracking, ranking, recommendations (opt-in)
│           ├── 06-design.md           # tokens, responsive (watch → 4K), motion, a11y
│           ├── 07-i18n-rtl.md         # Arabic/English, RTL/LTR, mixed-direction text
│           └── 08-dashboard.md        # admin panel as control plane
└── README.md
```

`guard/SKILL.md` loads on every relevant task; a task loads at most 1–2 reference modules on top of
that, never the whole doctrine at once. That's the same token discipline superpowers gets from splitting
`writing-skills`, `test-driven-development`, `systematic-debugging`, etc. into separate files instead of
one giant prompt.

## Why a separate `using-guard`

`guard` describes *what a senior engineer decides*. `using-guard` enforces *that the agent actually
checks*. Splitting these two concerns is the core trick that makes superpowers-style skills reliable:
a skill's own description competing for attention against "just start coding" loses most of the time
unless something makes the check itself mandatory. `using-guard`'s description matches "starting any
conversation," so it's the first thing evaluated, and its body leaves no room to rationalize skipping
the check — see its Red Flags table.

## How invocation works, end to end

1. A request comes in that could be engineering work.
2. `using-guard` fires (its description matches "before any build/fix/review/audit response") and
   states the rule: check `guard` before doing anything else.
3. `guard`'s own invocation-mode table decides what happens next:
   - `/guard` alone → full autonomous audit (`references/00-audit-protocol.md`).
   - `/guard <area>` → one reference module, scoped fix.
   - An ordinary build/fix/review request → the precedence ladder and non-negotiables apply silently,
     and whichever reference modules the task actually touches (at most two) get loaded.
   - Plain conversation → nothing happens; `guard` and `using-guard` both stand down.
4. `guard` runs its own loop — recon → map → diagnose → decide → implement → verify → report — governed
   by the Anti-Over gate (§7) so it doesn't add architecture, dependencies, or dashboards the project
   doesn't need.

## Publish this repo

```bash
cd guard
git init
git add -A
git commit -m "Initial guard plugin"
gh repo create YOUR_GITHUB_USERNAME/guard --public --source=. --remote=origin --push
# or, without gh:
git remote add origin https://github.com/YOUR_GITHUB_USERNAME/guard.git
git branch -M main
git push -u origin main
```

Then replace `YOUR_GITHUB_USERNAME` in `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`,
and this README with your real GitHub username, commit, and push again.

## Updating

Edit `skills/guard/references/*.md` (or `SKILL.md` itself) directly, bump `version` in
`.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`, commit, and push. Anyone who already
ran `/plugin install guard@guard` picks up the update on their next `/plugin marketplace update` (or
automatically, depending on their Claude Code version).

## License

MIT — see `LICENSE`.
