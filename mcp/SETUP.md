# ต่อ SMSKUB MCP (Connected mode)

โหมด Connected = AI **ส่ง SMS ได้จริง** เพราะมีเครื่องมือ (tools) ของ SMSKUB ผ่าน **MCP**.
ไม่ต่อ MCP ก็ใช้สกิลได้ในโหมด **Compose-only** (เขียนให้พร้อมส่ง).

## เริ่มต้นใน 2 นาที

**สิ่งที่ต้องเตรียม**
1. บัญชี SMSKUB + **API Token** — หาได้ที่ **Console → Settings → API Token** (sms-kub.com)
2. AI client ที่รองรับ MCP — **Claude (Web / Mobile / Desktop)**, **Manus AI**, หรือ client อื่นที่รับ MCP URL ได้ (Cursor, Gemini CLI, Codex ฯลฯ)

**ประกอบ URL ของคุณ** (เปลี่ยน `YOUR_API_TOKEN` เป็น token จริง):
```
https://smskubmcp.com/mcp?token=YOUR_API_TOKEN
```

> 🔒 **เตือน:** URL นี้มี token ฝังอยู่ = กุญแจบัญชีคุณ. **อย่าแชร์ · อย่า commit ลง Git · อย่าโพสต์ที่สาธารณะ.**
> ไฟล์นี้ตั้งใจใช้ `YOUR_API_TOKEN` เป็น placeholder เท่านั้น — เวลาตั้งค่าจริงให้ใส่ token บนเครื่องคุณเอง ไม่ต้อง push.

เครื่องมือที่สกิลใช้: `send_message`, `create_campaign`, `list_senders`, `get_balance`,
`get_message_status`, `list_campaigns`, `get_campaign`, `update_campaign`, `delete_campaign` (+ OTP ใน v2).

---

## A) ต่อแบบ Remote (URL — ง่ายสุด, รองรับ Web/Mobile/Desktop)

### Claude Web (claude.ai) / Claude Mobile (iOS · Android) / Claude Desktop
ไปที่ **Settings → Connectors → Add custom connector** (หรือเมนู MCP/Integrations) แล้ววาง URL:
```
https://smskubmcp.com/mcp?token=YOUR_API_TOKEN
```

### Manus AI
เพิ่ม MCP server ใหม่ → วาง URL เดียวกัน.

### Client อื่นที่รับ MCP URL (ใช้ URL เดียวกันได้)
- **Cursor / Crosscode** — `.cursor/mcp.json`:
  ```json
  { "mcpServers": { "smskub": { "url": "https://smskubmcp.com/mcp?token=YOUR_API_TOKEN" } } }
  ```
- **Gemini CLI** — `settings.json`:
  ```json
  { "mcpServers": { "smskub": { "httpUrl": "https://smskubmcp.com/mcp?token=YOUR_API_TOKEN" } } }
  ```

---

## B) รันบนเครื่องตัวเองผ่าน npx (Claude Desktop เท่านั้น)

เหมาะกับคนที่ไม่อยากให้ token วิ่งผ่าน remote server. **ต้องมี Node.js 18+.**
เพิ่มใน `claude_desktop_config.json`:
```json
{
  "mcpServers": {
    "smskub": {
      "command": "npx",
      "args": ["-y", "smskub-mcp"],
      "env": { "SMSKUB_TOKEN": "your_api_token_here" }
    }
  }
}
```
แล้ว **Restart Claude Desktop**.

> Codex (stdio) ใช้รูปแบบเดียวกันใน `~/.codex/config.toml`:
> ```toml
> [mcp_servers.smskub]
> command = "npx"
> args = ["-y", "smskub-mcp"]
> env = { SMSKUB_TOKEN = "your_api_token_here" }
> ```

---

## C) Self-host (Clone + Build) — สำหรับนักพัฒนา

```bash
git clone https://github.com/tklom/smskub-mcp.git
cd smskub-mcp
npm install
npm run build
```
สร้างไฟล์ `.env`:
```
SMSKUB_TOKEN=your_api_token_here
```
- **STDIO** (Claude Desktop): `npm start` แล้วชี้ config ไปที่ `node /absolute/path/to/smskub-mcp/dist/index.js` (env `SMSKUB_TOKEN`).
- **HTTP** (Desktop/Mobile/Web): `npm run serve` → เปิดที่ `http://localhost:3000/mcp` (deploy ขึ้น Render / Railway / Fly.io / Hostinger ได้ แล้วใช้ URL ของคุณแทน).

---

## ทดสอบว่าใช้งานได้

พิมพ์ใน AI: **"ยอดเครดิต SMS ของฉันคงเหลือเท่าไหร่"**
ถ้าได้ยอดคงเหลือกลับมา = เชื่อมต่อสำเร็จ (สกิลเรียก `get_balance`).
จากนั้นลอง: **"ส่ง SMS หา 0811111111 ..."** → ต้องเด้ง **cost preview + ขอยืนยัน** ก่อนยิงเสมอ.
