# Design — Visual Identity, Responsive, Motion, Accessibility

Read when the task touches visual identity, design tokens, components, layout, responsiveness, motion,
or accessibility — web or Flutter/mobile.

Before changing UI: infer the project's **existing** visual language and preserve it unless a redesign
was explicitly requested. Do not invent a new brand when a valid one already exists. Once established,
treat colors, typography, radius, shadows, spacing, and motion as a **project-level constraint** — no
page invents its own styling language.

---

## 1. Token system (single source of truth)

Define once, reuse everywhere — never scatter raw values through components:

```
Color (semantic, not literal hex)   Typography (family, weight, size, line-height)
Spacing scale                        Border radius scale
Shadow/elevation scale               Breakpoints
Motion durations & easing            Z-index/layer levels
```

**Color** is semantic: `color.text.primary`, not `darkGray2`. Roles: primary, secondary, accent,
background, surface, text (primary/secondary/muted), border, success, warning, error, info, focus,
disabled. Never use color as the *only* signal for error/success/selection/disabled — pair it with an
icon, text, or shape. Keep semantic meaning stable: red is always destructive/error, never also a random
decoration.

**Typography**: one primary font family (a secondary/display family only if identity truly benefits), a
small type scale (display/h1/h2/h3/body-lg/body/body-sm/caption/label), a small weight scale (e.g.
400/500/600/700). Comfortable line length for reading content — cap width even on 4K screens.

**Radius/shadow/spacing**: a small deliberate scale (e.g. `radius-sm/md/lg/xl/full`), reused
consistently by related components (button ≈ input ≈ select; card ≈ modal). Not a new value per
component.

---

## 2. Layout & responsive — smallest supported width through 4K

Test approximately: `320 360 375 390 414 480 600 768 820 1024 1280 1440 1920 2560 3840` px, both
orientations, foldables/split-screen/resizable windows where the platform supports them.

Responsive is not shrinking — adapt layout, density, navigation, and content order, not just size.

**Never allow:** horizontal page overflow, clipped buttons, unreachable fields, broken modals, text
overlap, or a permanently hidden critical action, at any supported width. If a component cannot fit
naturally, redesign the component — do not force a CSS hack.

**Tables**: plan a real mobile strategy (scroll, column priority, stacked rows, card transform) — never
accidental page-wide overflow.

**Forms**: full-width fields on small screens, visible labels (not placeholder-only for important
fields), comfortable tap targets, logical grouping — never a forced desktop multi-column form at 320px.

**Large screens**: cap line length and content width; do not simply stretch every element to fill a 4K
display.

**Touch targets**: comfortable and adequately spaced (roughly 44×44pt as a default, never shrink below a
usable minimum to preserve desktop density).

**Safe areas**: respect notches, status bars, home indicators, dynamic island — use the platform's
safe-area mechanism, not a fixed pixel guess.

---

## 3. Components

Define once per component: default, hover, focus, pressed, disabled, loading states. Consistent geometry
across related components. One dominant action per screen — not five equally prominent buttons.

- **Focus**: never remove the outline without an equally visible replacement. Keyboard navigation must reach every interactive element in a sensible order.
- **Hover**: never the *only* way to trigger something essential — touch has no hover.
- **Disabled**: stays legible (no illegible low-opacity text); explain *why* when useful, rather than just disabling silently.
- **Destructive actions** (delete, cancel subscription, revoke access): distinct visual treatment from safe actions, confirmation proportional to the risk, undo where practical. Don't confirm trivial actions excessively.
- **Empty states**: answer what's empty, why, and what to do next — never a blank screen.
- **Loading states**: distinguish initial load / refresh / mutation / background update; don't block the whole screen for a small background request; skeleton geometry should roughly match the real content to avoid layout shift.
- **Errors**: explain what happened in plain language, identify the field/action, suggest recovery, preserve entered data. Never show a raw `500 Internal Server Error` as the only message.

---

## 4. Motion

Motion needs a reason — feedback, state change, continuity, hierarchy, loading progress. "Because
animation exists" is not a reason. Small motion system: 2–3 durations, 2–3 easings, reused consistently.
Similar interactions feel similar (dropdown/modal/tooltip open shouldn't each feel like a different
product). Respect `prefers-reduced-motion` / OS reduced-motion — remove non-essential movement, autoplay,
parallax when set. Avoid animating every card/row/item in a list.

---

## 5. Accessibility (built in, not a final patch)

- Sufficient contrast for text, controls, and focus indicators, in both light and dark mode — verify, don't eyeball on one monitor.
- Full keyboard operability with a visible focus indicator.
- Semantic HTML / correct platform semantics for screen readers; labels on every form control; meaningful alt text (empty `alt=""` for decorative images only).
- Icon-only controls get an accessible label and, on desktop, a tooltip — never assume a symbol is universally understood.
- No information conveyed by color alone.
- Respect dynamic text scaling and zoom without breaking layout.

---

## 6. Dark mode (if supported)

Deliberate tokens for background, surfaces, elevated surfaces, text, borders, semantic colors, and
shadows — never a blind color inversion. Preserve brand identity, semantic meaning, typography, radius
and spacing; only adapt what the appearance genuinely requires.

---

## 7. Icons

One coherent icon family/style. Never mix outline + filled + emoji + multiple packs without a real
reason. Icons communicate their action (search→search, delete→trash) — never a decorative icon with
ambiguous meaning standing in for an unclear action.

---

## 8. Brand-imitation prohibition

Do not copy a recognizable competitor's distinctive interaction/motion/navigation/icon/color language
(no WhatsApp-style chat motion, no Stripe-branded visual language, etc.). Platform-generic conventions are
fine; a proprietary, recognizable identity is not.

---

## 9. Flutter/mobile specifics

- Adaptive layout responds to *available space*, not a device-type or orientation assumption.
- `const` constructors wherever the widget is constant; no work inside `build()` (see `03-performance.md` §4).
- Cold start, warm start, screen transition are the metrics that matter for perceived quality — profile in release/profile mode.
- Respect safe areas and OS-level reduced-motion settings.

---

## 10. Definition of done for a UI change

Works from the smallest supported width to the largest; keyboard and touch both operate it; focus is
visible; loading/empty/error/success states all exist; motion is purposeful and respects reduced-motion;
colors/typography/spacing/radius come from the existing token system, not new one-off values; dark mode
(if the product has it) uses the same identity; and RTL/LTR both render correctly if the product is
bilingual (see `07-i18n-rtl.md`).
