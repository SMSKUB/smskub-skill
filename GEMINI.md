# GEMINI.md — SMSKUB SMS Skill

This project carries a portable SMS skill for **SMSKUB** (sms-kub.com).

When the user asks to **send SMS, write an SMS, choose a Sender Name, check SMS credit, or run an
SMS campaign**, read and follow **[`SKILL.md`](SKILL.md)** in this repo exactly — including the
mandatory **cost preview + confirmation before sending**, the Thai/English character→credit rules
(Thai ≤70 = 1 credit), and the PDPA/NBTC guardrails.

- **SMSKUB MCP connected** → Connected mode (compose AND send). See [`mcp/SETUP.md`](mcp/SETUP.md).
  Add the server under `mcpServers` in the Gemini CLI `settings.json`.
- **No MCP** → Compose-only mode: produce a ready-to-send package; never claim it was sent.
