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

### ⚡ ติดตั้งใน 2 นาที (ไม่ต้องใช้ terminal)

**① ต่อ SMSKUB เข้ากับ AI** — เพื่อให้ส่ง SMS ได้จริง
เอา API Token (Console → Settings → API Token) มาใส่ใน URL นี้:
```
https://smskubmcp.com/mcp?token=YOUR_API_TOKEN
```
แล้ววางในเมนู connector ของแอป:
- **Claude (เว็บ/มือถือ/Desktop):** Settings → Connectors → *Add custom connector* → วาง URL
- **Manus AI:** Add MCP server → วาง URL

**② ใส่ "สมอง" ให้ AI เขียน SMS เก่ง** — แนะนำ (ไม่บังคับ)
เปิด [`SKILL.md`](SKILL.md) → ก็อปทั้งไฟล์ → วางในช่อง **Project / Custom Instructions** ของ AI.

**✅ ทดสอบ:** พิมพ์ *"เช็คเครดิต SMS ให้หน่อย"* — ถ้าได้ยอดคงเหลือ = พร้อมใช้! 🎉

> 🛠️ แพลตฟอร์มอื่น (Gemini, ChatGPT, Codex, Claude Code…) + วิธีละเอียด → [`INSTALL.md`](INSTALL.md)
> · วิธีต่อ MCP แบบอื่น (npx) → [`mcp/SETUP.md`](mcp/SETUP.md) · License: **MIT** ([`LICENSE`](LICENSE))

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

### ⚡ Install in 2 minutes (no terminal)

**① Connect SMSKUB to your AI** — so it can actually send SMS
Take your API Token (Console → Settings → API Token) and put it in this URL:
```
https://smskubmcp.com/mcp?token=YOUR_API_TOKEN
```
Then paste it into your app's connector menu:
- **Claude (web/mobile/Desktop):** Settings → Connectors → *Add custom connector* → paste the URL
- **Manus AI:** Add MCP server → paste the URL

**② Give your AI the "brain" to write great SMS** — recommended (optional)
Open [`SKILL.md`](SKILL.md) → copy the whole file → paste it into your AI's **Project / Custom Instructions**.

**✅ Test:** type *"What's my SMS credit balance?"* — if it returns a balance, you're live! 🎉

> 🛠️ Other platforms (Gemini, ChatGPT, Codex, Claude Code…) & detailed steps → [`INSTALL.md`](INSTALL.md)
> · other ways to connect the MCP (npx) → [`mcp/SETUP.md`](mcp/SETUP.md) · License: **MIT** ([`LICENSE`](LICENSE))

---

## Repo layout

```
smskub-skill/
├── SKILL.md            # ★ source of truth — every adapter points here
├── README.md           # this file (TH + EN)
├── INSTALL.md          # detailed per-platform install
├── AGENTS.md           # universal loader (Codex/Antigravity/Cline/…)
├── GEMINI.md           # Gemini CLI loader
├── CLAUDE.md           # Claude loader
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
