---
name: using-guard
description: Use when starting any conversation, and before responding to any request to build, fix, review, or audit software — including clarifying questions or codebase exploration that would happen before that response. Establishes that the guard skill must be checked and invoked before any other action on engineering work.
---

<SUBAGENT-STOP>
If you were dispatched as a subagent to execute one specific, already-scoped task, ignore this skill and
do the task.
</SUBAGENT-STOP>

<EXTREMELY-IMPORTANT>
If there is even a 1% chance the `guard` skill applies to what you are about to do, you ABSOLUTELY MUST
invoke it first.

IF THE TASK IS ENGINEERING WORK, YOU DO NOT HAVE A CHOICE. YOU MUST USE GUARD.

This is not negotiable. You cannot rationalize your way out of this.
</EXTREMELY-IMPORTANT>

## The rule

**Invoke `guard` BEFORE any response or action** on a request to build, fix, review, or audit
software — before clarifying questions, before exploring the codebase, before reading files to "get
context." If it turns out `guard` doesn't apply, you can stand down; but check first, not after.

Then follow `guard`'s own invocation-mode table (`/guard`, `/guard <area>`, or silent application to an
ordinary build/fix/review request) exactly as it specifies. `guard` itself decides when to narrate and
when to stay silent — this skill only governs whether it gets invoked at all.

## Skill priority

`guard` is the process skill for this plugin: it sets architecture, security, and quality decisions
*before* any implementation skill (a framework-specific skill, a design skill, a testing skill) executes
its part. When several skills could apply, `guard` runs first and the others carry out what it decided.

- "Build me an admin panel for the LMS" → `guard` first (it will pull in its `08-dashboard.md` and
  `02-security.md` references), then any framework/design skill.
- "This page is slow" → `guard` first (`03-performance.md`), then implement.
- "Just answer a question about how X works" → still check `guard`'s description; if the question isn't
  actually build/fix/review/audit work, `guard` correctly does nothing and you answer directly.

## Red flags

These thoughts mean STOP — you're rationalizing your way out of the check:

| Thought | Reality |
|---|---|
| "This is just a quick fix" | Quick fixes are still fixes. Check `guard`. |
| "I need to look at the code first" | `guard`'s recon phase tells you *how* to look. Check first. |
| "This is a simple question about the codebase" | If it's about building/fixing/reviewing, check first. |
| "I already know the security rules" | Rules evolve; the installed version is the current one. |
| "This project is too small for a full audit" | `guard` scales itself down — that's its own job, not yours to pre-decide. |
| "The user just wants one small change" | Scope doesn't exempt the change from authorization/perf/SEO discipline. |
| "I'll just start coding and check later" | The whole point is deciding architecture *before* writing code. |
| "This doesn't count as engineering work" | If it touches app code, config, schema, or infra, it does. |

## Platform adaptation

If your harness exposes a different tool surface than plain file read/write/bash (browser automation,
a different task/todo system, a different way to run tests), use `guard`'s instructions with those tools
substituted — the doctrine in `guard` is tool-agnostic by design.

## User instructions take precedence

CLAUDE.md, AGENTS.md, direct instructions from the person you're working with, and any explicit "skip
this" override this skill and `guard` itself. Only skip the check when the person has explicitly told you
to.
