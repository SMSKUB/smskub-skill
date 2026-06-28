# Install the SMSKUB SMS skill into a target AI tool.
# Usage: pwsh scripts/install.ps1 <platform>
#   platforms: claude | claude-skill | gemini | codex | cursor | print
param([string]$Platform = "print")

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot

switch ($Platform) {
  "claude-skill" {
    $dest = Join-Path $HOME ".claude/skills/smskub-sms"
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    Copy-Item "$Root/SKILL.md" "$dest/SKILL.md" -Force
    Write-Host "OK installed Claude Code skill -> $dest/SKILL.md"
  }
  "claude"  { Copy-Item "$Root/CLAUDE.md"  "./CLAUDE.md"  -Force; Write-Host "OK copied CLAUDE.md" }
  "gemini"  { Copy-Item "$Root/GEMINI.md"  "./GEMINI.md"  -Force; Write-Host "OK copied GEMINI.md" }
  "codex"   { Copy-Item "$Root/AGENTS.md"  "./AGENTS.md"  -Force; Write-Host "OK copied AGENTS.md" }
  "cursor"  {
    New-Item -ItemType Directory -Force -Path "./.cursor/rules" | Out-Null
    Copy-Item "$Root/.cursor/rules/smskub-sms.mdc" "./.cursor/rules/smskub-sms.mdc" -Force
    Write-Host "OK copied Cursor rule -> ./.cursor/rules/smskub-sms.mdc"
  }
  "print"   { Write-Host "Paste the contents of SKILL.md into your AI's instructions field: $Root/SKILL.md" }
  default   {
    Write-Host "Unknown platform: $Platform"
    Write-Host "Use: claude-skill | claude | gemini | codex | cursor | print"
    exit 1
  }
}

Write-Host "Next: connect the SMSKUB MCP for live sending — see mcp/SETUP.md (optional)."
