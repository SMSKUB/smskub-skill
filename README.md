# SMSKUB SMS Skill

พกพา **สกิลส่ง/เขียน SMS ของ SMSKUB** ไปลงกับ AI ตัวไหนก็ได้ — Claude, Gemini, ChatGPT,
OpenAI Codex, Cursor, Manus, Groq, Antigravity หรือ MCP host อะไรก็ตาม. สกิลเดียวทำครบลูป:
**คิดข้อความ → คิด Sender Name → เลือกวิธีส่ง → ยิงผ่าน SMSKUB MCP → เช็คผล** และ
**ไม่ยิงก่อนยืนยันค่าใช้จ่ายเสมอ**.

> SMSKUB (sms-kub.com) — NBTC-licensed SMS gateway สำหรับธุรกิจไทย.

## สกิลนี้ทำอะไร

- ✍️ **เขียน SMS** ให้พอดี ≤70 ตัวไทย / 1 เครดิต (5 micro-formula + Playbook เทมเพลตตามจังหวะธุรกิจ)
- 🔢 **นับตัวอักษร/เครดิต** ไทย 70 = 1 เครดิต, อังกฤษ 160 = 1 เครดิต — เตือนก่อนหลุดเป็น 2 เครดิต
- 🏷️ **คิด/ตรวจ Sender Name** ตามกฎ (≤11 ตัว EN, OTP/Marketing)
- 🚦 **ส่งจริงผ่าน MCP** 3 lane (ส่งด่วน · แคมเปญ/ตั้งเวลา · OTP=v2) — มี **Safety Gate** บังคับ (เช็คเครดิต → cost preview → confirm → ยิง → เช็คสถานะ)

## 2 โหมดการทำงาน

| โหมด | เงื่อนไข | ทำได้ |
|---|---|---|
| **① Connected** | host ต่อ **SMSKUB MCP** ไว้ | เขียน **และส่งจริง** ครบลูป |
| **② Compose-only** | ไม่มี MCP (แชทเปล่า) | เขียน + นับเครดิต + คิด sender แล้วส่งมอบ "ชุดพร้อมส่ง" ให้เอาไปวางใน console เอง (ไม่แกล้งส่ง) |

โหมด Connected ต้องต่อ MCP ก่อน — ดู [`mcp/SETUP.md`](mcp/SETUP.md).

## ติดตั้ง (ย่อ)

เลือกแพลตฟอร์มของคุณ แล้วทำตาม [`INSTALL.md`](INSTALL.md). สรุปเร็ว:

| แพลตฟอร์ม | วิธี | ไฟล์ |
|---|---|---|
| **Claude Code** | วางเป็น skill หรือใช้ `CLAUDE.md` | `~/.claude/skills/smskub-sms/SKILL.md` หรือ [`CLAUDE.md`](CLAUDE.md) |
| **Claude Desktop / Projects** | วาง `SKILL.md` ลง Project instructions | [`SKILL.md`](SKILL.md) |
| **Gemini CLI** | วาง `GEMINI.md` ที่ root โปรเจกต์ | [`GEMINI.md`](GEMINI.md) |
| **OpenAI Codex** | วาง `AGENTS.md` ที่ root | [`AGENTS.md`](AGENTS.md) |
| **Cursor / Crosscode** | กฎโปรเจกต์ | [`.cursor/rules/smskub-sms.mdc`](.cursor/rules/smskub-sms.mdc) |
| **Antigravity / Cline / อื่น ๆ** | universal `AGENTS.md` | [`AGENTS.md`](AGENTS.md) |
| **ChatGPT (Custom GPT)** | วางเนื้อ `SKILL.md` ลงช่อง Instructions | [`SKILL.md`](SKILL.md) |
| **Manus / Groq / แชตทั่วไป** | วางเนื้อ `SKILL.md` เป็น system/knowledge | [`SKILL.md`](SKILL.md) |

หรือใช้สคริปต์ช่วยคัดลอก:
```bash
# macOS/Linux
bash scripts/install.sh claude     # หรือ gemini | codex | cursor
```
```powershell
# Windows
pwsh scripts/install.ps1 claude    # หรือ gemini | codex | cursor
```

## โครง repo

```
smskub-skill/
├── SKILL.md            # ★ ต้นฉบับสกิล (source of truth) — ทุก adapter ชี้มาที่นี่
├── README.md           # ไฟล์นี้
├── INSTALL.md          # วิธีติดตั้งรายแพลตฟอร์มแบบละเอียด
├── AGENTS.md           # universal loader (Codex/Cursor/Antigravity/Cline/…)
├── GEMINI.md           # Gemini CLI loader
├── CLAUDE.md           # Claude loader
├── .cursor/rules/smskub-sms.mdc
├── mcp/SETUP.md        # วิธีต่อ SMSKUB MCP + config template
├── scripts/            # install.sh · install.ps1
└── LICENSE
```

## หลักการ "ต้นฉบับเดียว"

`SKILL.md` คือแหล่งความจริงเดียว. ไฟล์ adapter (`AGENTS.md`, `GEMINI.md`, `CLAUDE.md`, กฎ Cursor)
เป็นแค่ **ตัวโหลดบาง ๆ** ที่สั่งให้ AI อ่านและทำตาม `SKILL.md`. แก้สกิลที่ `SKILL.md` ที่เดียวพอ.
แพลตฟอร์มที่อ่านไฟล์ข้างเคียงไม่ได้ (ChatGPT/Manus/Groq) ให้ **วางเนื้อ `SKILL.md` ทั้งไฟล์** แทน.

## License

MIT — ดู [`LICENSE`](LICENSE). (ปรับเป็น license อื่นได้ตามต้องการ)
