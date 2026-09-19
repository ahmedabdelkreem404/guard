# A/B proof for Guard: same fixture, same neutral prompt, once WITH skills and once WITHOUT
# (--disable-slash-commands turns every skill off). Grades the resulting files with grade.mjs.
#
# Usage:  powershell -ExecutionPolicy Bypass -File evals\run-ab.ps1 [-Runs 3] [-Budget 3]
# Needs: claude CLI logged in, node, the guard plugin installed (claude plugin install guard@guard).
# Cost: each run is a real agent session billed to your account; -Budget caps each one (USD).
param([int]$Runs = 1, [double]$Budget = 3, [int]$MaxTurns = 30)
$ErrorActionPreference = 'Continue'
$root = Split-Path -Parent $PSScriptRoot
$here = $PSScriptRoot
$work = Join-Path ([IO.Path]::GetTempPath()) ("guard-eval-" + (Get-Date -Format 'yyyyMMdd-HHmmss'))
New-Item -ItemType Directory $work | Out-Null

# Neutral prompts: they never mention Guard, so a "with" win proves automatic invocation.
$prompts = @{
  'lms-api'     = 'This is the backend of our online course platform. Review it and fix whatever needs fixing before we go live.'
}

$rows = @()
foreach ($fixture in $prompts.Keys) {
  foreach ($arm in 'with', 'without') {
    for ($i = 1; $i -le $Runs; $i++) {
      $dir = Join-Path $work "$fixture-$arm-$i"
      Copy-Item (Join-Path $here "fixtures\$fixture") $dir -Recurse
      $args = @('-p', $prompts[$fixture], '--permission-mode', 'acceptEdits', '--max-turns', $MaxTurns,
                '--max-budget-usd', $Budget, '--output-format', 'stream-json', '--verbose', '--no-session-persistence')
      if ($arm -eq 'without') { $args += '--disable-slash-commands' }
      Write-Host "[run] $fixture / $arm / $i ..."
      Push-Location $dir
      $out = & claude @args 2> (Join-Path $dir 'stderr.txt')
      [IO.File]::WriteAllLines((Join-Path $dir 'run.jsonl'), [string[]]$out, (New-Object Text.UTF8Encoding($false)))  # not '>' : PS 5.1 would write UTF-16
      Pop-Location
      $json = node (Join-Path $here 'grade.mjs') $fixture $dir (Join-Path $dir 'run.jsonl')
      $r = $json | ConvertFrom-Json
      $r | Add-Member -NotePropertyName arm -NotePropertyValue $arm
      $rows += $r
      Write-Host ("      score {0}/{1} (doctrine {2}/{3}) skills: {4} cost: {5}" -f $r.passed, $r.total, $r.doctrinePassed, $r.doctrineTotal, ($r.skillsFired -join ','), $r.cost)
    }
  }
}

Write-Host "`n=== SUMMARY (mean over $Runs run(s)) ==="
$rows | Group-Object fixture, arm | ForEach-Object {
  $g = $_.Group
  [pscustomobject]@{
    Fixture  = $g[0].fixture
    Arm      = $g[0].arm
    Score    = '{0:N1}/{1}' -f (($g | Measure-Object passed -Average).Average), $g[0].total
    Doctrine = '{0:N1}/{1}' -f (($g | Measure-Object doctrinePassed -Average).Average), $g[0].doctrineTotal
    SkillFired = ($g | Where-Object { $_.skillsFired.Count -gt 0 }).Count.ToString() + "/$($g.Count)"
    CostUSD  = '{0:N2}' -f (($g | Measure-Object cost -Average).Average)
  }
} | Sort-Object Fixture, Arm | Format-Table -AutoSize
$rows | ConvertTo-Json -Depth 5 | Set-Content (Join-Path $work 'results.json')
Write-Host "Results and per-run folders: $work"
