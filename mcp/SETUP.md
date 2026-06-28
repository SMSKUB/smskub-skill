# ต่อ SMSKUB MCP (Connected mode)

โหมด Connected = AI **ส่ง SMS ได้จริง** เพราะมีเครื่องมือ (tools) ของ SMSKUB ผ่าน **MCP**
(Model Context Protocol). ไม่ต่อ MCP ก็ใช้สกิลได้ในโหมด **Compose-only** (เขียนให้พร้อมส่ง).

> ⚠️ **ค่าจริง (endpoint / API key / package) ให้ดูจากเอกสาร SMSKUB MCP ของคุณ** แล้วเติมแทน
> `<...>` ด้านล่าง — ไฟล์นี้ให้ **โครง config มาตรฐาน** ของแต่ละ host ไม่ใช่ค่าลับจริง.
> ขอข้อมูลการเชื่อมต่อ/คีย์ได้ที่ทีม SMSKUB (sms-kub.com).

เครื่องมือที่สกิลใช้: `send_message`, `create_campaign`, `list_senders`, `get_balance`,
`get_message_status`, `list_campaigns`, `get_campaign`, `update_campaign`, `delete_campaign`
(+ OTP ใน v2).

---

## รูปแบบการต่อ (เลือกตามที่ SMSKUB ให้มา)

**แบบ Remote (HTTP/SSE):** ถ้า SMSKUB ให้ URL ของ MCP server มา
**แบบ Local (stdio):** ถ้ารันผ่านคำสั่ง (เช่น `npx`) บนเครื่องคุณ

แทน `<MCP_URL>`, `<SMSKUB_API_KEY>`, `<run-command>` ด้วยค่าจริงจาก SMSKUB.

### Claude Code (`~/.claude.json` หรือ `claude mcp add`)
```jsonc
{
  "mcpServers": {
    "smskub": {
      // remote:
      "url": "<MCP_URL>",
      "headers": { "Authorization": "Bearer <SMSKUB_API_KEY>" }
      // — หรือ local: ลบ url/headers แล้วใช้ —
      // "command": "<run-command>", "args": ["<...>"],
      // "env": { "SMSKUB_API_KEY": "<SMSKUB_API_KEY>" }
    }
  }
}
```

### Gemini CLI (`settings.json`)
```json
{
  "mcpServers": {
    "smskub": {
      "httpUrl": "<MCP_URL>",
      "headers": { "Authorization": "Bearer <SMSKUB_API_KEY>" }
    }
  }
}
```

### OpenAI Codex (`~/.codex/config.toml`)
```toml
[mcp_servers.smskub]
# local:
command = "<run-command>"
args = ["<...>"]
env = { SMSKUB_API_KEY = "<SMSKUB_API_KEY>" }
# remote (ถ้ารองรับ): url = "<MCP_URL>"
```

### Cursor / Crosscode (`.cursor/mcp.json`)
```json
{
  "mcpServers": {
    "smskub": {
      "url": "<MCP_URL>",
      "headers": { "Authorization": "Bearer <SMSKUB_API_KEY>" }
    }
  }
}
```

### Claude Desktop / ChatGPT / Antigravity / อื่น ๆ
ต่อผ่านเมนู **Connectors / MCP / Integrations** ของแอปนั้น แล้วกรอก `<MCP_URL>` + `<SMSKUB_API_KEY>`.
แพลตฟอร์มที่ยังไม่รองรับ MCP → ใช้ **Compose-only** หรือเชื่อม **REST API ของ SMSKUB** เป็น Action/tool แทน.

---

## ทดสอบหลังต่อ
ถาม AI ว่า: **"เช็คเครดิต SMSKUB ให้หน่อย"** → ถ้าต่อสำเร็จจะเรียก `get_balance` แล้วบอกยอดคงเหลือ.
จากนั้นลอง: **"ส่ง SMS หา 0811111111 ..."** → ต้องเด้ง **cost preview + ขอยืนยัน** ก่อนยิงเสมอ.
