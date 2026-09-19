# Evals

A small A/B check that Guard changes what an agent does, using a project with planted defects.

`run-ab.ps1` runs the same neutral prompt (it never mentions Guard) on a copy of `fixtures/lms-api`
twice: once with skills enabled and once with `--disable-slash-commands` (every skill off). `grade.mjs`
then scores the resulting code with static checks and reads the transcript to record whether the
`guard` skill fired, the cost and the turn count.

```powershell
claude plugin install guard@guard
powershell -ExecutionPolicy Bypass -File evals\run-ab.ps1 -Runs 3 -Budget 3
```

Notes:
- Each run is a real agent session billed to your account; `-Budget` caps each one in USD.
- Checks marked `doctrine` are things a default model usually skips and Guard specifically teaches.
- The grader is regex over source files, not a running app, and model output varies between runs — use
  `-Runs 3` or more before drawing conclusions. To prove it on your own project, copy the project twice
  and run the same prompt with and without `--disable-slash-commands`; look for `"name":"Skill"` in
  `--output-format stream-json --verbose` output to confirm the skill was invoked.
- The keys in the fixture are fake and exist only to be found and removed.
