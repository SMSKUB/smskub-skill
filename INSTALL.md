# INSTALL — ติดตั้ง SMSKUB SMS Skill บน AI ทุกตัว

สกิลนี้เป็น **ไฟล์ instruction (markdown)** + การต่อ **SMSKUB MCP** (ออปชัน). หลักการเดียวกันทุกที่:

1. **ทำให้ AI อ่าน `SKILL.md`** — ผ่านไฟล์ adapter (ถ้า host อ่านไฟล์ข้างเคียงได้) หรือ **วางเนื้อ `SKILL.md` ทั้งไฟล์** ลงช่อง instruction/system.
2. **(อยากส่งจริง) ต่อ SMSKUB MCP** — ดู [`mcp/SETUP.md`](mcp/SETUP.md). ไม่ต่อก็ยังใช้ได้ในโหมด Compose-only.

---

## Claude Code (CLI)

**แบบ A — เป็น skill (แนะนำ):**
```bash
mkdir -p ~/.claude/skills/smskub-sms
cp SKILL.md ~/.claude/skills/smskub-sms/SKILL.md
```
แล้วเรียกใช้ผ่าน Skill / พิมพ์งานที่ตรง trigger ใน frontmatter ได้เลย.

**แบบ B — เป็น context ของโปรเจกต์:** ก็อป [`CLAUDE.md`](CLAUDE.md) ไปไว้ root โปรเจกต์.

ต่อ MCP: เพิ่ม server ใน `~/.claude.json` หรือ `claude mcp add` — ดู `mcp/SETUP.md`.

## Claude Desktop / claude.ai Projects

ไม่มีไฟล์ระบบ → เปิด Project → **Instructions / Custom Instructions** → **วางเนื้อ `SKILL.md` ทั้งไฟล์**.
ต่อ MCP ผ่าน Connectors ของ Claude Desktop (ดู `mcp/SETUP.md`).

## Gemini CLI

วาง [`GEMINI.md`](GEMINI.md) ไว้ root โปรเจกต์ (Gemini โหลด `GEMINI.md` อัตโนมัติ).
หรือก็อปไปที่ global context ก็ได้. ต่อ MCP ผ่าน `settings.json` ของ Gemini CLI (`mcpServers`).

## OpenAI Codex (CLI / cloud)

วาง [`AGENTS.md`](AGENTS.md) ไว้ root repo. Codex อ่าน `AGENTS.md` เป็น instruction อัตโนมัติ.
ต่อ MCP ผ่าน `~/.codex/config.toml` ส่วน `[mcp_servers]` — ดู `mcp/SETUP.md`.

## Antigravity / Cline / Roo / Windsurf และ agent อื่น ๆ

ส่วนใหญ่อ่านมาตรฐาน **`AGENTS.md`** — ก็อป [`AGENTS.md`](AGENTS.md) ไว้ root repo.
ถ้าตัวไหนใช้ไฟล์ชื่อเฉพาะ (เช่น `.clinerules`, `.windsurfrules`) ให้ก็อปเนื้อ `AGENTS.md`/`SKILL.md` ไปใส่ไฟล์นั้น.
ต่อ MCP ตามที่ host รองรับ (`mcp/SETUP.md`).

## ChatGPT (Custom GPT / Projects)

1. สร้าง Custom GPT → **Configure → Instructions** → **วางเนื้อ `SKILL.md` ทั้งไฟล์**.
2. (อยากส่งจริง) เพิ่ม SMSKUB เป็น **Action** ผ่าน REST API ของ SMSKUB หรือเชื่อม MCP connector ถ้าบัญชีรองรับ.
   ถ้าไม่ได้ → ใช้โหมด Compose-only (GPT เขียนชุดพร้อมส่งให้ เอาไปวาง console).

## Manus / Groq / แชต LLM ทั่วไป

วางเนื้อ `SKILL.md` ลง **system prompt / knowledge / instruction** ของ agent.
ถ้า host นั้นต่อ tool/MCP ของ SMSKUB ได้ → ทำงานโหมด Connected; ถ้าไม่ → Compose-only.

---

## ตรวจว่าใช้ได้

ลองพิมพ์: **"ส่ง SMS หา 0811111111 บอกโปรลด 20%"**
- ถ้าต่อ MCP ไว้ → AI ควรเขียนข้อความ + นับเครดิต + เช็ค `get_balance` + โชว์ cost preview + **ถามยืนยันก่อนส่ง**.
- ถ้าไม่ต่อ → AI ควรบอกว่าเป็นโหมด Compose-only แล้วส่งมอบชุดพร้อมส่ง (ข้อความ + sender + เบอร์ + เครดิตประเมิน).

## ปัญหาที่พบบ่อย

| อาการ | แก้ |
|---|---|
| AI ไม่ทำตามสกิล | ยืนยันว่า adapter อยู่ถูก path / instruction ถูกวางจริง; บางตัวต้อง restart session |
| ส่งไม่ได้ บอกไม่มี tool | MCP ยังไม่ต่อ — ดู `mcp/SETUP.md`; ระหว่างนั้นใช้ Compose-only |
| ข้อความตก 2 เครดิตเอง | มีตัวอักษรไทย/อิโมจิ → โหมด 70 ตัว; ตัดให้ ≤70 |
| Sender ใช้ไม่ได้ | ต้องเป็นชื่อที่ **อนุมัติแล้ว** (≤11 ตัว EN) จาก console SMSKUB |
