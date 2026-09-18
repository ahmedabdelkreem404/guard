# Design — Identity, Responsive (watch → 4K), Motion, Accessibility

Read when the task touches visual identity, design tokens, components, layout, responsiveness, motion,
3D/depth effects, or accessibility — web or Flutter/mobile. Also read first in **Build mode** and when a
brand asset (logo) is provided.

The target feel is the discipline of the best product companies: **one coherent identity, restraint,
precise alignment, fast, and motion that explains something.** Those are principles to apply, not assets
to copy — never imitate a competitor's logo, layout, iconography, motion or colour system (§10).

---

## 1. Identity Lock — decide once, enforce everywhere

Before any UI work, establish the identity and **write it down once**, so every later screen and every
later session inherits it instead of re-deriving it (this also saves tokens).

**Source priority** (first that exists wins):
1. A brand guide or explicit colours/fonts from the user — use exactly.
2. The **logo** (SVG/PNG in the repo or supplied): read its fills or sample its dominant colours (quantize; ignore transparent/white/near-black backgrounds); the strongest hue becomes **primary**, a second distinct hue at most becomes **accent**.
3. The project's existing theme/CSS variables — preserve, do not replace.
4. Nothing supplied: choose a restrained neutral scale plus **one** accent suited to the domain, and state it as an assumption.

**Derive, don't eyeball:**
- Build a tonal scale for primary (≈50→900) by varying lightness while holding hue (OKLCH/HSL). Map it to semantic roles: `primary`, `on-primary`, `surface`, `surface-elevated`, `text`, `text-muted`, `border`, `focus`, plus `success/warning/error/info`.
- **Verify contrast** for every text/background and control/background pair in light **and** dark: text ≥ 4.5:1, large text and UI boundaries ≥ 3:1. If the brand colour fails as text, use a darker step for text and keep the brand colour for fills — change tone, not hue.
- **Fonts:** one family with real Latin **and** Arabic coverage, or a matched Latin + Arabic pair with equivalent weights (e.g. IBM Plex Sans + IBM Plex Sans Arabic, Noto Sans + Noto Sans Arabic, Cairo, Tajawal, Readex Pro). Verify licence and that the weights you use exist for both scripts. 1 family (+ optional display) is the rule.
- **Logo derivatives:** favicon, app icons, OG image and light/dark logo variants come from the source logo; respect clear space and minimum size.

**Write the lock:** tokens in the project's technology (CSS variables / Tailwind theme / Flutter
`ThemeData`) plus a short `docs/identity.md`: product and audience, brand personality, palette with roles,
type scale, radius/shadow/spacing/motion scales, and 5 do/don't lines. **Any new colour, radius, shadow
or font must be added to the lock first** and pass the Anti-Over gate. Dashboards use the same lock (§12 of
`08-dashboard.md`).

---

## 2. Tokens (single source of truth)

```
Color (semantic)        Typography (family, weights, sizes, line-heights)
Spacing scale           Radius scale (sm/md/lg/xl/full)
Shadow/elevation        Breakpoints & container widths
Motion durations/easing Z-index layers · icon sizes · component heights
```

Never scatter raw values through components: `color.text.primary`, not `#123456` or `darkGray2`. Never
use colour as the only signal for error/success/selection/disabled — add icon, text or shape. Semantic
meaning is stable: red is always destructive/error.

Type: a small scale (display, h1–h3, body-lg/body/body-sm, caption, label) and a small weight scale
(400/500/600/700). **Fluid sizing** with `clamp()` so type and spacing scale between breakpoints instead
of jumping. Cap reading width (~60–75 characters) at every size, including 4K.
Radius, shadow and spacing: related components share values (button ≈ input ≈ select; card ≈ modal), on a
consistent rhythm (e.g. a 4/8 px base). Not a new value per component.

---

## 3. Look and feel — restraint is the premium signal

- Generous whitespace; few elements, each with one job; one clear focal point per screen and **one dominant action**.
- A strong typographic hierarchy does most of the work; imagery is large, confident and high quality; chrome is minimal.
- One accent colour used sparingly; subtle shadows; gradients and glass effects only where they carry meaning.
- Precise alignment to the grid; identical treatment of identical things everywhere (same card, same button, same spacing) — consistency reads as quality.
- Copy is part of design: short, plain, consistent labels; useful empty and error text.

---

## 4. Devices and responsive — smallest supported width through large displays

Design fluid, not per-device. Verify at these **CSS-pixel widths**, both orientations:

| Tier | Width | Notes |
|---|---|---|
| Watch glance | ~136–230 | Applies only if the product targets watches. Real watchOS/Wear OS apps are native, separate targets — a web/Flutter phone UI does not run there. For web: never break down to this width; a single-column, one-action view. |
| Smallest phone | 280–320 | iPhone 4/SE(1) ≈ 320; foldable cover ≈ 280. The defensible minimum for a full UI. |
| Phone | 360–480 | Most Android/iPhone sizes. |
| Large phone / foldable open / small tablet | 600–840 | |
| Tablet | 768–1024 | iPad 768/820/834/1024; portrait and landscape; split-screen and resizable windows. |
| Laptop / desktop | 1280–1920 | |
| QHD / ultrawide | 2560–3440 | |
| 4K / large display / wall TV (e.g. a 128" 4K panel) | 3840 | Cap content width, scale type fluidly, keep focus-driven navigation and large targets for 10-foot use. Do not stretch every element to fill the panel. |

**Techniques:** `clamp()` type and spacing tokens · CSS grid with `auto-fit/minmax` · container queries for
components · `min()/max()` widths · logical properties · `dvh` and safe-area insets · `aspect-ratio` ·
`srcset/sizes` images · flexible text containers, never fixed pixel widths for text. Flutter: layout from
available constraints (`LayoutBuilder`), not device-type or orientation assumptions.

**Responsive is not shrinking.** Adapt layout, density, navigation and content order. Buttons, cards, text
and icons all scale from tokens; touch targets ≥ 44×44 pt (48 dp on Android) and adequately spaced at
every width. Two columns on phones only when each item stays readable (product tiles, simple stats) — not
for dense forms, long text or wide tables.

**Never allow:** horizontal page overflow, clipped buttons, unreachable fields, broken modals, overlapping
text, or a permanently hidden critical action, at any supported width. If a component cannot fit, redesign
it — no CSS hack.
- **Tables:** a planned mobile strategy (scroll container, column priority, stacked rows, card transform).
- **Forms:** full-width fields, visible labels, logical grouping; never a desktop two-column form at 320 px.
- **Navigation:** sidebar → drawer/rail/bottom bar on small screens; same destinations, same order.
- **Safe areas:** notches, status bars, home indicators, dynamic island via the platform mechanism.

**Overflow tests for every text-bearing component:** long text, long number, long URL, Arabic, English,
empty value, huge count.

---

## 5. Components

Define once per component: default, hover, focus, pressed, disabled, loading. Related components share geometry.

- **Focus:** never remove the outline without an equally visible replacement; keyboard reaches everything in a sensible order.
- **Hover:** never the only way to trigger something essential — touch has no hover.
- **Disabled:** stays legible; explain why when useful.
- **Destructive actions:** distinct treatment, confirmation proportional to risk, undo where practical; do not confirm trivial actions.
- **Empty states:** what is empty, why, what to do next. **Loading:** distinguish initial / refresh / mutation / background; skeleton geometry matches the content to avoid layout shift. **Errors:** plain language, name the field/action, suggest recovery, preserve entered data — never a raw `500` as the only message.
- One implementation per component; variants via props/tokens, not copies. Extract only at the reuse threshold (used ≥ 3 times or clearly shared).

---

## 6. Motion, depth and 3D — expressive, but on a budget

Motion needs a reason: feedback, state change, continuity, hierarchy, loading progress. A small **motion
system** — 2–3 durations (e.g. ~120–160 / 200–280 / 350–500 ms) and 2–3 easings, reused everywhere, so a
dropdown, a modal and a tooltip feel like one product. Stronger motion only for major context changes.

**Rich effects are welcome when they earn their place** — scroll-linked reveals, layered depth/parallax
(2–3 layers, subtle), card tilt/flip, product or hero 3D — under these rules:
- Animate `transform` and `opacity` only; never layout or large paints. Target a steady 60 fps on a mid-range phone; verify, do not assume.
- **3D:** CSS `perspective` + `transform-style: preserve-3d` for tilt/flip; WebGL/three.js or a model viewer only for a hero/product view that justifies it. Lazy-load behind `IntersectionObserver` or dynamic import, ship a static poster as the first paint and fallback, pause when off-screen, compress models/textures (glTF + Draco/KTX2) and keep the asset small.
- **Never block LCP, INP or the primary task.** Effects load after content. Skip or simplify on `prefers-reduced-motion`, `saveData`, low-power and low-end devices.
- Not on every card, row or item; no perpetual decorative loops, aggressive springs, or large entrances for routine actions.

Ambitious visuals are allowed; they are gated by performance, accessibility and one question: what does
this animation do for the user?

---

## 7. Accessibility (built in, not a final patch)

- Contrast verified for text, controls and focus indicators, in both light and dark mode.
- Full keyboard operability with a visible focus indicator; logical focus order; dialogs trap and restore focus.
- Semantic HTML / correct platform semantics; a label on every form control; meaningful `alt` (empty `alt=""` for decorative only).
- Icon-only controls get an accessible name (and a tooltip on desktop).
- Nothing conveyed by colour alone; respect text scaling and zoom without breaking layout.

---

## 8. Dark mode (if supported)

Deliberate tokens for background, surfaces, elevation, text, borders, semantic colours and shadows — never
a blind inversion. Same identity, same semantics; adapt only what the appearance truly requires. Verify
contrast in both modes.

---

## 9. Icons

One coherent icon family and style. Do not mix outline + filled + emoji + several packs. Icons mean what
they do; icon-only controls get labels. In RTL, mirror only directional icons (arrows, chevrons, progress),
never logos, media controls or symbols like a clock/checkmark.

---

## 10. Brand-imitation prohibition

Do not copy a recognizable company's distinctive interaction, motion, navigation, iconography or colour
language — including the companies whose *quality* you are aiming for. Take the principles (restraint,
consistency, rhythm, motion discipline), keep the identity your own, derived from the project's logo.

---

## 11. Flutter / mobile

- Adaptive layout from available space; `const` constructors; no work in `build()` (`03-performance.md` §4).
- Cold start, warm start, screen transition are the perceived-quality metrics — profile in release/profile mode.
- Respect safe areas, dynamic type/font scaling and OS reduced-motion; one `ThemeData` from the Identity Lock, no per-screen hardcoded colours; `Directionality` from locale.

---

## 12. Over-design guards (each new one must pass the Anti-Over gate)

Over-animation · over-components (a component for a one-off) · over-files · over-tokens · over-colour ·
over-radius · over-shadow · over-gradient · over-glass · over-icon · over-tooltip · over-modal ·
over-notification · over-responsive (per-device layouts instead of a fluid system). If the product feels
busy, remove before adding.

---

## 13. Definition of done for a UI change

Works from the smallest supported width to the largest and in both orientations; keyboard and touch both
operate it; focus visible; loading/empty/error/success exist; motion is purposeful, budgeted and respects
reduced-motion; colours, type, spacing and radius come from the Identity Lock (no one-off values); dark
mode (if present) uses the same identity; RTL and LTR both render correctly if bilingual
(`07-i18n-rtl.md`); nothing overflows with long or Arabic content.

Deep detail (read by section, never whole) in `deep/DesignGuard.md`: identity/tokens §2–§13 · gestalt/grid
§21–§26 · UX laws §39–§43 · states/components §64–§90 · file structure §112–§125 · test matrices §133–§139 ·
performance §143–§149 · QA and drift §154–§158, §219–§229 · design-system rollout §190–§202.
