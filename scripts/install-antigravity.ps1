# Installs Guard into Antigravity (agy) through its own plugin installer.
# Usage: powershell -ExecutionPolicy Bypass -File scripts\install-antigravity.ps1
$ErrorActionPreference = 'Stop'
if (-not (Get-Command agy -ErrorAction SilentlyContinue)) { throw 'agy was not found on PATH.' }

$root  = Split-Path -Parent $PSScriptRoot
$stage = Join-Path ([IO.Path]::GetTempPath()) 'guard-antigravity'
if (Test-Path $stage) { Remove-Item -Recurse -Force $stage }
New-Item -ItemType Directory $stage | Out-Null

# agy reads plugin.json at the staging root; contextFileName makes it keep GEMINI.md (the bootstrap).
$manifest = Get-Content (Join-Path $root '.codex-plugin\plugin.json') -Raw | ConvertFrom-Json
$manifest | Add-Member -NotePropertyName contextFileName -NotePropertyValue 'GEMINI.md' -Force
$json = $manifest | ConvertTo-Json -Depth 10
[IO.File]::WriteAllText((Join-Path $stage 'plugin.json'), $json, (New-Object Text.UTF8Encoding($false)))

Copy-Item (Join-Path $root 'skills')    (Join-Path $stage 'skills') -Recurse
Copy-Item (Join-Path $root 'GEMINI.md') (Join-Path $stage 'GEMINI.md')

agy plugin validate $stage
agy plugin install $stage
Write-Host 'Guard installed for Antigravity. Restart agy to load it.'
