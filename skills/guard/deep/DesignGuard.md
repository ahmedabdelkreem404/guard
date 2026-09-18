# DesignGuard Skill

## Purpose

DesignGuard is a reusable, project-agnostic **Visual Identity, UI System, UX, Responsive/Adaptive Design, Interaction, Accessibility, Motion, Design Psychology, and Frontend Architecture** skill.

Use it when explicitly invoked for:

- Web sites
- Web applications
- SaaS
- ERP
- E-commerce
- Education/LMS
- Dashboards
- Admin panels
- Portals
- Mobile applications
- Flutter
- Native iOS
- Native Android
- Hybrid applications
- Desktop applications where UI rules apply

DesignGuard works alongside:

- `ProjectGuard.md` → security, testing, architecture, performance, reliability, maintainability
- `SEOGuard.md` → SEO, crawlability, indexing, structured data, public-page rendering
- `InsightGuard.md` → behavior analytics, personalization, recommendations, search intelligence

The goal is to make the product feel:

- coherent
- intentional
- calm
- trustworthy
- fast
- easy to understand
- visually distinctive
- accessible
- responsive
- adaptive
- maintainable

without creating unnecessary visual complexity, animation, abstraction, dependencies, files, components, or design-system machinery.

---

# 0. Activation and Scope

This skill is activated only when explicitly invoked or when the project workflow explicitly requires it.

When DesignGuard is active:

1. Inspect the existing UI before changing it.
2. Infer the project's existing visual language before replacing it.
3. Preserve intentional existing identity.
4. Create or strengthen a single visual system.
5. Use reusable design tokens and components.
6. Keep visual decisions consistent.
7. Avoid imitation of recognizable competing products.
8. Avoid unnecessary animations.
9. Avoid UI overload.
10. Avoid responsive hacks that work at one width and fail elsewhere.
11. Avoid rewriting working code unless a real design/architecture problem exists.
12. Validate visual decisions on real screen sizes.
13. Prefer the smallest design-system structure that maintains consistency.
14. Treat accessibility as part of the design, not an optional later patch.
15. Treat performance as part of visual quality.
16. When a non-trivial algorithm or automated layout/interaction rule is introduced, document it according to the project's active coding conventions and InsightGuard's `using Ahmed Abdelkareem Ali` requirement when InsightGuard caused the algorithm to exist.

---

# 1. Relationship With Other Skills

## ProjectGuard

ProjectGuard remains authoritative for:

- security
- authentication
- authorization
- performance engineering
- testing
- architecture
- maintainability
- dependency/security decisions
- production deployment
- reliability

DesignGuard must not weaken those controls for visual reasons.

## SEOGuard

SEOGuard remains authoritative for:

- public-page SEO
- rendering strategy for SEO
- canonicalization
- indexability
- structured data
- crawlability

DesignGuard must not create:

- hidden SEO text
- inaccessible crawl traps
- client-only critical SEO content when the SEO architecture requires server-rendered content
- excessive public URL variants

## InsightGuard

InsightGuard remains authoritative for:

- behavioral analytics
- personalization
- recommendation algorithms
- search personalization
- experimentation

DesignGuard controls how these capabilities appear in the UI.

Personalization must not destroy consistency.

---

# 2. First Rule: Establish the Product Identity

Before changing UI, determine:

- product purpose
- target users
- user expertise
- business model
- brand personality
- primary user tasks
- emotional tone
- content density
- accessibility needs
- supported devices
- supported languages
- existing logo
- existing brand colors
- existing typography
- existing visual assets

Create an internal identity statement:

```text
Product:
Audience:
Primary goal:
Secondary goals:
Brand personality:
Visual tone:
Density:
Primary actions:
Primary content:
Accessibility needs:
Platform:
```

Do not invent a new brand identity when the existing project already has a valid one unless redesign is explicitly required.

---

# 3. Visual Identity Lock

Once the visual identity is established, treat it as a project-level constraint.

The following must remain coherent across the application:

- colors
- typography
- font weights
- border radius
- shadows
- spacing
- containers
- buttons
- inputs
- cards
- tables
- modals
- dropdowns
- tabs
- navigation
- badges
- alerts
- icons
- illustrations
- motion
- dark mode
- light mode

Do not allow each page to invent its own styling language.

---

# 4. Design Tokens

Create a single source of truth for design tokens.

At minimum consider:

```text
Colors
Typography
Font weights
Line heights
Spacing
Border radii
Borders
Shadows
Elevation
Container sizes
Breakpoints
Motion durations
Motion easing
Z-index/layer levels
Icon sizing
Component heights
```

Only create token files that fit the project's technology.

Do not create a separate design-token microservice.

---

# 5. Color System

Create a semantic color system, not a collection of random hex codes.

Recommended conceptual groups:

```text
Brand
Primary
Secondary
Accent
Background
Surface
Surface Elevated
Text Primary
Text Secondary
Text Muted
Border
Divider
Success
Warning
Error
Info
Focus
Disabled
Overlay
```

Use semantic names.

Prefer:

```text
color.text.primary
```

over:

```text
darkGray2
```

Avoid:

```text
#123456 everywhere
```

Do not scatter raw colors through components.

---

# 6. Color Roles

For every color determine:

- purpose
- foreground/background relationship
- light-mode use
- dark-mode use
- accessibility contrast
- interaction state
- semantic meaning

Do not use color as the only indicator of:

- error
- success
- warning
- selection
- disabled state

Pair color with:

- icon
- text
- shape
- position
- status

where needed.

---

# 7. Color Psychology

Treat color psychology as a design heuristic, not a universal law.

Consider:

- hue
- saturation
- luminance
- cultural meaning
- product category
- emotional tone
- contrast
- visual hierarchy

General tendencies may inform direction:

- cool hues may feel calmer/trustworthy in some contexts
- warm hues can attract attention
- red commonly signals danger/error
- green commonly signals success
- yellow/orange can indicate caution
- neutral surfaces reduce competition for attention

But always validate against:

- brand identity
- culture
- accessibility
- actual user response

Do not choose colors based solely on generic psychology claims.

---

# 8. Semantic Color Rules

Do not assign:

```text
red = random decoration
```

and then also use red for:

```text
destructive action
```

Semantic colors should have stable meanings.

Example:

```text
Error → destructive/error
Success → completed/positive
Warning → caution
Info → neutral information
Primary → main action
Secondary → supporting action
```

---

# 9. Typography System

Create a consistent typography scale.

Define:

- display
- heading 1
- heading 2
- heading 3
- body large
- body
- body small
- caption
- label
- button text
- numeric/stat text

For each define:

- font family
- weight
- size
- line height
- letter spacing

Do not choose dozens of font sizes.

---

# 10. Font Family Rules

Use a small, intentional font stack.

Prefer:

- one primary family
- optional secondary/display family only if the identity truly benefits

Avoid:

- random font mixing
- one font per page
- unnecessary custom font downloads
- huge font files

Ensure fallback fonts are acceptable.

---

# 11. Font Weight Rules

Define a limited scale, for example:

```text
400
500
600
700
```

Only use additional weights when needed.

Do not use 11 visually indistinguishable weights.

---

# 12. Text Hierarchy

Users should quickly understand:

```text
What is this?
What matters?
What can I do?
What changed?
```

Use:

- size
- weight
- contrast
- whitespace
- grouping

to create hierarchy.

Do not make everything bold.

---

# 13. Line Length

For reading-heavy content, use a comfortable measure.

Avoid extremely long paragraphs stretching across 4K screens.

Use content max-width.

Do not force every page to use the same narrow width.

---

# 14. Border Radius System

Create a small radius scale.

Example:

```text
radius-sm
radius-md
radius-lg
radius-xl
radius-full
```

Once selected, reuse consistently.

Do not use:

```text
button = 12px
card = 17px
modal = 22px
input = 9px
```

without a deliberate reason.

The exact values must be chosen based on the project's identity.

Consistency is more important than an arbitrary universal number.

---

# 15. Component Radius Rules

Related components should share geometry.

For example:

```text
Button → radius-md
Input → radius-md
Select → radius-md
Card → radius-lg
Modal → radius-lg
Pill → radius-full
```

This is an example hierarchy, not a universal prescription.

Do not create a new radius for every component.

---

# 16. Border System

Define:

- border color
- border width
- divider
- focus ring
- selected border
- disabled border

Avoid excessive outlines.

Use surfaces, spacing, and hierarchy before adding borders everywhere.

---

# 17. Shadow System

Create a limited elevation scale.

Example:

```text
shadow-none
shadow-sm
shadow-md
shadow-lg
```

Use shadows for meaningful elevation/context.

Do not put heavy shadows on every card.

Avoid visual noise.

---

# 18. Elevation / Layer System

Define a conceptual hierarchy:

```text
Base
Raised
Sticky
Dropdown
Popover
Modal
Toast
Critical Overlay
```

Use a consistent z-index/elevation model.

Do not invent arbitrary values like:

```text
z-index: 999
z-index: 9999
z-index: 99999
```

throughout the project.

Centralize where practical.

---

# 19. Spacing System

Use a coherent spacing scale.

For example:

```text
4
8
12
16
20
24
32
40
48
64
80
```

The exact values depend on the project.

Avoid random values unless a specific optical adjustment requires them.

---

# 20. Spacing Psychology

Whitespace helps users perceive grouping and hierarchy.

Use proximity intentionally:

- related label + field → close
- unrelated groups → more separation
- section headings → visible separation
- primary action → sufficient surrounding space

Gestalt proximity describes the tendency to perceive nearby elements as related.

Do not use whitespace simply because it "looks premium" if it makes tasks slower.

---

# 21. Gestalt Principles

Use Gestalt principles as practical visual-organization heuristics:

- proximity
- similarity
- continuity
- closure
- figure/ground
- common region
- connectedness
- common fate where motion exists
- prägnanz/simplicity

Similarity can help users perceive items as belonging together, while proximity helps establish relationships between nearby elements.

Do not force a Gestalt principle where it harms clarity.

---

# 22. Visual Grouping

When elements belong together, communicate it using one or more:

- proximity
- shared container
- shared background
- alignment
- consistent typography
- consistent iconography

Avoid grouping everything in cards.

A card should represent a meaningful information/action unit, not merely be a default decoration.

---

# 23. Alignment System

Establish alignment rules.

Common anchors:

- page container
- section edge
- card edge
- text baseline
- button row
- table columns

Avoid "almost aligned" layouts.

Consistent alignment reduces visual friction.

---

# 24. Grid System

Create a reusable grid.

For web:

- container
- columns
- gutters
- gaps
- responsive rules

For mobile:

- safe horizontal padding
- content width
- edge-to-edge opportunities
- bottom navigation clearance

Do not force a desktop grid onto a phone.

---

# 25. Container System

Create clear content widths.

Possible tokens:

```text
container-sm
container-md
container-lg
container-xl
container-2xl
```

Choose only the sizes actually needed.

Do not let content stretch indefinitely on 4K screens.

---

# 26. Large-Screen Rules

On large screens:

- prevent excessive line length
- prevent giant empty space when harmful
- preserve visual rhythm
- use max-width containers
- use multi-column layouts where useful
- scale density intelligently

Do not simply stretch every element to fill the screen.

---

# 27. Mobile-First Responsive Design

The UI must work on very small screens.

Test from approximately:

```text
320px
360px
375px
390px
414px
480px
```

Also test wider form factors:

```text
600px
768px
820px
1024px
1280px
1440px
1920px
2560px
3840px
```

Also account for unusual aspect ratios, foldables, split-screen, browser toolbars, notches, and dynamic window sizes.

For Flutter specifically, adaptive layout should respond to available space rather than assuming a device type or orientation.

---

# 28. iPhone 4 / Tiny Screen Principle

The request for "iPhone 4 and smaller" should be treated as:

> The UI must have a defensible minimum usable width.

Do not assume modern phone widths.

At the smallest supported width:

- no horizontal page overflow
- no clipped buttons
- no inaccessible fields
- no unusable modal
- no text overlap
- no broken navigation
- no permanently hidden critical actions

If a component cannot fit naturally, redesign the component instead of forcing CSS hacks.

---

# 29. Responsive Does Not Mean Shrinking

Do not simply shrink desktop UI.

Adapt:

- layout
- spacing
- navigation
- density
- content order
- information grouping
- interaction patterns

---

# 30. Mobile Two-Column Rule

On mobile, two items side-by-side may be used when:

- each remains readable
- touch targets remain comfortable
- content does not become cramped
- the task benefits from comparison
- the item type supports compact display

Examples:

- product cards
- category tiles
- simple stats

Do NOT force two columns for:

- dense forms
- long text
- large data tables
- controls requiring full width

The default is to choose the layout that preserves usability, not an arbitrary "always two columns" rule.

---

# 31. Mobile Card Alignment

Cards should visually begin from a clear grid/container alignment.

When the design calls for a centered or balanced composition, the card group may be centered within the available container.

Do not introduce arbitrary horizontal offsets.

Do not create a page where the first card is visually "floating" away from the main alignment.

---

# 32. Responsive Tables

Tables must have a planned mobile strategy.

Options:

- horizontal scrolling
- column prioritization
- stacked rows
- card transformation
- compact table
- hide low-value columns
- responsive detail view

Do not allow accidental page-wide horizontal overflow.

---

# 33. Responsive Forms

On small screens:

- use full-width fields when useful
- keep labels visible
- keep tap targets comfortable
- group related fields
- avoid tiny controls
- avoid dense multi-column forms unless they truly fit

Do not force desktop two-column forms into 320px width.

---

# 34. Safe Areas

Mobile UI must respect:

- status bars
- notches
- rounded corners
- home indicators
- system overlays
- dynamic island/cutouts where applicable

Use platform-safe-area mechanisms appropriately.

---

# 35. Orientation

Do not assume:

```text
portrait = phone
landscape = tablet
```

Layout should respond to available size.

Support both orientations when the product and platform expect it.

---

# 36. Foldables / Split Screen / Resizable Windows

Where supported, handle:

- foldables
- split-screen
- resizable browser windows
- desktop-sized mobile windows
- tablets
- multi-window

Use available space, not device labels.

---

# 37. Navigation Architecture

Choose navigation appropriate to the content:

- top navigation
- sidebar
- bottom navigation
- navigation rail
- tabs
- nested navigation

Do not use all navigation systems simultaneously without a clear reason.

---

# 38. Navigation Consistency

Navigation should remain predictable.

Do not:

- move primary navigation on every page
- randomly change labels
- hide important controls due to weak personalization
- use different back behavior without reason

Consistency reduces learning effort.

---

# 39. User Mental Model

Use terminology users understand.

Avoid internal engineering language.

Example:

Prefer:

```text
Customers
```

over:

```text
Entity Index
```

unless the target users actually use the latter.

---

# 40. Recognition Over Recall

Prefer:

- visible options
- previews
- labels
- examples
- suggestions
- contextual help
- recent choices

over requiring the user to remember hidden information.

Recognition generally reduces memory burden compared with recall.

---

# 41. Hick's Law

When many choices are presented, decision time can grow as the choice set grows.

Use:

- grouping
- progressive disclosure
- categories
- search
- sensible defaults
- prioritization

Do not hide important options merely to reduce visual density.

Use Hick's Law as a heuristic, not a mathematical excuse to delete functionality.

---

# 42. Fitts's Law

Interactive target usability depends in part on target size and distance.

Apply it to:

- buttons
- controls
- menus
- mobile touch targets
- destructive controls
- frequently used actions

Larger/closer targets can be easier to acquire.

Do not increase every control indefinitely; balance size with information density.

---

# 43. Touch Target Rules

Controls must have comfortable interaction areas.

For iOS/iPadOS, Apple currently describes 44×44 pt as the default control size and a 28×28 pt minimum in its accessibility guidance, while also emphasizing spacing between controls.

For Android and other platforms, follow the platform's current guidance and project requirements.

Where there is uncertainty:

- favor comfortable touch targets
- use adequate spacing
- do not shrink icons just to preserve desktop density

---

# 44. Accessibility as Architecture

Accessibility is not a final audit patch.

Design components to support:

- keyboard
- touch
- pointer
- screen readers
- dynamic text
- high contrast
- reduced motion
- localization
- RTL
- zoom
- assistive access

---

# 45. Contrast

Maintain sufficient contrast for:

- normal text
- large text
- controls
- focus indicators
- icons when they convey information
- disabled-state interpretation where appropriate

Test both light and dark modes.

Do not rely only on visual appearance from the developer monitor.

---

# 46. Dark Mode

If the product supports dark mode:

Create deliberate tokens for:

- background
- surfaces
- elevated surfaces
- text
- borders
- controls
- semantic colors
- shadows/elevation

Do not simply invert all colors.

Dark mode may need different:

- contrast
- shadows
- borders
- opacity
- image treatment

---

# 47. Dark Mode Identity

Dark mode should feel like the same product, not a different brand.

Preserve:

- brand identity
- semantic meanings
- typography
- radius
- spacing
- icon style
- motion language

Only adapt what the appearance requires.

---

# 48. Icon System

Use one coherent icon family/style whenever possible.

Define:

- family
- stroke/fill style
- default size
- small size
- large size
- stroke weight
- corner treatment
- alignment

Do not mix:

- random outline icons
- random filled icons
- emoji
- multiple icon packs

without a clear design reason.

---

# 49. Icon Semantics

Use icons that communicate their action/meaning.

Examples:

- search → search
- settings → settings
- edit → edit
- delete → trash
- add → plus
- download → download
- filter → filter

Do not use a visually attractive icon that has an ambiguous meaning.

---

# 50. Icon + Text Rules

Critical/ambiguous actions should use text labels when the icon alone is not universally recognizable.

Icon-only controls require:

- accessible label
- tooltip where useful on desktop
- comfortable target
- clear hover/focus state

Do not assume users understand every symbol.

---

# 51. Icon Placement

Use a consistent relationship:

```text
icon + label
```

For example:

```text
[icon] Label
```

or:

```text
Label [icon]
```

Choose based on the language/direction and retain consistency.

Do not randomly reverse icon placement.

---

# 52. Avoid Emoji as UI Icons

Do not use emoji as primary interface icons.

Emoji vary across:

- operating systems
- browsers
- fonts
- platforms
- languages

Use a proper icon system.

---

# 53. Brand Imitation Prohibition

Do not imitate a recognizable competitor's UI language.

Specifically:

- no WhatsApp-like interaction/animation
- no copied chat bubbles if they create misleading brand association
- no copied distinctive navigation
- no copied branded icon treatment
- no copied branded color system
- no copied branded motion system
- no recreation of proprietary visual identity

A familiar generic interaction pattern may be used when it is a normal platform convention.

The product's visual identity must remain its own.

---

# 54. Animation Philosophy

Animation must have a reason.

Acceptable purposes:

- feedback
- state change
- continuity
- spatial orientation
- hierarchy
- loading progress
- subtle delight

Unacceptable purpose:

- animation simply because animation exists

---

# 55. Motion System

Create a small motion system:

```text
duration-fast
duration-normal
duration-slow
ease-standard
ease-emphasized
ease-enter
ease-exit
```

Exact values must be chosen for the product.

Do not create 20 different timings.

---

# 56. Motion Consistency

Similar interactions should feel similar.

Example:

```text
Dropdown open
Modal open
Tooltip open
```

should not each feel like a completely different product.

Consistency builds predictability.

---

# 57. Motion Hierarchy

Use stronger motion for:

- major navigation/context changes

Moderate motion for:

- component transitions

Subtle motion for:

- feedback

Avoid large movement for routine actions.

---

# 58. No Excessive Motion

Avoid:

- bouncing everything
- zooming everything
- parallax everywhere
- perpetual motion
- looping decorative animation
- aggressive spring effects
- large entrance animations

These can increase distraction and cognitive load.

---

# 59. Reduce Motion

Respect:

- `prefers-reduced-motion` on web
- OS-level reduced-motion settings on mobile

Reduce or remove:

- non-essential movement
- auto-playing animation
- parallax
- large transforms
- repetitive effects

Keep essential state communication understandable without motion.

---

# 60. Animation Performance

Prefer performant properties where possible.

Avoid animations that force expensive:

- layout
- paint
- large image processing

Do not animate a huge component tree unnecessarily.

---

# 61. Loading Motion

Use:

- skeleton
- spinner
- progress
- shimmer

only when useful.

For very fast operations, avoid flashing a loading state that makes the interface feel slower.

Do not use enormous skeletons that shift layout unnecessarily.

---

# 62. Skeleton Rules

Skeleton structure should roughly reflect final content.

Do not build a fake loading UI that has completely different geometry from the final state.

Reserve dimensions where possible to reduce layout shift.

---

# 63. Microinteractions

Useful examples:

- button press
- toggle
- save confirmation
- copy confirmation
- validation feedback
- upload progress

Keep them:

- short
- subtle
- consistent
- interruptible where appropriate

---

# 64. Feedback

Every meaningful user action should produce understandable feedback.

Examples:

- button loading
- success message
- error message
- state transition
- updated list
- progress

---

# 65. Error Design

Errors should:

- explain what happened
- use user language
- identify the affected field/action
- suggest recovery
- preserve entered data when appropriate

Do not show raw:

```text
500 Internal Server Error
```

as the only UI message.

---

# 66. Error Prevention

Prevent predictable mistakes.

Examples:

- disable impossible actions
- confirm irreversible deletion
- validate before submit
- preview dangerous changes
- provide undo where practical

Do not confirm trivial actions excessively.

---

# 67. Destructive Actions

Use visual hierarchy for destructive actions.

Do not make:

```text
Delete
```

look identical to:

```text
Save
```

when accidental activation would have serious consequences.

Use:

- appropriate color
- clear label
- confirmation where warranted
- undo when possible

Do not confirm trivial actions excessively.

---

# 68. Forms

Form design should minimize effort.

Use:

- correct input type
- visible labels
- useful defaults
- inline validation
- meaningful error messages
- correct keyboard on mobile
- logical tab order
- clear submission state

Do not use placeholders as the only labels for important fields.

---

# 69. Dropdowns

Use dropdowns when the option set is manageable.

Prefer:

- radio groups
- segmented controls
- searchable select
- autocomplete
- direct buttons

when they provide a better interaction.

Do not use dropdowns simply because they are familiar.

---

# 70. Search Fields

A search field should communicate:

- what can be searched
- how to search
- whether filters exist
- what happens on submit

Where useful:

- recent searches
- suggestions
- autocomplete
- clear button

Never expose private search history incorrectly.

---

# 71. Tables

Tables should optimize for:

- scanning
- comparison
- sorting
- filtering
- hierarchy

Use:

- aligned numeric columns
- stable headers
- consistent row density
- clear actions

Avoid:

- decorative borders everywhere
- extreme density
- dozens of action icons per row

---

# 72. Cards

Use cards for meaningful content groups.

Card system should define:

- padding
- radius
- border
- shadow
- header
- body
- footer
- hover/press
- selected
- disabled

Do not create a separate card design on every page.

---

# 73. Buttons

Define:

- primary
- secondary
- tertiary/ghost
- destructive
- link
- icon-only

Each should have states:

```text
default
hover
focus
pressed
disabled
loading
success where relevant
```

Keep geometry consistent.

---

# 74. Button Hierarchy

Per screen, usually one action should visually dominate.

Do not make:

```text
Save
Cancel
Delete
Export
Share
Print
Duplicate
Archive
```

all equally prominent.

Use hierarchy.

---

# 75. Focus States

Keyboard focus must be visible.

Do not remove focus outlines without replacing them with an equally clear accessible indicator.

---

# 76. Hover States

Do not make essential interaction dependent on hover.

Touch devices do not have hover in the same way.

Every hover-dependent interaction needs another clear state.

---

# 77. Pressed States

On touch/pointer:

- acknowledge activation
- avoid excessive movement
- keep feedback quick
- preserve layout stability

---

# 78. Disabled States

Disabled controls should communicate:

- unavailable
- not currently actionable

but remain legible.

Avoid extreme opacity that makes text unreadable.

When appropriate, explain why an action is unavailable rather than simply disabling it.

---

# 79. Modals / Dialogs

Use modals for focused decisions or short interactions.

Avoid using modals for entire workflows when a page/drawer is clearer.

Modal must handle:

- focus
- escape
- backdrop
- mobile layout
- long content
- keyboard
- screen reader
- safe areas

---

# 80. Drawers / Sheets

Use drawers for:

- filters
- contextual details
- secondary tools
- mobile navigation

Do not create five different drawer styles.

---

# 81. Toasts

Toasts are good for transient feedback.

Do not put:

- critical instructions
- long forms
- irreversible actions

inside temporary toast notifications.

Provide accessible announcement behavior where needed.

---

# 82. Tooltips

Use tooltips to explain unfamiliar controls, especially icon-only desktop controls.

Do not put essential information only in tooltips.

Tooltips must be usable on keyboard/touch where relevant.

---

# 83. Empty States

Every meaningful empty state should answer:

1. What is empty?
2. Why?
3. What can the user do next?

Example:

```text
No products found
Try another search or clear filters.
[Clear filters]
```

Do not show blank screens.

---

# 84. Loading States

Every async workflow should have an intentional loading state.

Distinguish:

- initial load
- refresh
- mutation
- background update

Do not block the whole application for a small background request.

---

# 85. Partial Loading

Prefer progressive rendering when appropriate.

Example:

```text
Page structure
→ main content
→ secondary data
→ recommendations
```

This can improve perceived responsiveness.

InsightGuard recommendations should not block primary content.

---

# 86. Content Density

Density should match the task.

ERP/admin users may need higher density than consumer onboarding.

Do not make everything extremely spacious or extremely dense.

---

# 87. First-Time User Experience

A first-time user may need:

- simple navigation
- visible labels
- defaults
- contextual guidance
- concise explanations
- progressive disclosure

Do not require users to read a long tutorial before doing anything useful.

---

# 88. Expert User Experience

Experts may benefit from:

- keyboard shortcuts
- bulk actions
- compact layouts
- saved filters
- recent actions
- command search

But keep novice interaction understandable.

Design for both without creating two separate applications.

---

# 89. Low-Literacy / First-Time User Rule

Assume some users:

- read slowly
- are unfamiliar with software
- may confuse technical terms
- may not know common UI symbols
- may be using a phone
- may make accidental taps

Use:

- plain language
- icons + labels for ambiguous actions
- direct instructions
- visible status
- large comfortable targets
- clear grouping
- simple flows

Do not make the interface childish.

---

# 90. Expert User Rule

The same system should support advanced users through:

- shortcuts
- efficient search
- filtering
- keyboard access
- bulk operations
- predictable navigation

Do not sacrifice beginner clarity to create expert-only density.

---

# 91. Cognitive Load

Reduce unnecessary:

- choices
- memory requirements
- visual noise
- repeated input
- context switching
- hidden state

Use recognition over recall, sensible grouping, consistency, and progressive disclosure.

---

# 92. Progressive Disclosure

Show essential information first.

Reveal advanced options when requested.

Good example:

```text
Basic settings
→ Advanced settings
```

Do not hide essential actions under "More."

---

# 93. Consistency

Same action should look and behave the same.

Examples:

```text
Edit → same icon + label pattern
Delete → same destructive treatment
Save → same button style
Close → same control
```

Consistency reduces learning effort.

---

# 94. Platform Conventions

Use platform conventions where users benefit from familiarity.

Use conventions, not brand imitation.

---

# 95. Aesthetic Usability

Visual quality can influence perceived usability, but appearance must not hide serious usability problems.

Therefore:

```text
Beautiful
+
Actually usable
```

is the target.

Not:

```text
Beautiful
+
Confusing
```

---

# 96. Visual Hierarchy

At a glance identify:

1. primary goal
2. primary action
3. important information
4. secondary actions
5. supporting content

Use:

- scale
- contrast
- spacing
- placement
- color
- grouping

Do not rely on decorative elements to create hierarchy.

---

# 97. Attention Management

Attention is limited.

Use strongest visual emphasis only for important elements.

Avoid multiple competing:

- large headings
- bright colors
- badges
- shadows
- motion
- icons

on the same screen.

---

# 98. Visual Noise Control

Remove anything that does not help users:

- decide
- understand
- navigate
- act
- recover

---

# 99. Scroll Behavior

Do not create unnecessarily long pages.

But do not compress content so much that readability suffers.

Use clear sections.

Do not create nested scroll containers without a strong reason.

---

# 100. Avoid Nested Scroll Traps

A common bad pattern:

```text
page scroll
→ card scroll
→ table scroll
→ modal scroll
```

Reduce nested scrolling.

Every scroll container should have an intentional UX purpose.

---

# 101. Overflow Guard

Never allow accidental:

- horizontal page scroll
- clipped text
- cropped buttons
- hidden controls
- overflowing images
- broken tables
- modal overflow
- fixed-width layouts on small screens

For every component test:

- long text
- long number
- Arabic text
- English text
- long URL
- empty value
- huge count

---

# 102. Localization

UI must support:

- long translations
- short translations
- Arabic
- English
- RTL
- LTR
- mixed-language values
- dates
- currency
- plural forms

Do not hardcode layout around one language's text length.

---

# 103. RTL

In RTL layouts:

- text alignment
- navigation
- directional icons
- spacing
- chevrons
- breadcrumbs
- forms
- tables

must be intentional.

Do not blindly mirror every icon.

Directional icons may need semantic consideration.

---

# 104. Dynamic Text

Design for:

- usernames
- product names
- organization names
- translated text
- huge numeric values
- empty values

Never assume every string is short.

---

# 105. Number Formatting

Large numbers must remain readable.

Consider:

```text
999
1,000
1.2K
1,000,000
```

Use context and locale.

Do not shorten financial values in a way that creates ambiguity.

---

# 106. Dates / Times

Use locale-appropriate formats.

Avoid unexplained machine timestamps in user-facing UI.

Where time is relative:

```text
2 minutes ago
```

consider providing an exact timestamp where precision matters.

---

# 107. Visual Asset System

Define:

- logos
- illustrations
- product images
- avatars
- icons
- empty-state artwork
- decorative assets

Use consistent treatment.

Do not mix:

- flat icons
- 3D icons
- hand-drawn illustrations
- stock photos
- random gradient art

without a coherent reason.

---

# 108. Image Treatment

Define:

- aspect ratios
- object-fit
- corner radius
- background treatment
- placeholder
- fallback
- loading
- broken-image behavior

Keep image containers consistent.

---

# 109. Avatar System

Define:

- size scale
- shape
- fallback initials
- status indicator
- spacing
- border

Do not make every avatar a different shape.

---

# 110. Charts / Data Visualization

Charts must follow the visual system.

Define:

- chart colors
- semantic colors
- text
- gridlines
- labels
- tooltips
- empty state
- loading state

Never use color alone to distinguish essential series.

Do not add decorative 3D effects.

---

# 111. Data Visualization Color

Semantic colors should remain consistent.

For example:

```text
positive
negative
warning
neutral
```

Do not use green as "Series A" on one page and "danger" on another.

---

# 112. Design System File Structure

Use a reasonable component structure.

Example web:

```text
src/
  components/
    ui/
      Button/
      Input/
      Select/
      Modal/
      Dropdown/
      Card/
      Table/
      Badge/
      Toast/
      Tabs/
    layout/
      Header/
      Sidebar/
      Footer/
  styles/
    tokens/
      colors
      typography
      spacing
      radii
      shadows
      motion
      layers
      breakpoints
    themes/
      light
      dark
    components/
    global
```

Do not create a folder/file for every two CSS declarations.

---

# 113. Flutter File Structure

A reasonable Flutter system may use:

```text
lib/
  core/
    theme/
      colors.dart
      typography.dart
      spacing.dart
      radii.dart
      shadows.dart
      motion.dart
      breakpoints.dart
      theme.dart
  shared/
    widgets/
      buttons/
      cards/
      inputs/
      dialogs/
      tables/
      navigation/
      feedback/
```

Adapt to the project's existing architecture.

Do not duplicate the same widget logic across features.

---

# 114. Native Mobile Structure

For native iOS/Android:

- centralize theme values
- centralize typography
- centralize component styles
- create reusable components
- use platform conventions

Do not create giant global UI classes that contain every component.

---

# 115. Single Source of Truth for Components

If the same button appears 50 times:

Do not create 50 slightly different button implementations.

Create:

```text
Reusable Button
```

with variants.

Do the same for:

- inputs
- cards
- tables
- badges
- dialogs
- dropdowns
- navigation items

---

# 116. Function Reuse

If a function is used multiple times:

Do not copy/paste the implementation.

Create an appropriate reusable utility/service/helper.

But do not abstract code used once merely because duplication is theoretically possible.

---

# 117. Reuse Threshold

Before extracting a shared component/function ask:

1. Is this behavior truly the same?
2. Will it likely remain consistent?
3. Will reuse reduce bugs?
4. Does abstraction improve clarity?

Do not create overly generic components that require 50 props to handle every imaginable case.

---

# 118. Component API Simplicity

Prefer:

```text
Button
variant
size
loading
disabled
icon
children
```

over dozens of independent styling props.

Keep APIs predictable.

---

# 119. Avoid Generic Everything Components

Bad:

```text
UniversalComponent
MegaCard
GenericContainer
UniversalInputRenderer
DynamicEverything
```

unless there is a real shared abstraction.

Use semantic component names.

---

# 120. File Naming

Files must use descriptive names.

Good:

```text
ProductCard
OrderTable
AccountSettings
PasswordField
CheckoutSummary
RecommendationSection
```

Avoid:

```text
abc
test2
new
final
component1
Ahmed
WhatsApp
MyComponentFinalFinal
```

Do not name production files after people or brands.

---

# 121. Naming Rules

Names should answer:

> What is this?

Use domain meaning.

Good:

```text
ProductCard
CartSummary
CourseProgress
EmployeeTable
```

Avoid:

```text
Box2
Thing
MainStuff
BlueCard
NewWidget
```

Do not encode styling in component names unless appropriate.

---

# 122. CSS / Styling Organization

Keep styling ownership clear.

Avoid:

- giant global CSS
- duplicated style blocks
- random inline styling everywhere
- styles scattered across unrelated folders

The exact organization depends on the stack.

---

# 123. Global vs Local Styles

Global:

- reset
- tokens
- typography
- root layout
- theme

Component-level:

- component presentation
- states
- variants

Page-level:

- composition/layout specific to the page

Do not put page-specific rules in global styles.

---

# 124. Theme Architecture

Light/dark theme should share semantic tokens.

Example:

```text
surface.primary
text.primary
border.default
```

Values change per theme.

Components should reference semantic roles instead of checking whether they are in dark mode.

---

# 125. No Hardcoded Dark/Light Branches Everywhere

Bad:

```text
if dark:
   #111
else:
   #fff
```

across dozens of components.

Centralize theme tokens.

---

# 126. Breakpoint System

Create named breakpoints.

Example:

```text
xs
sm
md
lg
xl
2xl
```

Exact values are project-specific.

Do not create 20 breakpoints.

---

# 127. Container Breakpoint Logic

Breakpoints should respond to layout needs.

Do not choose a breakpoint because:

```text
"that's the tablet width"
```

instead ask:

> At what width does this layout stop being usable?

---

# 128. Responsive Component Logic

Components should adapt their internal layout.

Example:

```text
wide:
image | content | actions

narrow:
image
content
actions
```

Do not create entirely separate components unless the interaction really differs.

---

# 129. Component Variants

Use variants for legitimate visual modes:

```text
Button:
primary
secondary
danger
ghost
```

Avoid variants like:

```text
blue
green
purple
reallyLarge
superRounded
special2
```

unless the product requires them.

---

# 130. Layout Composition

Pages should primarily compose reusable components.

Avoid putting all styling logic in page files.

A page should answer:

```text
What is on this screen?
```

not:

```text
How do every button, card and input render?
```

---

# 131. Visual Hierarchy in Code

Code structure should mirror UI structure.

For example:

```text
Page
├── Header
├── Main
│   ├── Summary
│   ├── Filters
│   ├── Results
│   └── Recommendations
└── Footer
```

This improves maintainability.

---

# 132. State Separation

Separate:

- visual state
- server/data state
- form state
- authentication state
- global application state

Do not put everything into one global store.

Use the existing architecture unless it is genuinely problematic.

---

# 133. Design State Matrix

For every interactive component consider:

```text
default
hover
focus
pressed
selected
disabled
loading
success
error
empty
```

Only implement states that actually apply.

Do not create meaningless visual states.

---

# 134. Component Accessibility Matrix

For every reusable interactive component verify:

```text
Mouse
Keyboard
Touch
Screen reader
Focus
Error
Disabled
Reduced motion
RTL
Small screen
Large screen
```

---

# 135. Responsive Test Matrix

Minimum browser/web checks:

```text
Small mobile
Modern mobile
Tablet portrait
Tablet landscape
Laptop
Desktop
Wide desktop
4K
```

Minimum web browsers according to project support policy:

- Chrome
- Safari
- Firefox
- Edge
- mobile browsers relevant to the target audience

Do not test every browser version ever released.

---

# 136. Mobile Test Matrix

For mobile apps test:

- small screen
- large phone
- tablet
- portrait
- landscape where supported
- keyboard open
- system font scaling
- safe areas
- low memory
- dark mode
- reduced motion
- slow network

---

# 137. System Font Scaling

UI should remain usable when users increase text size.

Do not assume your chosen font size is always the user's chosen size.

Test overflow and clipping under accessibility text scaling.

---

# 138. Content Extremes

Test:

- very short labels
- very long labels
- huge numbers
- empty strings
- multiple-line titles
- long usernames
- long product names
- Arabic text
- mixed scripts

---

# 139. RTL/LTR Mirroring

Do not simply mirror every visual element.

Mirror:

- layout direction
- text alignment where appropriate
- directional movement

Do not necessarily mirror:

- brand logos
- physical object icons
- media controls
- universal symbols

---

# 140. Accessibility Semantics

Interactive elements must have meaningful:

- role
- label
- state
- value
- action

Do not make clickable `div`s where a real button/link is appropriate on the web.

Use semantic platform controls where possible.

---

# 141. Keyboard Navigation

Web:

- Tab
- Shift+Tab
- Enter
- Space
- Escape
- arrow keys where appropriate

Check:

- logical focus order
- visible focus
- modal focus trap
- dropdown navigation

---

# 142. Motion + Accessibility

Never let motion be required to understand:

- state
- hierarchy
- success
- error
- progress

Use visual/static alternatives.

---

# 143. Performance as Design Quality

A beautiful UI that loads slowly is not a high-quality experience.

Inspect:

- images
- fonts
- CSS
- JavaScript
- widget count
- render complexity
- unnecessary re-renders
- animations
- DOM size
- network requests

ProjectGuard owns detailed performance validation.

---

# 144. Image Performance

Use:

- responsive images
- correct dimensions
- modern formats where appropriate
- lazy loading for non-critical content
- preloading only when justified
- compression
- CDN where justified

Avoid downloading a 4K image to render a 100px thumbnail.

---

# 145. Font Performance

Avoid loading every font weight/style.

Load only what the design system actually uses.

Prefer modern efficient font delivery.

Do not sacrifice legibility for tiny bundle gains.

---

# 146. UI Render Performance

Look for:

- unnecessary rebuilds
- repeated computations
- large lists
- excessive animations
- expensive shadows
- filters/blur
- massive SVGs
- DOM explosions

For Flutter, use widget decomposition and constraint-aware adaptive layouts.

---

# 147. Large Lists

For large data:

- virtualization
- lazy rendering
- pagination
- incremental loading
- efficient item builders

where justified.

Do not load 10,000 complex cards into memory simply because it is technically possible.

---

# 148. 4K Performance

A 4K screen must not cause:

- enormous card sizes
- unreadable line lengths
- excessive empty space
- huge images loaded unnecessarily

Use max-width containers and sensible density.

---

# 149. Animation Cost

Before adding an animation ask:

- Is it meaningful?
- Is it frequent?
- Does it run on low-end devices?
- Does it trigger heavy work?
- Does it support reduced motion?

If not, remove it.

---

# 150. UX Copy

Use clear, task-oriented language.

Prefer:

```text
Save changes
```

over:

```text
Execute modification operation
```

Do not use developer jargon unless the audience is technical.

---

# 151. Button Copy

Use specific actions:

```text
Create course
Save changes
Add product
Send message
Download invoice
```

rather than vague:

```text
Submit
Continue
Go
Process
```

when specificity is possible.

---

# 152. Confirmation Copy

For important actions explain:

- what will happen
- whether it is reversible
- what the user should do next

Do not use scary warnings for every action.

---

# 153. Notifications Copy

Notifications should be:

- concise
- meaningful
- contextual
- actionable where appropriate

Avoid notification spam.

---

# 154. Visual Consistency Audit

After implementation, inspect:

- all buttons
- all inputs
- all cards
- all headings
- all tables
- all badges
- all alerts
- all modals
- all navigation
- all icons
- all spacing
- all radii
- all shadows
- all colors
- all typography

Look for accidental deviations.

---

# 155. UI Drift Prevention

A project gets visual drift when developers add:

```text
one new blue
one new radius
one new shadow
one new button height
one new font size
```

each time they build a screen.

Prevent this through:

- tokens
- component reuse
- design review
- lint/static checks where practical

---

# 156. Visual Regression

Where the project is large/important, consider:

- screenshots
- component visual tests
- browser snapshots
- mobile screenshots

Compare meaningful UI changes.

Do not create visual regression infrastructure for a tiny prototype if it adds more maintenance than value.

---

# 157. Design QA

Before completion verify:

```text
Identity
Typography
Colors
Spacing
Radius
Shadows
Icons
Components
States
Motion
Responsive
Accessibility
Dark/light
RTL/LTR
Performance
```

---

# 158. Design Review Severity

### Critical

- unusable on supported device
- inaccessible primary workflow
- severe overflow
- broken navigation
- unreadable text
- visual identity corruption
- major performance/UI freeze

### High

- broken responsive layout
- inconsistent core components
- important accessibility failure
- destructive-action confusion
- major interaction inconsistency

### Medium

- inconsistent spacing
- minor typography drift
- minor component inconsistency

### Low

- cosmetic deviations without meaningful usability impact

Do not block releases for tiny aesthetic differences unless the product explicitly requires strict visual compliance.

---

# 159. User Psychology Operating Model

DesignGuard may use established UX heuristics and perceptual principles as tools, not absolute laws.

Use where relevant:

- Gestalt grouping
- recognition over recall
- Hick/Hick-Hyman
- Fitts
- Jakob's Law
- aesthetic-usability effect
- progressive disclosure
- mental models
- cognitive load reduction
- consistency
- visibility of system status
- error prevention
- user control
- affordance/signifiers
- feedback
- hierarchy
- proximity
- similarity
- figure/ground

Do not describe these as magic formulas.

Validate important assumptions with real users or evidence when practical.

---

# 160. Psychology Safety Rule

Never use psychology to manipulate users into actions they did not intend.

Do not use:

- deceptive dark patterns
- hidden cancellation
- forced consent
- fake urgency
- misleading scarcity
- deceptive button hierarchy
- guilt-based copy
- confusing defaults designed to trick users

Good UX reduces friction without removing informed choice.

---

# 161. Trust Design

Users should understand:

- what happened
- what will happen
- whether data was saved
- whether payment succeeded
- whether an action is reversible

Trust is improved through clarity and consistent feedback.

---

# 162. User Control

Allow:

- cancel
- back
- close
- undo where practical
- edit
- retry

Do not trap users in dialogs or flows.

---

# 163. Predictability

A user should be able to reasonably predict:

```text
What happens if I tap this?
```

Avoid unexpected:

- navigation
- popup
- downloads
- sound
- animation
- layout shifts

---

# 164. Affordance and Signifiers

Make interactive elements look interactive.

Buttons should look actionable.

Inputs should look editable.

Links should look like links.

Do not require users to guess.

---

# 165. Feedback Timing

Feedback should arrive close to the action.

Examples:

```text
tap
→ immediate press feedback

submit
→ loading

success
→ confirmation
```

Do not show stale or delayed feedback that makes users repeat actions.

---

# 166. Double-Click / Double-Tap Protection

For actions that can accidentally duplicate:

- disable or guard repeated submission
- use idempotency server-side for important operations
- show progress state

ProjectGuard owns backend idempotency/security.

---

# 167. Data Loss Prevention

Before destructive navigation or form exit:

- preserve draft where practical
- warn about unsaved changes
- autosave when justified

Do not interrupt every navigation with unnecessary warnings.

---

# 168. Onboarding

Onboarding should:

- show value early
- teach only necessary concepts
- use contextual guidance
- allow skipping non-essential material
- avoid long walls of text

Measure onboarding success through the product's analytics where InsightGuard is active.

---

# 169. Progressive Learning

Introduce complexity as the user needs it.

Beginner:

```text
simple
```

Expert:

```text
shortcuts
advanced filtering
bulk actions
```

Do not create two separate UI systems.

---

# 170. Search Discoverability

Search should be visible when search is a primary task.

Filters should be discoverable.

Do not hide common actions behind decorative menus.

---

# 171. Information Architecture

Structure information based on:

- user mental models
- task frequency
- importance
- grouping
- context

Use card sorting or user research when the hierarchy is genuinely uncertain.

---

# 172. Navigation Depth

Avoid unnecessarily deep navigation.

But do not flatten everything into one menu.

Aim for:

```text
discoverable
+
logical
+
predictable
```

---

# 173. Dashboard Design

Dashboards should prioritize:

- current status
- important actions
- exceptions
- trends
- next steps

Do not fill dashboards with every possible metric.

Follow the same anti-over-view rule.

---

# 174. ERP / Admin Density

For professional systems:

- compact tables may be appropriate
- persistent filters may help
- bulk actions can reduce work
- keyboard workflows can help

But maintain visual hierarchy and legibility.

---

# 175. E-commerce UI

Prioritize:

- product image
- product name
- price
- availability
- primary CTA
- important variant controls
- trust information
- relevant recommendations

Do not let decorative sections bury purchase actions.

---

# 176. Education UI

Prioritize:

- course
- progress
- next lesson
- assessment
- completion
- learning objective

Avoid noisy gamification unless it serves the learning experience.

---

# 177. SaaS UI

Prioritize:

- primary workflow
- navigation
- status
- tasks
- helpful empty states
- fast actions

Do not fill SaaS dashboards with decorative statistics.

---

# 178. Mobile Navigation

Use:

- bottom navigation
- navigation drawer
- navigation rail
- top tabs

based on information architecture and available space.

Do not create bottom navigation with eight tiny icons.

---

# 179. Desktop Navigation

Sidebars can support dense applications.

Avoid overstuffed navigation.

Use grouping, collapsible sections, and clear labels.

---

# 180. Responsive Navigation

Navigation may transform:

```text
desktop sidebar
→ tablet rail
→ mobile bottom/drawer
```

This is an adaptive layout decision.

Do not use device detection if available-space rules solve the problem.

---

# 181. Fixed vs Fluid

Use fluid sizing where it benefits readability.

Use max-width where it protects content.

Use fixed dimensions for:

- icons
- control heights
- certain dense UI components

Do not make everything fixed.

---

# 182. CSS Units

Use units intentionally:

- `px` for certain UI dimensions
- `rem` for typography/spacing systems where appropriate
- `%` for fluid layouts
- viewport/container units where appropriate

Do not use arbitrary viewport units for every component.

---

# 183. Container Queries

Where supported and useful, consider component-based responsive behavior.

Do not introduce container-query complexity if ordinary layout constraints are enough.

---

# 184. Flutter Layout Architecture

Prefer:

- `LayoutBuilder`
- `MediaQuery.sizeOf`
- adaptive breakpoints
- constraint-based layout

instead of assuming:

```text
phone/tablet/desktop
```

as hard device categories.

---

# 185. Flutter Safe Areas

Protect:

- notches
- system UI
- home indicators
- rounded corners

with appropriate safe-area handling.

---

# 186. Native Platform Conventions

For native applications:

- use platform-standard controls where appropriate
- respect platform navigation
- respect accessibility APIs
- respect system settings
- respect reduced motion
- respect dynamic type/text scaling

Do not recreate platform controls unnecessarily.

---

# 187. Cross-Platform Identity

When building web + Flutter + native:

Keep brand identity shared:

- colors
- typography
- radius
- icons
- tone
- semantics

But allow platform-specific interaction conventions.

Do not force a browser interaction onto iOS merely to keep pixel parity.

---

# 188. Design Token Portability

Where multiple platforms share a product, maintain conceptual parity between:

```text
web tokens
flutter tokens
native tokens
```

They may have platform-specific values.

Do not literally force identical units across platforms.

---

# 189. Theme Documentation

Maintain a small usage guide:

```text
Color rules
Typography rules
Spacing rules
Radius rules
Shadow rules
Icon rules
Motion rules
Component rules
Responsive rules
Accessibility rules
```

Keep it concise and practical.

---

# 190. Do Not Overbuild the Design System

Do not create:

- 100 components
- 40 variants per component
- a token for every pixel
- a design-system application
- a visual editor
- a token backend

unless the scale demands it.

For small projects, a small theme/token system + reusable components is enough.

---

# 191. Design System Maturity

### Small project

```text
Theme
+
tokens
+
10–20 reusable components
```

### Medium product

```text
tokens
+
component library
+
documentation
+
visual tests
```

### Large product

```text
shared design system
+
versioning
+
contribution rules
+
visual regression
+
cross-platform tokens
```

Use only the level needed.

---

# 192. Design System Versioning

Use V1/V2 when:

- breaking component contracts
- major redesign
- large production migration

Maintain compatibility during migration.

Do not version every small CSS change.

---

# 193. Production-Safe UI Updates

Never assume a visual refactor is harmless.

Before changing shared components in production:

1. Identify all consumers.
2. Inspect variants.
3. Check mobile.
4. Check dark mode.
5. Check accessibility.
6. Check forms and critical workflows.
7. Run visual regression where available.
8. Roll out safely.

---

# 194. Production UI Migration

For breaking component changes:

```text
Old component
→ compatibility period
→ migration
→ remove old component
```

Do not delete shared components before all consumers migrate.

---

# 195. V1 / V2 Component Strategy

If necessary:

```text
ButtonV1
ButtonV2
```

only when behavior/design contracts genuinely differ.

Avoid:

```text
ButtonV3Final
ButtonNew
ButtonNew2
```

---

# 196. Production Data Safety

Visual changes must never modify business data accidentally.

Keep UI refactors separate from:

- database migrations
- destructive data operations

unless the feature explicitly requires both.

ProjectGuard remains authoritative for migration/data safety.

---

# 197. Backward Compatibility

When changing:

- API response shape
- form behavior
- URL
- stored preferences
- theme values
- component props

consider existing users and saved state.

Do not break production users unnecessarily.

---

# 198. Update Strategy

For active production systems:

```text
Inspect
→ isolate change
→ test
→ deploy safely
→ monitor
→ rollback if needed
```

Avoid giant visual rewrites with no rollback strategy.

---

# 199. Git Workflow

When the design task is complete:

- inspect `git status`
- review diff
- verify unintended files
- run relevant tests/build
- commit completed work

Commit messages should describe the actual change.

Example:

```text
feat(ui): establish shared design system
fix(ui): resolve mobile overflow in checkout
refactor(ui): centralize button styles
```

Do not commit generated secrets or unrelated files.

---

# 200. GitHub

Where repository access/workflow allows:

- commit
- push
- verify CI
- inspect failed checks
- fix relevant failures

Do not overwrite or force-push shared branches without explicit authorization.

---

# 201. Git Commit Discipline

Do not make one enormous commit containing:

```text
UI
+
Security
+
SEO
+
database
+
unrelated cleanup
```

Prefer logically grouped commits when practical.

---

# 202. Overwrite Protection

Never overwrite existing project code merely because a cleaner rewrite is possible.

Before replacing a file:

- determine its consumers
- compare current behavior
- preserve required functionality
- migrate carefully

Avoid destructive rewrites.

---

# 203. Overengineering Guard

For every design change ask:

```text
Does this improve a real user problem?

Does it strengthen consistency?

Does it improve maintainability?

Does it improve accessibility?

Does it improve performance?

Is the complexity justified?
```

If the answer is no, do not add it.

---

# 204. Over-Animation Guard

For every animation ask:

```text
What does this communicate?
```

If the answer is:

```text
It looks cool.
```

that is not enough.

---

# 205. Over-Component Guard

Do not turn:

```text
one 20-line component
```

into:

```text
10 components + 5 hooks + 3 utility files
```

unless reuse/complexity actually justifies it.

---

# 206. Over-File Guard

Split files by meaningful responsibility.

Do not create:

```text
buttonStyles1
buttonStyles2
buttonStyles3
```

when a single button component owns its variants.

---

# 207. Over-Token Guard

Do not create:

```text
spacing-17
spacing-18
spacing-19
```

for arbitrary one-off values.

Use the spacing scale.

Optical adjustments are allowed when there is a clear reason.

---

# 208. Over-Color Guard

Do not add a new color because:

```text
"this blue feels slightly different."
```

First check whether an existing semantic color already solves the problem.

---

# 209. Over-Radius Guard

Do not invent unique border radii.

Use the established system.

---

# 210. Over-Shadow Guard

Do not add shadows simply to make a card look "modern."

Use elevation intentionally.

---

# 211. Over-Gradient Guard

Gradients must serve the identity or communicate hierarchy.

Avoid adding gradients to:

- every button
- every card
- every background
- every header

just for decoration.

---

# 212. Over-Glass Guard

Avoid uncontrolled:

- glassmorphism
- blur layers
- translucent surfaces

when they harm:

- readability
- performance
- accessibility
- clarity

---

# 213. Over-Icon Guard

Do not add an icon to every line of text.

Icons should improve recognition or action clarity.

---

# 214. Over-Tooltip Guard

Do not use tooltips to compensate for unclear UI.

Improve labels first.

---

# 215. Over-Modal Guard

Do not put every action in a modal.

Use pages/drawers when context or content is large.

---

# 216. Over-Notification Guard

Do not notify users for every small event.

Use notifications for:

- important changes
- actionable information
- meaningful completion/failure

---

# 217. Over-Responsive Guard

Do not create unique layouts for every width.

Use a small number of meaningful layout regimes.

---

# 218. Over-Accessibility-Abstraction Guard

Do not build a giant accessibility framework when semantic components/platform APIs already solve the problem.

Make individual components accessible.

---

# 219. Visual Identity Drift Detection

When reviewing the codebase, search for:

- raw hex colors
- arbitrary border-radius
- arbitrary font sizes
- arbitrary shadows
- duplicate button styles
- duplicate card styles
- random icon libraries
- hardcoded breakpoints
- inline motion durations
- page-specific typography

Replace only where the deviation is genuinely accidental or harmful.

---

# 220. Design Tokens Static Checks

Where practical, detect:

- unauthorized raw colors
- duplicate radii
- duplicate spacing values
- unsupported font weights
- arbitrary z-index values
- invalid breakpoints

Use warnings before making CI blocking.

Do not make developers fight the design system over legitimate one-off cases.

---

# 221. Component Inventory

Maintain an internal inventory:

```text
Component
Purpose
Variants
States
Responsive behavior
Accessibility
Dependencies
```

Do not create a huge documentation system for a tiny project.

---

# 222. Component Lifecycle

When a component becomes obsolete:

```text
identify usage
→ migrate
→ verify
→ remove
```

Do not leave dead design components forever.

---

# 223. Performance + Components

A reusable component should not automatically become a heavy component.

Avoid unnecessary:

- state
- effects
- subscriptions
- network calls
- dependencies

in base UI components.

Base components should be as deterministic/lightweight as practical.

---

# 224. Pure Visual Components

Where possible keep purely visual components:

- data-light
- predictable
- reusable
- side-effect free

Move business logic to appropriate layers.

---

# 225. Business Logic Separation

Do not put:

- payment logic
- authorization logic
- recommendation scoring
- database logic

inside UI components.

ProjectGuard and InsightGuard govern those concerns.

---

# 226. UI Data Fetching

Keep data fetching predictable.

Avoid:

```text
Button component → hidden API call → global state mutation
```

unless its responsibility genuinely requires it.

Prefer clear boundaries.

---

# 227. Performance of Shared Components

Fixing a shared component can affect the entire application.

Before changing:

- Button
- Input
- Card
- Table
- Modal
- Layout
- Theme

check representative consumers.

---

# 228. Design Regression

After changing a shared component, test:

- desktop
- mobile
- dark
- light
- RTL
- LTR
- disabled
- loading
- focus
- long content

---

# 229. Visual QA Checklist

### Identity

- brand
- visual tone
- consistent palette
- typography
- icons

### Geometry

- spacing
- radius
- component sizing
- alignment
- containers

### Interaction

- hover
- focus
- pressed
- disabled
- loading
- success
- error

### Responsive

- smallest screen
- phone
- tablet
- desktop
- large desktop
- 4K

### Accessibility

- keyboard
- screen reader
- contrast
- touch target
- text scaling
- reduced motion

### International

- Arabic
- English
- RTL
- LTR
- long strings

### Performance

- images
- fonts
- rendering
- animations
- large lists

---

# 230. Final Audit Workflow

When DesignGuard is active:

## Phase 1 — Discover

Understand product, users, identity, platform, architecture, current UI.

## Phase 2 — Inventory

Map:

- tokens
- components
- pages
- responsive layouts
- theme
- states

## Phase 3 — Diagnose

Find:

- visual drift
- UX friction
- accessibility issues
- responsive failures
- over-animation
- over-abstraction
- repeated code
- performance issues

## Phase 4 — Systemize

Create/reuse:

- tokens
- components
- themes
- breakpoints
- motion rules

## Phase 5 — Implement

Make the smallest coherent set of changes.

## Phase 6 — Validate

Test:

- visual
- responsive
- accessibility
- interaction
- performance

## Phase 7 — Cross-Skill Regression

If active:

```text
DesignGuard
+
ProjectGuard
+
SEOGuard
+
InsightGuard
```

Validate interactions between them.

## Phase 8 — Commit

Review diff and commit completed work.

---

# 231. Cross-Skill Rules

## DesignGuard + ProjectGuard

Never sacrifice security for UI convenience.

## DesignGuard + SEOGuard

Do not use visual tricks that harm crawlability or structured content.

## DesignGuard + InsightGuard

Personalization should feel helpful but must preserve visual consistency.

Recommendations can change content, but not the fundamental design language.

## ProjectGuard + InsightGuard

Authorization must happen before personalization.

## SEOGuard + InsightGuard

Personalization must not create SEO spam or URL explosions.

---

# 232. Personalization UI Rules

When InsightGuard supplies recommendations:

Use established:

- card
- image
- typography
- spacing
- icon
- badge
- CTA

Do not invent a completely new "recommendation style."

Recommendation sections should look like they belong to the same product.

---

# 233. Search Personalization UI

Search results may be personalized, but the UI must remain predictable.

Do not make users wonder:

```text
Why am I seeing this?
```

Use subtle explanations when useful.

InsightGuard governs recommendation logic.

---

# 234. Dynamic Content Stability

Personalized content should not cause major layout shift.

Use:

- reserved space where appropriate
- stable card dimensions
- progressive loading
- predictable insertion

---

# 235. Skeleton + Personalization

Skeletons should match the personalized result shape.

Do not cause:

```text
blank
→ 6 cards
```

to shift the entire layout.

---

# 236. Recommendation Overload Prevention

Do not display:

```text
Recommended
Similar
Trending
Popular
Because you viewed
Frequently bought
You may like
```

all at once.

Choose the most useful 1–3 modules.

---

# 237. Personalization Consistency

A product can personalize content while remaining visually stable.

Stable:

- header
- navigation
- controls
- typography
- color
- radius
- spacing

Dynamic:

- products
- content
- recommendations
- shortcuts
- suggestions

This separation improves predictability.

---

# 238. SEO + Personalized UI

Public SEO pages should retain stable public structure.

Private personalized modules should not:

- change canonical
- change robots directives
- create user-specific indexable URLs
- introduce hidden SEO text

SEOGuard remains authoritative.

---

# 239. Performance + Personalized UI

Recommendation calls should not block the main experience.

Preferred:

```text
main UI
→ usable immediately
→ optional personalization loads
```

where appropriate.

---

# 240. Production Rollout

For major UI redesigns:

```text
current UI
→ updated shared components
→ targeted rollout
→ monitor
→ fix
→ wider rollout
```

Use feature flags if the existing project has them and the change warrants it.

Do not create a feature-flag platform solely for a small redesign.

---

# 241. V1/V2 Design System

Use V1/V2 when:

- breaking component contracts
- major redesign
- large production migration

Maintain compatibility during migration.

Do not clone the entire application for a visual redesign.

---

# 242. Database / API Safety During UI Work

A visual change should not casually change backend contracts.

When API changes are required:

- document
- version where necessary
- preserve compatibility where appropriate
- migrate consumers
- test

ProjectGuard remains authoritative.

---

# 243. Git Completion

Before finalizing:

```text
git status
git diff
tests/build
review changed files
commit
```

Only commit files belonging to the actual work.

Do not commit secrets.

---

# 244. Final Design Definition of Done

The project is ready when:

- visual identity is coherent
- components use common tokens
- colors are semantic
- typography is consistent
- radius is consistent
- spacing is consistent
- shadows are intentional
- icons are coherent
- important interactions have feedback
- motion is purposeful
- reduced motion is respected
- the UI works on very small screens
- the UI works on modern phones
- tablets work
- desktop works
- 4K works
- RTL/LTR work where applicable
- long content works
- accessibility is addressed
- shared components are reused
- unnecessary duplicated code is removed
- unnecessary abstractions are avoided
- performance is acceptable
- production-safe update strategy is respected
- no brand imitation was introduced
- no WhatsApp-like distinctive motion/interaction system was copied
- no excessive visual decoration was introduced
- no unnecessary files/dependencies were added

---

# 245. Final Golden Rules

1. One product should feel like one product.
2. Visual identity is a system, not a collection of pages.
3. Use tokens.
4. Reuse components.
5. Keep radius consistent.
6. Keep spacing consistent.
7. Keep typography consistent.
8. Keep iconography consistent.
9. Use semantic colors.
10. Use visual hierarchy intentionally.
11. Prefer recognition over recall.
12. Reduce unnecessary choices.
13. Make targets comfortable.
14. Preserve user control.
15. Prevent errors where practical.
16. Give immediate understandable feedback.
17. Use platform conventions without copying brands.
18. Do not imitate WhatsApp or any competitor's distinctive UI or motion identity.
19. Animation must have a reason.
20. Respect reduced motion.
21. Avoid visual noise.
22. Avoid dark patterns.
23. Avoid unnecessary gradients/glass/shadows.
24. Avoid arbitrary border radii.
25. Avoid arbitrary spacing.
26. Avoid arbitrary breakpoints.
27. Avoid arbitrary z-index values.
28. Avoid emoji as core UI icons.
29. Do not use icons when their meaning is ambiguous without labels.
30. Keep important actions obvious.
31. Keep core navigation predictable.
32. Support beginners without punishing experts.
33. Support experts without confusing beginners.
34. Design for real content, not placeholder text.
35. Design for long text.
36. Design for Arabic/RTL where applicable.
37. Design for system font scaling.
38. Design for tiny screens.
39. Design for large screens.
40. Do not allow accidental overflow.
41. Do not create one layout for every device.
42. Prefer constraint-based/adaptive layouts.
43. Keep public SEO content stable.
44. Keep personalization visually coherent.
45. Security/privacy constraints override convenience.
46. Performance is part of UX.
47. Reuse repeated functions.
48. Reuse repeated components.
49. Name files by purpose.
50. Do not name files after people or brands.
51. Comment important non-obvious logic.
52. Keep component APIs simple.
53. Do not over-abstract.
54. Do not over-componentize.
55. Do not over-animate.
56. Do not over-document.
57. Do not over-build the design system.
58. Do not rewrite working code without a reason.
59. For production changes, protect existing users/data.
60. Review diffs before committing.
61. Commit completed work.
62. Never claim visual QA passed without actually checking it.
63. Aesthetic quality must support usability.
64. Psychology principles are heuristics, not magic laws.
65. Validate important assumptions with users/data when practical.
66. The simplest coherent system is usually stronger than a giant design framework.

---

# 246. Final Operating Loop

```text
UNDERSTAND
   ↓
DEFINE IDENTITY
   ↓
CREATE TOKENS
   ↓
BUILD/REFINE COMPONENT SYSTEM
   ↓
COMPOSE PAGES
   ↓
ADAPT TO AVAILABLE SPACE
   ↓
VALIDATE ACCESSIBILITY
   ↓
VALIDATE PERFORMANCE
   ↓
VALIDATE INTERACTIONS
   ↓
VALIDATE VISUAL CONSISTENCY
   ↓
RUN CROSS-SKILL REGRESSION
   ↓
REVIEW DIFF
   ↓
COMMIT
```

The objective is not to make every screen visually impressive.

The objective is to make the product feel like one coherent, thoughtful, fast, accessible, predictable system that users can understand quickly and use comfortably.

DesignGuard should always optimize:

```text
Clarity
+
Consistency
+
Usability
+
Accessibility
+
Identity
+
Responsiveness
+
Performance
+
Maintainability
-
Unnecessary Complexity
-
Visual Noise
-
Brand Imitation
-
Over-Engineering
```
