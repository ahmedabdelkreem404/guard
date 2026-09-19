// Grades one eval run. Usage: node grade.mjs <fixture> <projectDir> <run.jsonl>
// Prints one JSON object. Checks are static regex checks on the resulting files, plus evidence
// from the run transcript (did the guard skill fire, cost, turns). "doctrine" marks checks that a
// default model usually skips and that Guard specifically teaches.
import fs from 'node:fs';
import path from 'node:path';

const [fixture, dir, jsonl] = process.argv.slice(2);

function readAll(exts) {
  const out = [];
  (function walk(d) {
    for (const e of fs.readdirSync(d, { withFileTypes: true })) {
      if (e.name === 'node_modules' || e.name.startsWith('.')) continue;
      const p = path.join(d, e.name);
      if (e.isDirectory()) walk(p);
      else if (exts.includes(path.extname(e.name))) out.push(fs.readFileSync(p, 'utf8'));
    }
  })(dir);
  return out.join('\n');
}

// Transcript evidence
let skillsFired = [], cost = null, turns = null, askedUser = 0;
if (fs.existsSync(jsonl)) {
  const buf = fs.readFileSync(jsonl);
  const text = (buf[0] === 0xff && buf[1] === 0xfe) ? buf.toString('utf16le') : buf.toString('utf8'); // PS 5.1 redirection writes UTF-16
  for (const line of text.replace(/^﻿/, '').split('\n')) {
    if (!line.trim()) continue;
    let ev; try { ev = JSON.parse(line); } catch { continue; }
    if (ev.type === 'assistant' && ev.message?.content) {
      for (const c of ev.message.content) {
        if (c.type === 'tool_use' && c.name === 'Skill') skillsFired.push(c.input?.skill ?? '?');
        if (c.type === 'tool_use' && c.name === 'AskUserQuestion') askedUser++;
      }
    }
    if (ev.type === 'result') { cost = ev.total_cost_usd ?? null; turns = ev.num_turns ?? null; }
  }
}

const checks = [];
const add = (id, desc, pass, doctrine = false) => checks.push({ id, desc, pass: !!pass, doctrine });

if (fixture === 'lms-api') {
  const code = readAll(['.js', '.mjs', '.ts']);
  const routes = code.split(/(?=\.(?:get|post|put|patch|delete)\(\s*['"`])/);
  const seg = (needle) => routes.filter(r => needle.test(r.slice(0, 200))).join('\n');
  const list = seg(/\(\s*['"`]\/api\/orders['"`]/);
  const checkout = seg(/checkout/);
  const video = seg(/video/);

  add('secrets', 'no hardcoded JWT/Stripe secrets', !/sk_live_|supersecret123/.test(code));
  add('auth', 'identity not taken from client headers', !/x-user-id|x-role/i.test(code));
  add('sqli', 'no string-concatenated SQL', !/query\(\s*['"`][^'"`]*['"`]\s*\+/.test(code) && !/`[^`]*\$\{\s*req\./.test(code));
  add('mass-assign', 'profile update does not spread req.body', !/update\([^)]*req\.body\s*\)/.test(code));
  add('client-total', 'checkout does not trust client total', !/\{[^}]*\btotal\b[^}]*\}\s*=\s*req\.body/.test(code) && !/total\s*:\s*req\.body\.total/.test(code));
  add('orders-scoped', 'order list is scoped to the caller', /user_id|user\.id/.test(list));
  add('video-signed', 'video needs auth AND a signed/expiring URL', /auth/i.test(video) && /sign|expires|hmac|token/i.test(video), true);
  add('orders-bounded', 'order list is paginated/bounded (LIMIT)', /limit|pageSize|per_page/i.test(list), true);
  add('paid-not-trusted', "checkout does not mark 'paid' without payment verification", !/status\s*:\s*['"]paid['"]/.test(checkout) || /webhook|payment_?intent|verify|charge|stripe/i.test(checkout), true);
  add('rate-limit', 'rate limiting present', /rate-?limit|rateLimit|throttle/i.test(code), true);
  add('money', 'money handled as integers/decimal/rounded', /cents|minor|decimal|Math\.round|BigInt/i.test(code), true);
}

const passed = checks.filter(c => c.pass).length;
const doc = checks.filter(c => c.doctrine);
console.log(JSON.stringify({
  fixture, passed, total: checks.length,
  doctrinePassed: doc.filter(c => c.pass).length, doctrineTotal: doc.length,
  skillsFired, askedUser, cost, turns,
  failed: checks.filter(c => !c.pass).map(c => c.id),
}));
