#!/usr/bin/env bash
# Installs Guard into Antigravity (agy) through its own plugin installer.
# Usage: bash scripts/install-antigravity.sh
set -euo pipefail
command -v agy >/dev/null || { echo "agy was not found on PATH." >&2; exit 1; }
command -v node >/dev/null || { echo "node is required to write the staged manifest." >&2; exit 1; }

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
STAGE="$(mktemp -d)/guard-antigravity"
mkdir -p "$STAGE"

# agy reads plugin.json at the staging root; contextFileName makes it keep GEMINI.md (the bootstrap).
node -e '
const fs=require("fs"), [src,dst]=process.argv.slice(1);
const m=JSON.parse(fs.readFileSync(src,"utf8")); m.contextFileName="GEMINI.md";
fs.writeFileSync(dst, JSON.stringify(m,null,2));
' "$ROOT/.codex-plugin/plugin.json" "$STAGE/plugin.json"

cp -R "$ROOT/skills" "$STAGE/skills"
cp "$ROOT/GEMINI.md" "$STAGE/GEMINI.md"

agy plugin validate "$STAGE"
agy plugin install "$STAGE"
echo "Guard installed for Antigravity. Restart agy to load it."
