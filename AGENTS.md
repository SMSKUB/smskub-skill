# AGENTS.md — SMSKUB SMS Skill (universal loader)

This repository is a **portable AI skill for sending/composing SMS via SMSKUB** (sms-kub.com).

## Instruction to the agent

When the user wants to **send SMS, write an SMS message, pick a Sender Name, check SMS credit,
or run an SMS campaign**, you MUST **read and follow [`SKILL.md`](SKILL.md) in this repository
exactly** — its steps, the mandatory cost-preview + confirmation gate, the character/credit rules,
and the brand guardrails (PDPA/NBTC, never send without consent + confirmation).

- If the **SMSKUB MCP** tools are available (`send_message`, `create_campaign`, `get_balance`,
  `list_senders`, `get_message_status`, …) → operate in **Connected mode** (compose AND send).
  Setup: [`mcp/SETUP.md`](mcp/SETUP.md).
- If they are NOT available → operate in **Compose-only mode**: write the message, count
  characters/credits, advise the Sender Name, and hand the user a ready-to-send package.
  **Do not pretend to send.**

If your tool cannot read sibling files, paste the full contents of `SKILL.md` into your
instructions instead.
