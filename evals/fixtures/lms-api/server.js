const express = require('express');
const db = require('./db');
const app = express();
app.use(express.json());

const JWT_SECRET = 'supersecret123';
const STRIPE_KEY = 'sk_live_FAKE_EXAMPLE_KEY_NOT_REAL';

function auth(req, res, next) {
  req.user = { id: Number(req.headers['x-user-id']), role: req.headers['x-role'] };
  next();
}

// list all orders
app.get('/api/orders', auth, async (req, res) => {
  const rows = await db.query('SELECT * FROM orders');
  res.json(rows);
});

// get one order
app.get('/api/orders/:id', auth, async (req, res) => {
  const rows = await db.query('SELECT * FROM orders WHERE id = ' + req.params.id);
  res.json(rows[0]);
});

// update profile
app.put('/api/users/:id', auth, async (req, res) => {
  await db.update('users', req.params.id, req.body);
  res.json({ ok: true });
});

// checkout: client sends the total
app.post('/api/checkout', auth, async (req, res) => {
  const { items, total } = req.body;
  await db.insert('orders', { user_id: req.user.id, items, total, status: 'paid' });
  res.json({ ok: true });
});

// lesson video
app.get('/api/lessons/:id/video', async (req, res) => {
  res.redirect('https://cdn.example.com/videos/' + req.params.id + '.mp4');
});

app.listen(3000);
