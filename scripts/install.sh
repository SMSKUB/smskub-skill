#!/usr/bin/env bash
# Install the SMSKUB SMS skill into a target AI tool.
# Usage: bash scripts/install.sh <platform>
#   platforms: claude | claude-skill | gemini | codex | cursor | print
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
P="${1:-print}"

case "$P" in
  claude-skill)
    DEST="$HOME/.claude/skills/smskub-sms"
    mkdir -p "$DEST"
    cp "$ROOT/SKILL.md" "$DEST/SKILL.md"
    echo "✓ installed Claude Code skill → $DEST/SKILL.md" ;;
  claude)
    cp "$ROOT/CLAUDE.md" "./CLAUDE.md"
    echo "✓ copied CLAUDE.md to current dir (Claude reads it as project context)" ;;
  gemini)
    cp "$ROOT/GEMINI.md" "./GEMINI.md"
    echo "✓ copied GEMINI.md to current dir" ;;
  codex)
    cp "$ROOT/AGENTS.md" "./AGENTS.md"
    echo "✓ copied AGENTS.md to current dir (Codex/Antigravity/Cline)" ;;
  cursor)
    mkdir -p "./.cursor/rules"
    cp "$ROOT/.cursor/rules/smskub-sms.mdc" "./.cursor/rules/smskub-sms.mdc"
    echo "✓ copied Cursor rule → ./.cursor/rules/smskub-sms.mdc" ;;
  print)
    echo "Paste the contents of SKILL.md into your AI's instructions/system field:"
    echo "  $ROOT/SKILL.md" ;;
  *)
    echo "Unknown platform: $P"
    echo "Use: claude-skill | claude | gemini | codex | cursor | print"
    exit 1 ;;
esac

echo "Next: connect the SMSKUB MCP for live sending — see mcp/SETUP.md (optional)."
