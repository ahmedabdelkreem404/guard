# Guard

Guard is a senior-engineer doctrine for your coding agent, packaged as a plugin for Claude Code, Codex, Antigravity and other coding agents: security and authorization, performance, SEO, responsive design and accessibility, Arabic/English RTL, search and recommendation logic, and admin-dashboard rules. It is built on a small set of composable skills and an instruction that makes sure your agent uses them.

## Table of Contents

- [How it works](#how-it-works)
- [Installation](#installation)
  - [Claude Code](#claude-code)
  - [Antigravity](#antigravity)
  - [Codex App](#codex-app)
  - [Codex CLI](#codex-cli)
  - [Cursor](#cursor)
  - [Devin CLI](#devin-cli)
  - [Factory Droid](#factory-droid)
  - [Gemini CLI](#gemini-cli)
  - [GitHub Copilot CLI](#github-copilot-cli)
  - [Kimi Code](#kimi-code)
  - [OpenCode, Pi, Hermes Agent](#opencode-pi-hermes-agent)
  - [Any other tool that reads SKILL.md folders](#any-other-tool-that-reads-skillmd-folders)
- [The Basic Workflow](#the-basic-workflow)
- [What's Inside](#whats-inside)
- [Philosophy](#philosophy)
- [Arabic quick-start](#arabic-quick-start)
- [Contributing](#contributing)
- [Updating](#updating)
- [License](#license)

## How it works

It starts from the moment you open a session. As soon as your agent sees a request to build, fix, review, or audit software, it *doesn't* just start writing code. A small `using-guard` skill makes it check `guard` first, before clarifying questions, before exploring the codebase, before anything.

For a new build it then steps back and asks what you are really trying to do, but only what the codebase cannot answer, in Arabic, with a suggested answer for each question. It turns your answers into a spec shown in chunks short enough to read, and after you sign off it writes a plan of small tasks (2-5 minutes each, exact files, exact verification), test-first where a bug would hurt (authorization, payments, ranking logic). Once you say go, it executes without interruption, inline by default to save tokens, or with one subagent per task if you choose that. An audit (`/guard`) asks at only three points: what recon cannot answer, which severities to fix, and real blockers.

`guard` then decides what kind of request this is. A bare `/guard` runs a full autonomous audit of the project. `/guard security` (or `seo`, `perf`, `design`, `rtl`, `dashboard`, `insight`) audits and fixes one area. An ordinary build or fix request gets the doctrine applied silently: a precedence ladder that settles conflicts (security beats privacy beats correctness beats accessibility beats SEO beats performance beats polish), a set of non-negotiables, and only the reference modules the task actually touches, never more than two at once.

Every change goes through the same loop: recon, map, diagnose, decide, implement, verify, report. The decide step is gated by an Anti-Over check, so the agent doesn't add architecture, dependencies, or dashboards your project doesn't need. And nothing is reported as fixed, tested, or verified unless it was actually executed.

Because the check is mandatory rather than suggested, you don't need to do anything special. Your coding agent just has Guard.

## Installation

Installation differs by tool. **Pick the one you use and run only its commands** — each command installs
Guard for that tool only. The per-tool manifests in this repository (`.codex-plugin/`, `.cursor-plugin/`,
`.kimi-plugin/`, and so on) install nothing by themselves; each tool reads only its own. If you use more
than one tool, install Guard separately for each.

Status per tool: **tested** = installed and checked on a real machine; **not tested** = the manifest
follows the reference layout used by other multi-tool skill packs, but the install was not run.

### Claude Code

Status: tested.

```bash
/plugin marketplace add ahmedabdelkreem404/guard
/plugin install guard@guard
```

From a terminal instead: `claude plugin marketplace add ahmedabdelkreem404/guard`, then
`claude plugin install guard@guard`. Check with `claude plugin list`.

### Antigravity

Status: tested.

```bash
git clone https://github.com/ahmedabdelkreem404/guard
cd guard
powershell -ExecutionPolicy Bypass -File scripts/install-antigravity.ps1   # Windows
bash scripts/install-antigravity.sh                                        # macOS / Linux
```

The script stages the manifest and skills and runs `agy plugin install`. Restart `agy` afterwards.

### Codex App

Status: marketplace registration tested; the plugin install itself is done in the app.

- Register the marketplace once (from a terminal): `codex plugin marketplace add ahmedabdelkreem404/guard`
- In the Codex app, click **Plugins** in the sidebar, find **Guard**, click **+** and follow the prompts.

### Codex CLI

Status: marketplace registration tested; the plugin install itself is done in the CLI.

```bash
codex plugin marketplace add ahmedabdelkreem404/guard
```

Then open the plugin search interface with `/plugins`, search for `guard`, and select **Install Plugin**.

### Cursor

Status: not tested.

`.cursor-plugin/plugin.json` is included. Install it through Cursor's plugin marketplace or
local-plugin mechanism.

### Devin CLI

Status: not tested.

```bash
devin plugins install ahmedabdelkreem404/guard
```

### Factory Droid

Status: not tested. Droid reads the Claude Code plugin format (`.claude-plugin/`).

```bash
droid plugin marketplace add https://github.com/ahmedabdelkreem404/guard
droid plugin install guard@guard
```

### Gemini CLI

Status: not tested.

```bash
gemini extensions install https://github.com/ahmedabdelkreem404/guard
```

### GitHub Copilot CLI

Status: not tested. Copilot reads the Claude Code marketplace format (`.claude-plugin/`).

```bash
copilot plugin marketplace add ahmedabdelkreem404/guard
copilot plugin install guard@guard
```

### Kimi Code

Status: not tested.

```text
/plugins install https://github.com/ahmedabdelkreem404/guard
```

### OpenCode, Pi, Hermes Agent

Not supported yet: they need a small JavaScript or Python extension that this repository does not have.

### Any other tool that reads `SKILL.md` folders

No marketplace needed. Copy `skills/guard` and `skills/using-guard` into that tool's skills folder (for
Claude Code: `.claude/skills/` inside a project, or `~/.claude/skills/` for every project).

## The Basic Workflow

1. **using-guard** - Fires first, on session start and before any build/fix/review/audit response. Its red-flags table shuts down the usual reasons for skipping the check ("it's just a quick fix", "I need to look at the code first"). Hands off to `guard`.

2. **Invocation mode** - `guard` reads the request: full audit (`/guard`), scoped audit (`/guard <area>`), ordinary build/fix/review work, or plain conversation, in which case it stands down.

3. **Recon and map** - Stack, rendering model, auth strategy, data layer. Routes by public/private, roles by resources by actions, critical flows end to end, anything that grows unbounded. Never assumes; checks.

4. **Diagnose** - Findings with evidence and severity P0-P3. A theoretical vulnerability with no reachable path in this codebase is Informational, not P0.

5. **Decide** - The Anti-Over gate: is the problem real and present, can the existing architecture solve it, is there a simpler version, what does it cost to maintain, who reads the output? Any "no" means it doesn't get added.

6. **Implement** - Smallest correct change at the layer where the root cause lives. Behaviour preserved, no unrelated refactors, server-side for anything security-relevant.

7. **Verify and report** - Runs the project's own typecheck, lint, tests, and build, and re-runs the original reproduction. Each item is labelled `Confirmed`, `Fixed & verified`, `Fixed, not verifiable here`, `Hypothesis`, or `Not tested`.

**The agent checks for the doctrine before any engineering task.** Mandatory workflow, not a suggestion.

## What's Inside

```
guard/
├── .claude-plugin/          # Claude Code (also read by Droid and Copilot CLI)
│   ├── plugin.json          # plugin identity
│   └── marketplace.json     # lets this repo host its own marketplace
├── .codex-plugin/           # Codex manifest
├── .agents/plugins/         # Codex marketplace manifest
├── .cursor-plugin/  .kimi-plugin/  .devin-plugin/   # one small manifest each
├── gemini-extension.json + GEMINI.md                # Gemini CLI
├── scripts/install-antigravity.{ps1,sh}             # Antigravity installer
├── skills/
│   ├── using-guard/
│   │   └── SKILL.md         # the enforcer: makes the check mandatory
│   └── guard/
│       ├── SKILL.md         # router: invocation modes, precedence ladder,
│       │                    #   token discipline, Anti-Over gate, non-negotiables
│       ├── references/      # dense modules, loaded on demand (max two per phase)
│       │   ├── 00-audit-protocol.md
│       │   ├── 01-recon.md
│       │   ├── 02-security.md
│       │   ├── 03-performance.md
│       │   ├── 04-seo.md
│       │   ├── 05-insight.md
│       │   ├── 06-design.md
│       │   ├── 07-i18n-rtl.md
│       │   ├── 08-dashboard.md
│       │   └── 09-workflow.md      # Arabic questions, spec/plan/execute checkpoints
│       └── deep/            # the five full source skills, searched by section number
│           ├── ProjectGuard.md      # 76 sections + appendices A1-A10
│           ├── SEOGuard.md          # 100 sections
│           ├── InsightGuard.md      # 260 sections
│           ├── DesignGuard.md       # 246 sections
│           ├── DashboardGuard.md    # 207 sections
│           └── run-audit-prompt.md  # the original 20-phase audit prompt
├── LICENSE
└── README.md
```

### Skills Library

**Enforcement**
- **using-guard** - Makes invoking `guard` mandatory before any build/fix/review/audit response

**Doctrine**
- **guard** - The router: always-on rules plus a module map that loads references on demand

### Reference Modules

Loaded only when the task touches them, at most two per phase of work.

- **00-audit-protocol** - Full and scoped audit phases, severity, report format
- **01-recon** - Stack fingerprint, route/role/data mapping for an unfamiliar codebase
- **02-security** - Auth, roles, IDOR, tenancy, uploads, payments, secrets, paid-content leakage, API hardening
- **03-performance** - N+1, indexes, bundle size, large lists, caching, capacity, Flutter jank
- **04-seo** - Crawlability, canonicals, sitemap, structured data, SSR/SSG choice, subdomains
- **05-insight** - Tracking, events, search intelligence, recommendations, ranking (opt-in)
- **06-design** - Tokens, components, motion, responsive from watch to 4K, accessibility
- **07-i18n-rtl** - Arabic/English, RTL/LTR, mixed-direction text, fonts, numbers, dates
- **08-dashboard** - Admin panel as a control plane: permissions, content, media, payments, audit log

## Philosophy

- **Decide, implement, verify, report** - A senior engineer decides; approval is for the irreversible and the ambiguous
- **Server-side or it doesn't count** - Hidden UI is not permission control; client input is untrusted
- **Less is more** - No dependency, layer, or dashboard nobody will use
- **Evidence over claims** - Never say fixed, tested, or verified unless it was executed
- **Token discipline** - One router always loaded, modules on demand, no re-reading files

## Arabic quick-start

**إيه ده؟** بلجن لـ Claude Code فيه سكيلين:

- **`using-guard`** - بيجبر الإيجنت يستدعي `guard` قبل أي رد على طلب بناء أو تعديل أو مراجعة أو فحص. قاعدة إلزامية مش اقتراح.
- **`guard`** - العقيدة نفسها: أمان وتفويض، أداء، SEO، تصميم متجاوب، عربي/إنجليزي RTL، توصيات، ولوحة تحكم. router صغير (`SKILL.md`) + 8 موديولز في `references/` بتتحمل حسب المهمة بس.

**التركيب:**

```
/plugin marketplace add ahmedabdelkreem404/guard
/plugin install guard@guard
```

بعد كده أي طلب بناء أو فحص هيستدعي `guard` تلقائي. اكتب `/guard` لفحص كامل، أو `/guard security` / `/guard seo` / `/guard rtl` لفحص مجال واحد.

## Contributing

1. Fork the repository
2. Create a branch for your work
3. Keep `skills/guard/SKILL.md` a router: rules that apply to every task stay there, everything else goes in a `references/` module
4. Bump `version` in `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json` for any behaviour change
5. Submit a PR describing which task types the change affects

Issues: https://github.com/ahmedabdelkreem404/guard/issues

## Updating

Edit `skills/guard/references/*.md` (or `SKILL.md`), bump `version` in `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`, commit, and push. Anyone who already ran `/plugin install guard@guard` picks up the update on their next `/plugin marketplace update`, or automatically depending on their Claude Code version.

## License

MIT License - see LICENSE file for details
