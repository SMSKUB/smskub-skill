# CLAUDE.md — SMSKUB SMS Skill

This repository carries a portable SMS skill for **SMSKUB** (sms-kub.com).

When the user wants to **send SMS, write an SMS message, pick a Sender Name, check SMS credit, or
run an SMS campaign**, read and follow **[`SKILL.md`](SKILL.md)** exactly — its step sequence, the
**mandatory cost preview + confirmation gate before any send**, the character→credit rules
(Thai ≤70 = 1 credit; any Thai char forces the 70-char mode), and the PDPA/NBTC brand guardrails.

- **SMSKUB MCP connected** (`send_message`, `create_campaign`, `get_balance`, `list_senders`,
  `get_message_status`, …) → **Connected mode** (compose AND send). Setup: [`mcp/SETUP.md`](mcp/SETUP.md).
- **No MCP** → **Compose-only mode**: compose, count credits, advise Sender Name, output a
  ready-to-send package. Do not pretend to send.

> Tip: For Claude Code you can also install this as a first-class skill:
> `cp SKILL.md ~/.claude/skills/smskub-sms/SKILL.md`
