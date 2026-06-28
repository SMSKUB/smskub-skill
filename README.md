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

### 🚀 วิธีติดตั้ง (2 ขั้น)

มีแค่ 2 อย่าง: **(1) ต่อ SMSKUB** ให้ส่ง SMS ได้ · **(2) ใส่สกิล** ให้ AI เขียนเก่ง.

#### ขั้นที่ 1 — ต่อ SMSKUB เข้ากับ AI *(เพื่อให้ส่ง SMS ได้จริง)*
ทำตามเอกสารทีละขั้น 👉 **📄 [วิธีต่อ SMSKUB MCP](mcp/SETUP.md)**
*(ยังไม่ต่อก็ใช้ได้ — AI จะช่วยเขียน SMS ให้พร้อมส่ง แล้วคุณเอาไปวางในระบบเอง)*

#### ขั้นที่ 2 — ใส่ "สกิล" ให้ AI *(ให้เขียน SMS เก่ง คุมเครดิต ปลอดภัย)*
สกิลคือ **ไฟล์ข้อความไฟล์เดียว** ชื่อ [`SKILL.md`](SKILL.md) — แค่ก็อปไปวาง:

1. เปิดไฟล์ **[`SKILL.md`](SKILL.md)** → เลือกทั้งหมด (`Ctrl+A`) → **ก็อป** (`Ctrl+C`)
2. เปิด AI ที่คุณใช้ → หา **ช่องใส่คำสั่ง (Instructions)** → **วาง** (`Ctrl+V`) → บันทึก

   | AI ที่ใช้ | เอาไปวางตรงไหน |
   |---|---|
   | **Claude** (claude.ai) | สร้าง **Project** ใหม่ → ช่อง **Instructions** |
   | **ChatGPT** | สร้าง **GPT** หรือ Project → ช่อง **Instructions** |
   | **Manus / แอปอื่น** | ช่อง **System / Knowledge / คำสั่ง** |

3. เสร็จ! ลองพิมพ์ *"ช่วยเขียน SMS โปรลด 20% หน่อย"* 🎉

> 👨‍💻 ใช้เครื่องมือสาย dev (Claude Code, Gemini CLI, Codex)? → ดู [`INSTALL.md`](INSTALL.md)

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

### 🚀 How to install (2 steps)

Just two things: **(1) connect SMSKUB** so it can send SMS · **(2) add the skill** so the AI writes well.

#### Step 1 — Connect SMSKUB to your AI *(so it can actually send SMS)*
Follow the step-by-step guide 👉 **📄 [Connect the SMSKUB MCP](mcp/SETUP.md)**
*(Skip it and the AI still drafts ready-to-send SMS for you to paste into your system.)*

#### Step 2 — Add the "skill" to your AI *(so it writes great SMS, manages credits, stays safe)*
The skill is **one text file**, [`SKILL.md`](SKILL.md) — just copy & paste it:

1. Open **[`SKILL.md`](SKILL.md)** → select all (`Ctrl+A`) → **copy** (`Ctrl+C`)
2. Open your AI → find the **Instructions** box → **paste** (`Ctrl+V`) → save

   | Your AI | Where to paste |
   |---|---|
   | **Claude** (claude.ai) | Create a **Project** → **Instructions** field |
   | **ChatGPT** | Create a **GPT** or Project → **Instructions** field |
   | **Manus / other apps** | The **System / Knowledge / instructions** box |

3. Done! Try typing *"Write me an SMS for a 20% off promo"* 🎉

> 👨‍💻 Using dev tools (Claude Code, Gemini CLI, Codex)? → see [`INSTALL.md`](INSTALL.md)

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
