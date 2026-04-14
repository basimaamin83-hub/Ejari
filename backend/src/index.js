const path = require('path');
const express = require('express');
const cors = require('cors');
const Database = require('better-sqlite3');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

const fs = require('fs');
const dbPath = path.join(__dirname, '..', 'data', 'ejari.sqlite');
if (!fs.existsSync(dbPath)) {
  console.error('Missing database. Run: npm run db:init');
  process.exit(1);
}
const db = new Database(dbPath, { readonly: true });

app.get('/health', (_req, res) => {
  res.json({ ok: true, service: 'ejari-api' });
});

app.get('/api/properties', (_req, res) => {
  try {
    const rows = db
      .prepare(
        `SELECT p.*, u.full_name AS owner_name
         FROM properties p
         JOIN users u ON u.id = p.owner_id`
      )
      .all();
    res.json(rows);
  } catch (e) {
    res.status(500).json({ error: String(e.message) });
  }
});

app.get('/api/users/:id', (req, res) => {
  try {
    const row = db.prepare('SELECT * FROM users WHERE id = ?').get(req.params.id);
    if (!row) return res.status(404).json({ error: 'not_found' });
    res.json(row);
  } catch (e) {
    res.status(500).json({ error: String(e.message) });
  }
});

app.listen(PORT, () => {
  console.log(`Ejari API listening on http://localhost:${PORT}`);
});
