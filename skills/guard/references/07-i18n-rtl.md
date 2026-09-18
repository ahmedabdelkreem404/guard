# i18n & RTL — Arabic/English and Mixed-Direction Content

Read when the product is bilingual/multilingual, or specifically Arabic/English with RTL/LTR.

---

## 1. Direction is structural, not cosmetic

Set `dir` at the document/root level from the active language — never fake RTL by mirroring individual
components with custom CSS:

```html
<html lang="ar" dir="rtl">
<html lang="en" dir="ltr">
```

Use logical CSS properties (`margin-inline-start`, `padding-inline-end`, `inset-inline-start`,
`text-align: start`) instead of physical ones (`margin-left`, `text-align: left`) so layout flips
correctly with direction, automatically. On Flutter, wrap the app in `Directionality`/rely on
`Localizations` — never hardcode `TextDirection.ltr`.

Things that must flip with direction: navigation order, icon-before/after-label placement, form field
order, breadcrumb arrows, carousel/swipe direction, progress bars, chart axis order (be deliberate — data
charts often stay LTR by convention even in an RTL UI; decide once and keep it consistent).

Things that must **not** flip: numerals (Arabic UIs conventionally still read digits left-to-right),
phone numbers, code snippets, URLs, email addresses, and logos.

---

## 2. Mixed-direction content (the hard case)

A string that mixes Arabic and English/Latin/numbers in one line is the normal case, not the exception —
product names, prices, usernames, emails inside Arabic sentences. The browser's Unicode bidi algorithm
handles this natively *if* you don't fight it:

- Don't force `direction` on inline spans of embedded Latin text inside RTL paragraphs unless the bidi algorithm visibly gets it wrong (rare, but happens with punctuation at segment boundaries — wrap the embedded run in `<bdi>` or apply `unicode-bidi: isolate` rather than forcing a hard direction).
- Test the specific failure cases: an English brand name inside an Arabic sentence, a price like `199 EGP` inside Arabic text, a mixed list where some rows are Arabic and some are English.

---

**Rules that make "Arabic reads right-to-left, English left-to-right, even in the same sentence" hold:**
- The **paragraph** direction comes from the page/component language (`dir="rtl"` for Arabic UI). Inside it, embedded English runs are laid out left-to-right by the bidi algorithm automatically.
- **User-generated or unknown-language text** (names, comments, product titles, search input): set `dir="auto"` on the element (and `<input dir="auto">`, `<textarea dir="auto">`) so each value picks its own direction from its first strong character. Isolate an inline run with `<bdi>` when its neighbours would otherwise reorder it.
- Punctuation and numbers at run boundaries are the usual failures: a trailing `.` `)` `%` next to Latin text, a price `199 EGP`, a phone number, `+`/`-` signs. Test them; fix with `<bdi>`/`unicode-bidi: isolate`, not with hard `direction` overrides.
- Set `lang` on each language run when a page mixes scripts, so the right font and hyphenation apply.
- Flutter: `Directionality` from the locale; for dynamic text use `Bidi.detectRtlDirectionality`/`TextDirection` per `Text`; keep `TextAlign.start`, never hardcoded `left`/`right`.
- Arabic typography: no letter-spacing, no forced uppercase, no italic simulation; give Arabic a slightly larger line-height (≈1.6–1.8) than Latin; never let a Latin-only fallback font render Arabic glyphs.

---

## 3. Translation as structured data, not scattered strings

Translatable content lives in data (a translations table, locale files, or a CMS field per language),
never hardcoded per page. Every translatable entity exposes language-specific fields that expand
automatically when a language is added — an editor should never need to touch JSON or source code to add
or edit a translation (see `08-dashboard.md` §5 for the admin side).

**Fallback** is deterministic: requested language → default language → don't render a raw translation
key to an end user, ever.

**Completeness** is visible to whoever manages content (which languages are done vs. missing), but that's
a dashboard concern, not a runtime one.

---

## 4. Layout expansion

Arabic and other translations can run 20–35% longer than English. Test with real translated strings, not
lorem ipsum: buttons, nav labels, table headers, and form labels must not truncate awkwardly, wrap into
two-line buttons, or break a fixed-width layout. Prefer flexible containers over fixed pixel widths for
any text-bearing element.

---

## 5. Fonts

Verify the chosen font family actually has an Arabic weight set that matches the Latin weights used
(400/500/600/700) — a mismatched fallback font for Arabic breaks the visual identity established in
`06-design.md`. Load Arabic and Latin subsets as needed; don't ship the full glyph set of a font if only
a subset is used.

---

## 6. Numbers, dates, currency

- Store and compare timestamps in UTC always; render in the user's locale/timezone.
- Date formats differ by locale (day/month order, calendar system where relevant) — use the platform's locale-aware formatter, not manual string concatenation.
- Currency: correct symbol/code placement per locale (before or after the number, with or without a space), and never assume USD-style formatting applies to EGP or other currencies.
- Numerals: Arabic UIs typically render Western Arabic numerals (0–9), not Eastern Arabic-Indic digits, unless the product specifically wants the latter — confirm rather than assume either way.
- Plurals: Arabic has more plural forms than English (zero/one/two/few/many/other) — use the platform's pluralization API, not an if/else on count.

---

## 7. SEO handoff

`lang`/`dir` must match the page's actual primary content; `hreflang` annotations must be reciprocal and
valid; each localized page must be genuinely localized (not just a translated `<title>`); Arabic
metadata is written naturally in Arabic, not mechanically translated to fill a tag. Full detail in
`04-seo.md` §8.

---

## 8. Testing checklist

Arabic only · English only · mixed Arabic+English in one string · a language switch mid-session ·
missing/incomplete translation (verify the fallback, not a raw key) · long translated strings in buttons
and nav · RTL layout at the smallest supported width · numerals and currency formatting · date formatting
· a form with mixed-direction input (an English email field inside an RTL form).
