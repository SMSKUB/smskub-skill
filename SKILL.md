---
name: smskub-sms
description: Use when the user wants to SEND SMS through SMSKUB and/or write the SMS message itself — pick the send lane (one number / many numbers / scheduled), compose a ≤70-char Thai message that fits a 1–2 credit budget, choose a compliant Sender Name, preview the cost, confirm, then fire and check delivery. Thai/English triggers — "ส่ง SMS", "ยิง SMS", "ส่งข้อความหาลูกค้า", "ส่งเบอร์เดียว", "ส่งหลายเบอร์", "ส่ง SMS จำนวนมาก", "ตั้งเวลาส่ง SMS", "สร้างแคมเปญ SMS", "ช่วยเขียน SMS", "เขียนข้อความ 70 ตัว / 1 เครดิต", "คิด sender name", "เช็คเครดิตแล้วส่ง", "send sms", "blast sms to a list", "sms campaign", "schedule an sms". Composes (condensed copywriting for ≤70 chars), advises the Sender Name, drives the SMSKUB MCP tools (send_message / create_campaign), and ALWAYS runs a safety gate (balance + cost preview + confirm) before sending. Works with the SMSKUB MCP connected, or in compose-only mode without it.
license: See LICENSE in this repository.
compatible: [claude, claude-code, gemini, chatgpt, codex, manus, groq, antigravity, any-mcp-host]
version: 1.0.0
homepage: https://sms-kub.com
tags: [smskub, sms, send-sms, mcp, campaign, broadcast, blast, sender-name, sms-copywriting, character-count, credit, segment, marketing-sms, scheduling, safety-gate, pdpa, nbtc, thai-sms]
---

# SMSKUB SMS — Send + Compose

A portable AI skill that **composes and sends SMS through SMSKUB** (sms-kub.com, an
NBTC-licensed SMS gateway for Thai businesses). Drop it into any AI assistant — it runs the
whole loop: **คิดข้อความ → เลือก Sender Name → เลือกวิธีส่ง → ยิงผ่าน SMSKUB MCP → เช็คผล** — and it
**never sends without a cost preview + confirmation.**

**Core principle:** *An SMS is ~70 Thai characters and 1 credit per recipient — every word and
every baht is accountable.* So the skill always (1) keeps the message inside a stated credit
budget, (2) shows cost + recipient count before firing, and (3) waits for an explicit "ส่งเลย".

## Two operating modes (auto-detect)

| Mode | When | What it can do |
|---|---|---|
| **① Connected** | The **SMSKUB MCP** tools are available in this host (`send_message`, `create_campaign`, `get_balance`, `list_senders`, `get_message_status`, …) | Compose **and actually send** — full loop incl. balance check + delivery status. See `mcp/SETUP.md`. |
| **② Compose-only** | No SMSKUB MCP in this host (e.g. a plain chat assistant) | Compose the message, count characters/credits, advise Sender Name, then **output a ready-to-send package** (message + sender + recipient list + estimated cost) for the user to paste into the SMSKUB console or API. **Do not pretend to send.** |

> Detect the mode by checking whether SMSKUB tools exist. If unsure, ask: "ต่อ SMSKUB MCP ไว้ไหม
> ครับ? ถ้ายัง ผมจะเขียนให้พร้อมส่ง แล้วคุณเอาไปวางใน console เอง."

## Lanes (how to send)

```
smskub-sms  ◄── compose · price · confirm · send
├── Lane A · ส่งด่วน      → send_message      (1 เบอร์ / ไม่กี่เบอร์, ส่งทันที)
├── Lane B · แคมเปญ       → create_campaign   (หลายเบอร์ / ส่งทีละมาก / ตั้งเวลา)
└── Lane C · OTP          → (v2 — request_otp + otp_project; ยังไม่เปิดใน v1)
```

## Brand voice (apply to every message)

- **Tone:** ทางการ สไตล์ B2B น่าเชื่อถือ — กระชับ มืออาชีพ ไม่เล่นมุกเกินงาม. SMS สั้นยิ่งต้องคม.
- **Language:** ไทยเป็นหลัก, technical terms เป็นอังกฤษได้ (OTP, API). ระวัง: **ตัวอังกฤษ/ตัวเลขก็นับตัวอักษร**.
- **Proof ที่อ้างได้:** NBTC-licensed · 98% open rate / 90% อ่านใน 3 นาที · 24/7 support. อ้างเฉพาะตัวเลขที่พิสูจน์ได้.

**Guardrails (ห้ามข้าม):**
- ❌ ห้ามส่งหา **เบอร์ที่ไม่ได้ consent** / ส่ง spam — ผิด **PDPA**. Marketing SMS ควรมีช่องทาง opt-out.
- ❌ ห้ามสัญญาเกินจริง / โฆษณาเกินจริง (NBTC). ยึดตัวเลขพิสูจน์ได้.
- ✅ **ยืนยัน cost + จำนวนผู้รับก่อนยิงเสมอ** — ไม่มี confirm = ไม่ส่ง.

## When to Use

- ผู้ใช้อยาก **ส่ง SMS** — เบอร์เดียว, หลายเบอร์, หรือตั้งเวลา.
- อยากให้ **ช่วยเขียนข้อความ SMS** สั้น ๆ (≤70/≤60 ตัว, คุมเครดิต).
- อยากให้ **คิด/ตรวจ Sender Name**.
- อยาก **เช็คเครดิต** ก่อนส่ง / **ดูสถานะ** หลังส่ง.

ถ้างานเป็น copy ยาว (landing page, อีเมล, โฆษณา) → นั่นไม่ใช่งานของสกิลนี้ (สกิลนี้ทำ SMS สั้น).

## How to run — the send loop

ทำตามลำดับ. ข้ามขั้นที่ผู้ใช้ให้ข้อมูลมาแล้วได้ แต่ **ห้ามข้ามขั้น 5–6 (cost preview + confirm)**.

### STEP 1 — Intake (รู้ก่อนว่าจะส่งอะไร หาใคร)
ถามเฉพาะที่ขาด:
1. **ส่งหาใคร / กี่เบอร์** → ตัดสิน lane: 1–ไม่กี่เบอร์ ส่งทันที = **A**; หลายเบอร์ / ตั้งเวลา = **B**.
2. **เนื้อหา/เป้าหมาย** ของข้อความ (โปรโมชัน, แจ้งเตือน, ยืนยันนัด, ฯลฯ) + มีลิงก์ไหม.
3. **Sender Name** ที่จะใช้ (ถ้ายังไม่มี → STEP 3 ช่วยคิด/เช็ค).
4. **งบเครดิต/ความยาว** ที่รับได้ (default = คุมให้ **1 เครดิต ≤70 ตัวไทย**; ถ้าต้องยาวกว่าค่อยขยับเป็น 2).
5. **ตั้งเวลาหรือส่งทันที** (ถ้าตั้งเวลา → ขอวันเวลา → ใช้ Lane B `is_schedule:true`).

### STEP 2 — Compose (เขียนข้อความ)
เริ่มจากเช็ค **"Use-Case Playbook"** ก่อน — ถ้าโจทย์ตรงสถานการณ์ไหน หยิบเทมเพลตนั้นมาปรับ (เร็วกว่าเขียนเปล่า). ถ้าไม่ตรง → ใช้ **micro-formula** (หัวข้อ "SMS Copy Engine") เขียนให้พอดีงบเครดิต. ทุกครั้งโชว์:
> ตัวอย่างข้อความ + **จำนวนตัวอักษร** + **= กี่เครดิต/เบอร์** (จากตัวนับ).

**🎯 Gut-check ก่อนผ่าน:** *"ถ้าเราเป็นผู้รับ จะดีใจที่ได้ SMS นี้ไหม?"* — ถ้าไม่ (ไม่มีคุณค่าพอจะรบกวน) → แก้ให้คม/มีประโยชน์ก่อนส่ง.

ถ้าหลุดงบ → เสนอเวอร์ชันตัดสั้น. ให้ผู้ใช้เลือก/แก้ก่อนไปต่อ.

### STEP 3 — Sender Name (คิด/ตรวจ)
**Connected:** เรียก `list_senders` ดูชื่อที่อนุมัติแล้ว. **Compose-only:** ถามผู้ใช้ว่าใช้ Sender ชื่ออะไร.
- มีแล้ว → ให้เลือกใช้.
- ยังไม่มี / อยากได้ใหม่ → เสนอชื่อที่ **ผ่านกฎ** (ดู "Sender Name Advisor") + บอกว่าต้องไปขออนุมัติก่อน (≤7 วันทำการ) จึงจะส่งจริงได้.
> ⚠️ ส่งจริงได้เฉพาะ Sender ที่ **อนุมัติแล้ว** เท่านั้น — อย่าใส่ชื่อมั่ว.

### STEP 4 — Validate ผู้รับ
- เบอร์ไทย **10 หลัก** ขึ้นต้น 0 · ตัด space/`-` ออก · **ตัดเบอร์ซ้ำ** · ข้ามเบอร์รูปแบบผิด (รายงานว่าตัดอันไหนทิ้ง).
- Lane A/B รับสูงสุด **1,000 เบอร์/ครั้ง** — เกินนั้นแบ่งหลายครั้ง/หลายแคมเปญ.

### STEP 5 — Cost preview (บังคับ)
**Connected:** เรียก `get_balance`. **Compose-only:** ประเมินจากตาราง "ตัวนับเครดิต". โชว์สรุป **ก่อนยิง**:

```
📋 พร้อมส่ง — ตรวจก่อนยืนยัน
• Lane:        A ส่งด่วน  (หรือ B แคมเปญ / ตั้งเวลา <เวลา>)
• Sender:      Smskub
• ข้อความ:     "<ข้อความ>"  (<n> ตัว = <c> เครดิต/เบอร์)
• ผู้รับ:       <k> เบอร์  (ตัดซ้ำ/ผิดรูปแบบออก <x> เบอร์)
• เครดิตที่ใช้:  <c × k> เครดิต
• คงเหลือ:      <balance> → เหลือ <balance − c×k> หลังส่ง   ✅ พอ / ⛔ ไม่พอ
```

ถ้าเครดิตไม่พอ → หยุด, บอกให้เติมเครดิตที่ console SMSKUB (sms-kub.com). อย่ายิง.

### STEP 6 — Confirm → Fire
ขอคำว่า **"ยืนยัน/ส่งเลย"** ก่อน. เมื่อยืนยัน (Connected mode):
- **Lane A:** `send_message({ to:[...], from, message })`
- **Lane B (ทันที):** `create_campaign({ name, message, to:[...], from, is_schedule:false, frequency:"onetime" })`
- **Lane B (ตั้งเวลา):** `create_campaign({ ..., is_schedule:true, start_time:"<ISO 8601 UTC>" })`
  > ⏰ แปลงเวลาไทยเป็น **UTC (ISO 8601, ลงท้าย Z)** ก่อนใส่ `start_time` — ไทย = UTC+7 (เช่น 15:00 ของวันไทย = `08:00:00.000Z`).

**Compose-only mode:** แทนการยิง → ส่งมอบ "ready-to-send package" (ข้อความ + Sender + รายการเบอร์ + เครดิตประเมิน + lane ที่แนะนำ) ให้ผู้ใช้เอาไปวางใน console/API เอง.

### STEP 7 — Report + วัดผล
**Connected:** อ่าน SMS cost จาก response → รายงานผลจริง; ถ้าต้องการ → `get_message_status` ดูส่งถึง/ล้มเหลวกี่เบอร์ (คืนเครดิตอัตโนมัติเมื่อส่งไม่สำเร็จ).

**📊 ตัวเลขที่ควรดู:** **delivery rate** (ส่งถึง/ส่งไป — ต่ำผิดปกติ = เบอร์เสีย/Sender มีปัญหา) · **คลิกลิงก์** (ถ้าเปิด SMS Tracking) · สัญญาณ **opt-out/ร้องเรียน** สำหรับ marketing (สูง = ส่งถี่ไป/ไม่ตรงกลุ่ม → ลดความถี่). สรุปสั้น ๆ + เสนอ step ถัดไป (เช่น **retarget** เฉพาะเบอร์ที่ส่งสำเร็จ).

---

## SMS Copy Engine — 5 สูตร copywriting ย่อเป็น micro-formula (≤70 ตัว)

SMS ไม่มีที่ให้กาง AIDA เต็ม — บีบเหลือ **โครงเดียว**: `[ฮุก/แบรนด์] + [คุณค่า/ออฟเฟอร์] + [CTA + ลิงก์/เงื่อนไข]`.

| เป้าหมาย | สูตรย่อ | โครง 1 บรรทัด | ตัวอย่าง |
|---|---|---|---|
| มี pain ชัด | **PAS-micro** | เจ็บ → แก้ → CTA | `OTP ส่งช้าเสียลูกค้า? เราส่งถึงใน 3 นาที ทดลองฟรี bit.ly/x` |
| ขาย "ผลลัพธ์/อัปเกรด" | **BAB-micro** | สภาพเดิม → ผลใหม่ → CTA | `เปิดอ่าน SMS 98% ดันยอดด้วย Marketing SMS เริ่ม 500฿ bit.ly/x` |
| โปร/เร่งปิด | **Offer-micro** | ส่วนลด/เร่ง → CTA + วันหมด | `ลด 20% ถึง 30 มิ.ย. สั่งเลย bit.ly/x` |
| ทั่วไป/รู้จักแบรนด์อยู่ | **AIDA-micro** | ฮุก → คุณค่า → CTA | `ส่ง SMS ถึงจริง 24/7 ครบจบที่เดียว ดู bit.ly/x` |
| แจ้งเตือน/transactional | **Notify-micro** | ข้อเท็จจริง → action | `คุณมีนัด 30 มิ.ย. 10:00 ที่คลินิก ยืนยันโทร 021234567` |

**กฎเขียน SMS ให้คม:**
- **วางแบรนด์/คุณค่าไว้หน้า** — ผู้รับเห็น 1–2 คำแรกก่อน. *(ไม่ต้องพิมพ์ "From <แบรนด์>:" — Sender Name ถูกแสดงโดยเครือข่ายอยู่แล้ว ใส่ซ้ำ = เปลืองตัวอักษร)*
- **1 CTA เท่านั้น** + ทำให้กดง่าย (ลิงก์สั้น/เบอร์โทร). ลิงก์ย่อด้วย **SMS Tracking** ของ SMSKUB ได้.
- **personalize** ได้ผ่านแคมเปญ+Tag (`{ชื่อ}`) — แต่ตัวแปรก็กินตัวอักษร เผื่อความยาวกรณีชื่อยาว.
- **Marketing ต้องมี opt-out** (เช่น `กดยกเลิก ...`) — กินตัวอักษร ให้รวมในงบเครดิตด้วย.
- เลี่ยงอิโมจิ/อักขระแปลกใน SMS ไทย (เสี่ยงเพี้ยน + ทำให้ตกโหมด Unicode).

## Use-Case Playbook — เทมเพลตตามจังหวะธุรกิจ (ไทย, พร้อมปรับ)

ลูกค้าส่ง SMS ในไม่กี่จังหวะซ้ำ ๆ. เริ่มจากตารางนี้แทนการเขียนจากศูนย์ — `{...}` = ตัวแปร
(ใส่ผ่านแคมเปญ+Tag), เครดิตเป็นค่าประมาณ **เช็คด้วยตัวนับก่อนยิงเสมอ** (ตัวแปรยาวอาจดันเป็น 2 เครดิต).

| Use-case | จังหวะส่ง | เทมเพลต (ปรับได้) | ~เครดิต |
|---|---|---|---|
| **ยืนยันออเดอร์** *(transactional)* | ทันทีหลังสั่ง | `ยืนยันออเดอร์ #{เลข} ยอด {ยอด}฿ จะแจ้งเลขพัสดุเร็วๆนี้ ขอบคุณค่ะ` | 1 |
| **แจ้งจัดส่ง** *(transactional)* | วันส่งพัสดุ | `พัสดุจัดส่งแล้ว เลข {tracking} ติดตาม {link}` | 1 |
| **เตือนนัด/คิว** *(transactional)* | ก่อนนัด 1 วัน | `เตือนนัด {วัน} {เวลา} ที่ {สถานที่} เลื่อนโทร {เบอร์}` | 1 |
| **ตะกร้าค้าง** *(marketing)* | +30 นาที (ยังไม่ลด) | `คุณ{ชื่อ} มีสินค้าค้างในตะกร้า กดสั่งต่อ {link}` | 1 |
| | +24 ชม. (ค่อยลด) | `ยังสนใจอยู่ไหม? ลด {x}% วันนี้ กดเลย {link}` | 1 |
| **โปร/แฟลชเซล** *(marketing)* | วันเปิดโปร | `FLASH ลด {x}% ถึง {วันหมด} เท่านั้น สั่ง {link}` | 1 |
| **เตือนชำระ/ต่ออายุ** *(transactional)* | ก่อนครบกำหนด | `แจ้งเตือน ยอด {ยอด}฿ ครบกำหนด {วัน} ชำระ {link}` | 1 |
| **เตือนเติม/สต็อกใกล้หมด** | เมื่อถึง threshold | `เครดิต/สินค้าใกล้หมด เหลือ {n} เติมก่อนหมด {link}` | 1 |
| **Win-back ลูกค้าหาย** *(marketing)* | หาย 60–90 วัน | `คิดถึงคุณ{ชื่อ} กลับมารับส่วนลด {x}% โค้ด {code} {link}` | 1 |

**กฎใช้ Playbook:**
- **transactional (ยืนยัน/จัดส่ง/นัด/ชำระ) ≠ marketing** — กลุ่ม transactional ส่งได้ตรงไปตรงมา; กลุ่ม **marketing (โปร/ตะกร้า/win-back) ต้องมี consent + ทาง opt-out**.
- เทมเพลตเป็น **จุดตั้งต้น ไม่ใช่คำตอบสุดท้าย** — ปรับโทน/ออฟเฟอร์ให้ตรงลูกค้า แล้วผ่าน Gut-check + ตัวนับเครดิตทุกครั้ง.

## ตัวนับตัวอักษร / เครดิต (รู้ให้แม่นก่อนส่ง)

| ภาษา | 1 เครดิต | 2 เครดิต | 3 เครดิต | หมายเหตุ |
|---|---|---|---|---|
| **ไทย / มีไทยปน** (Unicode) | ≤ **70** ตัว | ≤ **134** (67×2) | ≤ **201** (67×3) | มีอักขระไทย/อิโมจิแม้ตัวเดียว → ตกโหมดนี้ |
| **อังกฤษล้วน** (GSM-7) | ≤ **160** ตัว | ≤ **306** (153×2) | ≤ **459** (153×3) | a-z 0-9 และสัญลักษณ์พื้นฐาน |

- **เป้าปลอดภัย = ไทย ≤60–70 / อังกฤษ ≤150–160 → 1 เครดิต/เบอร์.** เกิน 70 (ไทย) แม้ตัวเดียว = เด้งเป็น 2 เครดิตทันที.
- **ต้นทุน = เครดิต/เบอร์ × จำนวนเบอร์.** (ราคา/เครดิตขึ้นกับแพ็กเกจ — ดูราคาปัจจุบันที่ sms-kub.com/price)
- Connected mode: ยึด **SMS cost ที่ MCP คืนใน response** เป็นหลัก — ตารางนี้ไว้ประเมินตอนเขียน/Compose-only.

## Sender Name Advisor

**กฎ:** ≤ **11 ตัว** · **a-z A-Z 0-9** เท่านั้น (ไทยไม่ได้) · อักขระพิเศษได้แค่ `.` `-` `_` และเว้นวรรค · แยกประเภท **OTP** (เชื่อม API) / **Marketing** (โฆษณา).

1. เสนอ 2–3 ชื่อจากชื่อแบรนด์/บริการ ที่จำง่าย + ผ่านกฎ (เช่น `Smskub`, `YourShop`, `ClinicABC`).
2. เช็คความยาว/อักขระให้ (เตือนถ้าเกิน 11 หรือมีไทย).
3. Connected: เทียบกับ `list_senders` → มีและอนุมัติแล้ว ใช้ได้เลย; ยังไม่มี บอกให้ไปขอที่ console (**ตั้งค่าการส่ง → ชื่อผู้ส่ง → เพิ่มใหม่**, เอกสารตามประเภทบุคคล/นิติบุคคล, อนุมัติ ≤7 วันทำการ).

## MCP tool reference (Connected mode)

> ชื่อ tool อาจปรากฏต่างกันตาม host เช่น `send_message`, `smskub.send_message`, หรือ `mcp__smskub__send_message` — ใช้ตัวที่ host เปิดให้. การต่อ MCP ดู `mcp/SETUP.md`.

| ต้องการ | tool | args หลัก |
|---|---|---|
| ส่งด่วน (Lane A) | `send_message` | `to[]`, `from`, `message` |
| แคมเปญ/ตั้งเวลา (Lane B) | `create_campaign` | `name`, `message`, `to[]`, `from`, `is_schedule`, `start_time?`, `frequency` |
| ดู Sender ที่ใช้ได้ | `list_senders` | — |
| เช็คเครดิต | `get_balance` | — |
| สถานะการส่ง | `get_message_status` | `campaign?`, `limit?`, `page?`, `order?` |
| รายการแคมเปญ/แก้/ลบ | `list_campaigns` · `get_campaign` · `update_campaign` · `delete_campaign` | `id` ฯลฯ |
| (v2) OTP | `request_otp` · `*_otp_project` | `phone`, `project`, ... |

## ตัวอย่างเดินงานจริง

**A — ส่งด่วนเบอร์เดียว:** "ส่งหา 0811111111 บอกโปรลด 20%"
→ เขียน Offer-micro (นับตัว) → เลือก Sender (`list_senders`) → `get_balance` → cost preview (1×1) → confirm → `send_message`.

**B — แคมเปญหลายเบอร์:** "ส่งโปรนี้หา 350 เบอร์ในไฟล์นี้"
→ validate+ตัดซ้ำ → เขียนข้อความ → cost preview (350 × เครดิต) → เช็คเครดิตพอไหม → confirm → `create_campaign(is_schedule:false)` → `get_message_status`.

**B — ตั้งเวลา:** "ส่งพรุ่งนี้ 9 โมง" → แปลงเป็น UTC (`...T02:00:00.000Z`) → `create_campaign(is_schedule:true, start_time)`.

## Common Mistakes

| พลาด | แก้ |
|---|---|
| ยิงก่อนโชว์ cost/ขอ confirm | **บังคับ** STEP 5–6 เสมอ — ไม่มี confirm ไม่ส่ง |
| อ้างว่าส่งแล้วทั้งที่ไม่มี MCP | ไม่มี SMSKUB tools = **Compose-only** เท่านั้น อย่าแกล้งส่ง |
| ลืมว่ามีไทยปน = ตก 70 ตัว/เครดิต | ใช้ตัวนับ; มีไทยแม้ตัวเดียว → โหมด 70 |
| เขียนยาวเกินงบโดยไม่บอก | โชว์ "n ตัว = c เครดิต" ทุกครั้ง + เสนอเวอร์ชันตัด |
| ใส่ Sender ที่ยังไม่อนุมัติ/เป็นไทย | เช็ค `list_senders` + กฎ ≤11 EN ก่อน |
| พิมพ์ "From <แบรนด์>:" นำข้อความ | ไม่ต้อง — เครือข่ายโชว์ Sender Name ให้แล้ว เปลืองตัวอักษรเปล่า |
| ส่งหาเบอร์ไม่ได้ consent / ไม่มี opt-out | กัน PDPA — เตือนผู้ใช้, ใส่ช่องทางยกเลิกใน Marketing |
| ตั้งเวลาด้วยเวลาไทยตรง ๆ | แปลงเป็น UTC (−7 ชม.) ก่อนใส่ `start_time` |

## Roadmap

- **v2 — Lane C OTP:** `request_otp` + จัดการ `otp_project` (สร้าง/แก้/ดู), template OTP, `text1` แทรก ≤20 ตัว, `verify_otp`.
- **v2+ — personalize จากไฟล์/Tag**, retarget (ส่งซ้ำเฉพาะเบอร์สำเร็จ), SMS Tracking ย่อลิงก์ + วัดคลิกรายบุคคล.

---
*SMSKUB SMS Skill · พัฒนาโดย SMSKUB (sms-kub.com) · ติดตั้งบน AI ตัวไหนก็ได้ — ดู `INSTALL.md`*
