# SMSKUB SMS Skill

> **TH** — พกพา *สกิลเขียน & ส่ง SMS ของ SMSKUB* ไปลงกับ AI ตัวไหนก็ได้
> **EN** — A portable AI skill to *compose & send SMS via SMSKUB*, installable on any AI assistant

**🌐 อ่านภาษา / Language:** [🇹🇭 ภาษาไทย](#-ภาษาไทย) · [🇬🇧 English](#-english)

---

## 🇹🇭 ภาษาไทย

### เกี่ยวกับ SMSKUB

**SMSKUB** ([sms-kub.com](https://sms-kub.com) — บริษัท เอสเอ็มเอส คับ จำกัด) คือ
**SMS Gateway ครบวงจรสำหรับธุรกิจไทย** ที่ได้รับใบอนุญาตจาก **NBTC** ส่งข้อความถึงจริง พร้อม support 24/7.

**ทำไมต้อง SMSKUB**
- 📲 **ครบจบที่เดียว** — Marketing SMS · OTP · SMS API · Tracking · Analytics · LBS
- 🔗 **เชื่อมต่อ automation ได้ลึก** — **n8n** (official node), **Make**, **Zapier** และ **SMSKUB MCP** (สั่งส่ง SMS ผ่าน AI ได้)
- ✅ **น่าเชื่อถือ** — NBTC-licensed · open rate 98% · อ่านภายใน 3 นาที 90%
- 🕐 **บริการ 24/7** — ทีม support ไม่มีวันหยุด

> repo นี้คือ **สกิล AI อย่างเป็นทางการของ SMSKUB** — ให้ AI ช่วยเขียนข้อความ คิด Sender Name และส่ง SMS จริงผ่าน SMSKUB MCP.

### สกิลนี้ทำอะไร

- ✍️ **เขียน SMS** ให้พอดี ≤70 ตัวไทย / 1 เครดิต (5 micro-formula + Playbook เทมเพลตตามจังหวะธุรกิจ)
- 🔢 **นับตัวอักษร/เครดิต** ไทย 70 = 1 เครดิต, อังกฤษ 160 = 1 เครดิต — เตือนก่อนหลุดเป็น 2 เครดิต
- 🏷️ **คิด/ตรวจ Sender Name** ตามกฎ (≤11 ตัว EN, OTP/Marketing)
- 🚦 **ส่งจริงผ่าน MCP** 3 lane (ส่งด่วน · แคมเปญ/ตั้งเวลา · OTP=v2) — มี **Safety Gate** บังคับ (เช็คเครดิต → cost preview → confirm → ยิง → เช็คสถานะ)

### 2 โหมดการทำงาน

| โหมด | เงื่อนไข | ทำได้ |
|---|---|---|
| **① Connected** | host ต่อ **SMSKUB MCP** ไว้ | เขียน **และส่งจริง** ครบลูป |
| **② Compose-only** | ไม่มี MCP (แชทเปล่า) | เขียน + นับเครดิต + คิด sender แล้วส่งมอบ "ชุดพร้อมส่ง" (ไม่แกล้งส่ง) |

ต่อ MCP เพื่อส่งจริง — ดู [`mcp/SETUP.md`](mcp/SETUP.md).

### ติดตั้ง

เลือกแพลตฟอร์มแล้วทำตาม [`INSTALL.md`](INSTALL.md) — สรุปเร็ว:

| แพลตฟอร์ม | ไฟล์ |
|---|---|
| **Claude Code** | วาง skill ที่ `~/.claude/skills/smskub-sms/SKILL.md` หรือใช้ [`CLAUDE.md`](CLAUDE.md) |
| **Claude Desktop / Projects** | วางเนื้อ [`SKILL.md`](SKILL.md) ลง Instructions |
| **Gemini CLI** | [`GEMINI.md`](GEMINI.md) |
| **OpenAI Codex** | [`AGENTS.md`](AGENTS.md) |
| **Cursor / Crosscode** | [`.cursor/rules/smskub-sms.mdc`](.cursor/rules/smskub-sms.mdc) |
| **Antigravity / Cline / อื่น ๆ** | [`AGENTS.md`](AGENTS.md) |
| **ChatGPT / Manus / Groq** | วางเนื้อ [`SKILL.md`](SKILL.md) ลงช่อง Instructions/system |

หรือใช้สคริปต์: `bash scripts/install.sh claude` · `pwsh scripts/install.ps1 claude` (รองรับ `claude|gemini|codex|cursor`)

### โครง repo · License
ดู [โครงไฟล์](#repo-layout) ด้านล่าง · License: **MIT** ([`LICENSE`](LICENSE))

---

## 🇬🇧 English

### About SMSKUB

**SMSKUB** ([sms-kub.com](https://sms-kub.com)) is an **all-in-one, NBTC-licensed SMS Gateway built for
Thai businesses** — reliable delivery with round-the-clock support.

**Why SMSKUB**
- 📲 **All-in-one** — Marketing SMS · OTP · SMS API · Tracking · Analytics · LBS
- 🔗 **Deep automation** — official **n8n** node, **Make**, **Zapier**, and the **SMSKUB MCP** (send SMS straight from your AI)
- ✅ **Trusted** — NBTC-licensed · 98% open rate · 90% read within 3 minutes
- 🕐 **24/7 support** — a team that never sleeps

> This repo is **SMSKUB's official AI skill** — let any AI compose messages, suggest a Sender Name, and send real SMS through the SMSKUB MCP.

### What this skill does

- ✍️ **Writes SMS** that fit ≤70 Thai chars / 1 credit (5 micro-formulas + a business-moment template playbook)
- 🔢 **Counts characters/credits** (Thai 70 = 1 credit, English 160 = 1 credit) and warns before you spill into a 2nd credit
- 🏷️ **Suggests/validates the Sender Name** (≤11 EN chars, OTP vs Marketing)
- 🚦 **Sends for real via MCP** across 3 lanes (quick-send · campaign/scheduled · OTP=v2) with a mandatory **safety gate** — balance → cost preview → confirm → fire → status

### Two modes

| Mode | When | What it does |
|---|---|---|
| **① Connected** | The **SMSKUB MCP** is connected | Compose **and actually send** — full loop |
| **② Compose-only** | No MCP (plain chat) | Compose + count credits + advise sender, then output a ready-to-send package (never pretends to send) |

Connect the MCP to send for real — see [`mcp/SETUP.md`](mcp/SETUP.md).

### Install

Pick your platform and follow [`INSTALL.md`](INSTALL.md). Quick map:

| Platform | File |
|---|---|
| **Claude Code** | drop the skill at `~/.claude/skills/smskub-sms/SKILL.md`, or use [`CLAUDE.md`](CLAUDE.md) |
| **Claude Desktop / Projects** | paste [`SKILL.md`](SKILL.md) into Instructions |
| **Gemini CLI** | [`GEMINI.md`](GEMINI.md) |
| **OpenAI Codex** | [`AGENTS.md`](AGENTS.md) |
| **Cursor / Crosscode** | [`.cursor/rules/smskub-sms.mdc`](.cursor/rules/smskub-sms.mdc) |
| **Antigravity / Cline / others** | [`AGENTS.md`](AGENTS.md) |
| **ChatGPT / Manus / Groq** | paste [`SKILL.md`](SKILL.md) into the Instructions/system field |

Or use the scripts: `bash scripts/install.sh claude` · `pwsh scripts/install.ps1 claude` (supports `claude|gemini|codex|cursor`).

---

## Repo layout

```
smskub-skill/
├── SKILL.md            # ★ source of truth — every adapter points here
├── README.md           # this file (TH + EN)
├── INSTALL.md          # detailed per-platform install
├── AGENTS.md           # universal loader (Codex/Cursor/Antigravity/Cline/…)
├── GEMINI.md           # Gemini CLI loader
├── CLAUDE.md           # Claude loader
├── .cursor/rules/smskub-sms.mdc
├── mcp/SETUP.md        # connect the SMSKUB MCP (+ config templates)
├── scripts/            # install.sh · install.ps1
└── LICENSE
```

**Single source of truth:** edit the skill in `SKILL.md` only. The adapter files are thin loaders that
tell the AI to read & follow `SKILL.md`. Platforms that can't read sibling files → paste the whole `SKILL.md`.

## License

MIT — see [`LICENSE`](LICENSE).

---

*Built by SMSKUB · [sms-kub.com](https://sms-kub.com) · install on any AI — see [`INSTALL.md`](INSTALL.md)*
