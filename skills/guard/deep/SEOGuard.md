# SEOGuard Skill

## Purpose

SEOGuard is a reusable, project-agnostic SEO engineering and audit skill.

When working on any project that has publicly accessible pages—website, web app with public pages, SaaS marketing site, e-commerce store, education platform, blog, portfolio, documentation site, marketplace, directory, local business site, or hybrid application—apply this SEO framework proactively.

The goal is not to add random meta tags or chase outdated "SEO tricks." The goal is to make the site:

- Crawlable
- Renderable
- Indexable where intended
- Canonically correct
- Semantically understandable
- Fast and usable
- Mobile-friendly
- Accessible
- Search-result eligible where applicable
- Internally well linked
- Content-rich and useful
- Correctly represented in social previews
- Correctly represented with structured data
- Measurable through search analytics
- Maintainable in code

Always distinguish:
1. Google Search requirements/signals
2. General technical best practices
3. Optional enhancements
4. Project-specific SEO requirements

Never claim that a tag guarantees ranking. SEO improves eligibility, understanding, crawlability, user experience, and discoverability; ranking is determined by search systems.

---

# 0. Mandatory Operating Rules

1. Inspect the project before modifying SEO.
2. Identify the framework, rendering strategy, routing system, CMS, API, database, deployment model, and public/private routes.
3. Build a route-level SEO inventory.
4. Determine which URLs should be:
   - indexable
   - non-indexable
   - canonical
   - redirected
   - excluded from search
5. Never add `noindex` blindly.
6. Never block a URL in `robots.txt` when Google needs to crawl the page to see a `noindex` directive.
7. Never use `robots.txt` as a replacement for access control.
8. Never use canonical tags as a replacement for redirects or authorization.
9. Never generate fake/duplicated SEO content merely to target keywords.
10. Never keyword-stuff.
11. Never hide SEO text from users.
12. Never create doorway pages.
13. Never create thousands of thin programmatic pages without genuine unique value.
14. Never invent structured-data values.
15. Structured data must describe visible, relevant page content and satisfy the applicable feature's requirements.
16. Validate generated JSON-LD.
17. Keep canonical URLs absolute and consistent.
18. Use HTTPS consistently.
19. Keep redirects intentional and avoid chains.
20. Avoid redirecting unrelated old URLs to the homepage.
21. Do not create unnecessary URL parameters.
22. Control faceted navigation and search-result URLs.
23. Make important content discoverable through crawlable links.
24. Do not depend on user interaction for critical SEO content when server-rendering or static rendering is practical.
25. Verify rendered HTML, not only source code assumptions.
26. Measure before optimizing performance.
27. Do not add SEO infrastructure that the project does not need.
28. Avoid SEO over-engineering.
29. Prefer one correct reusable SEO system over page-by-page duplicated logic.
30. Re-check SEO after major routing, content, rendering, domain, migration, or deployment changes.

---

# 1. Project SEO Reconnaissance

Before coding, inspect:

## Application

- Framework
- Version
- Router
- SSR/SSG/ISR/CSR
- Server components/client components where applicable
- Dynamic routes
- Middleware
- API routes
- CMS
- Build process

## Site

- Domain
- HTTPS
- www/non-www strategy
- Language
- Regions
- Sitemap
- robots.txt
- Search Console
- Analytics
- CDN
- Redirects

## Content

- Home
- Categories
- Products
- Product variants
- Services
- Blog
- Articles
- Documentation
- Landing pages
- Authors
- Courses
- Lessons
- Profiles
- Locations
- Search pages
- Filter pages
- Account/private pages

## Technical

- Database
- Image storage
- CDN
- Cache
- API
- Third-party integrations
- Deployment
- Environment variables

---

# 2. SEO Route Inventory

Create a route matrix.

For every public route record:

- URL
- Page type
- Purpose
- Primary keyword/topic
- Search intent
- Indexable?
- Canonical URL
- Title
- Meta description
- H1
- Robots directive
- Sitemap inclusion
- Structured data
- Language
- hreflang
- Open Graph
- Twitter/X metadata
- Breadcrumbs
- Internal links
- Images
- Performance status

Example:

| Route | Type | Index | Canonical | Schema | Sitemap |
|---|---|---:|---|---|---:|
| `/` | Home | Yes | Self | Organization/WebSite | Yes |
| `/products` | Category | Yes | Self | BreadcrumbList | Yes |
| `/products/item` | Product | Yes | Self | Product | Yes |
| `/search` | Internal search | Usually No | — | None | No |
| `/dashboard` | Private | No | — | None | No |

Do not blindly use this exact matrix; adapt it to the project.

---

# 3. URL Architecture

SEO-friendly URLs should be:

- Stable
- Readable
- Descriptive
- Consistent
- Lowercase where practical
- Hyphen-separated
- Free from unnecessary parameters
- Free from session IDs
- Free from meaningless IDs where a slug is practical

Prefer:

`/products/arduino-uno-r3`

over:

`/product?id=3928`

Avoid:

- Excessive nesting
- Random query parameters
- Tracking parameters in canonical URLs
- Session IDs
- Multiple spellings of the same URL
- Mixed trailing-slash conventions
- HTTP/HTTPS duplicates
- www/non-www duplicates

Choose one URL policy and enforce it.

---

# 4. HTTPS & Host Canonicalization

Verify:

- HTTP redirects to HTTPS
- Preferred hostname is consistent
- Non-preferred hostname redirects
- Canonical URLs use HTTPS
- Sitemap URLs use HTTPS
- Internal links use HTTPS
- Open Graph URLs use HTTPS
- Structured-data URLs use HTTPS where applicable

Avoid:

HTTP → HTTPS → www → final URL chains.

Prefer one direct redirect to the final canonical URL.

---

# 5. Trailing Slash Policy

Choose one:

- `/products/`
- `/products`

Then consistently use it across:

- Router
- Internal links
- Canonicals
- Sitemap
- Redirects
- Open Graph
- Structured data

Do not create duplicate accessible versions.

---

# 6. Canonicalization

Every indexable page should have a deliberate canonical strategy.

For normal unique pages, a self-referencing canonical is usually appropriate.

Canonical must:

- Be absolute
- Use the preferred protocol
- Use the preferred hostname
- Match the intended URL
- Not point to a 404
- Not point to an irrelevant page
- Not unnecessarily point to another language version
- Not conflict with redirects

Important:

`rel="canonical"` is a hint, not an absolute command to Google.

Google may choose another canonical based on its signals.

---

# 7. Duplicate URL Detection

Look for duplicates caused by:

- HTTP/HTTPS
- www/non-www
- Trailing slash
- Case
- Query parameters
- Tracking parameters
- Sort parameters
- Filter parameters
- Pagination
- Print URLs
- Preview URLs
- Session URLs
- Alternate routes
- Duplicate product URLs
- CMS aliases
- Multiple category paths
- Old URLs
- Staging URLs

Determine whether to:

- Redirect
- Canonicalize
- Noindex
- Exclude from sitemap
- Remove
- Keep because it is genuinely useful

Do not automatically canonicalize every duplicate if users/search engines legitimately need distinct URLs.

---

# 8. HTTP Status Codes

Audit all important URLs.

Expected patterns:

- `200` → valid page
- `201` → API/resource creation, not normal SEO pages
- `301/308` → intentional permanent redirect
- `302/307` → temporary redirect where appropriate
- `404` → missing resource
- `410` → intentionally permanently gone where appropriate
- `401/403` → protected resource
- `429` → rate limiting
- `5xx` → server failure

Avoid:

- Soft 404s
- Redirect chains
- Redirect loops
- 200 responses for nonexistent pages
- 200 login pages for missing protected resources where inappropriate
- Redirecting everything to homepage

---

# 9. Redirect Audit

For every old/redirected URL verify:

- Source
- Destination
- Status code
- Relevance
- Chain length
- Loop
- Final status
- Canonical
- Sitemap presence

When migrating a site, map old URLs to their closest relevant new equivalents.

Do not mass-redirect unrelated pages to the homepage.

---

# 10. Robots.txt

Create or audit:

`/robots.txt`

It should:

- Be accessible
- Return valid text
- Avoid accidental global blocking
- Avoid blocking important CSS/JS/resources unnecessarily
- Avoid blocking pages that need to be crawled to discover `noindex`
- Include sitemap location where appropriate

Example structure:

```txt
User-agent: *
Disallow: /admin/
Disallow: /dashboard/
Disallow: /api/private/

Sitemap: https://example.com/sitemap.xml
```

Adapt paths to the real project.

Important:

Robots.txt controls crawling, not authentication.

A disallowed URL can still be discovered or appear in search under some circumstances.

For sensitive content, enforce authentication/authorization at the application/server layer.

---

# 11. Robots Meta Tags

Use only when necessary.

Common directives:

```html
<meta name="robots" content="index,follow">
```

```html
<meta name="robots" content="noindex,nofollow">
```

For Google-specific behavior where needed:

```html
<meta name="googlebot" content="noindex">
```

Do not add `noindex` to every page by default.

Important:

If a page must be removed from indexing via `noindex`, Google needs to be able to crawl it to see the directive.

Do not simultaneously block the URL in robots.txt and expect Google to reliably see its `noindex`.

---

# 12. X-Robots-Tag

Use HTTP headers where appropriate, especially for:

- PDFs
- Non-HTML files
- Downloadable resources
- Programmatically generated documents

Example:

```http
X-Robots-Tag: noindex
```

Use this only when the resource should actually be excluded.

---

# 13. XML Sitemap

Create a sitemap for indexable, canonical URLs that are worth discovering.

Do not blindly include:

- Noindex pages
- Redirect URLs
- 404s
- 410s
- Duplicate URLs
- Login pages
- Internal search results
- Irrelevant parameter URLs

Keep sitemap URLs:

- Canonical
- Absolute
- HTTPS
- Valid
- Accessible
- Usually 200

For large sites use sitemap indexes and split logically where useful.

Possible sitemap groups:

- pages
- products
- categories
- articles
- videos
- images

Only use specialized sitemap extensions when they solve a real need.

---

# 14. Sitemap Freshness

The sitemap should update when important URLs are:

- Created
- Updated
- Deleted
- Redirected
- Changed canonical status

Do not constantly regenerate meaningless timestamps.

Use `lastmod` only when it represents a meaningful last modification relevant to the URL.

---

# 15. HTML `<title>`

Every indexable page needs a useful title.

Rules:

- Unique where practical
- Descriptive
- Relevant to the page
- Natural
- Concise
- Uses the primary topic naturally
- Uses the same language/script as the primary page content

Avoid:

- Keyword stuffing
- Repeating the same title everywhere
- "Best Best Best..."
- Generic titles
- Huge titles stuffed with keywords
- Misleading titles

Do not assume an exact character count guarantees display length. Search result titles can be generated or rewritten by Google.

---

# 16. Meta Description

Provide a unique useful description for important pages.

It should:

- Summarize the page
- Match the actual content
- Encourage useful clicks
- Include important context naturally

Do not treat a fixed character limit as a ranking rule.

Google may generate snippets from page content instead of using the meta description.

Therefore:

**The actual visible page content must also be high quality.**

---

# 17. H1 / Headings

Use semantic headings.

Typical hierarchy:

```html
<h1>Primary page topic</h1>
<h2>Major section</h2>
<h3>Subsection</h3>
```

Rules:

- One clear primary page topic
- Do not create headings solely for keywords
- Do not use heading tags only for visual styling
- Do not skip semantic structure without reason
- Multiple H1s are not automatically an SEO disaster, but use a clear primary heading structure

---

# 18. Content Quality

SEO content must serve users.

Audit:

- Originality
- Accuracy
- Completeness
- Search intent
- Clarity
- Useful details
- Evidence/experience where appropriate
- Author information where relevant
- Updated information
- Internal links
- Related content

Avoid:

- AI-generated filler
- Keyword stuffing
- Thin pages
- Rewriting competitors without adding value
- Doorway pages
- Hidden text
- Scaled low-value content
- Fake expertise

AI can assist content production, but content quality and usefulness remain the priority.

---

# 19. Search Intent

For every important page determine:

- Informational
- Commercial investigation
- Transactional
- Navigational
- Local

Then ensure the page actually satisfies the intent.

Example:

A product page should not behave like a generic article.

A category page should not contain thousands of paragraphs of keyword text just for SEO.

---

# 20. Keyword Strategy

Do not build the system around keyword stuffing.

For each important page define:

- Primary topic
- Main search intent
- Supporting topics
- Synonyms
- Entities
- User questions

Place important language naturally in:

- Title
- H1
- Intro
- Relevant headings
- Body
- Image alt text when descriptive
- Internal anchor text
- Structured data when legitimately represented

Do not force exact-match phrases everywhere.

---

# 21. Internal Linking

Every important page should be reachable through internal links.

Audit:

- Navigation
- Breadcrumbs
- Category links
- Related products
- Related articles
- Contextual links
- Footer links
- Pagination

Avoid:

- Orphan pages
- Excessive repeated links
- Generic anchor text everywhere
- Huge footer link farms
- Links to irrelevant pages

Use descriptive anchor text naturally.

---

# 22. Crawl Depth

Important content should not be buried unnecessarily deep.

Review:

Home → Category → Product/Article

Keep navigation logical.

Do not create complex navigation just to reduce theoretical crawl depth.

---

# 23. Orphan Pages

Find pages that:

- Are in sitemap but have no internal links
- Are indexed but not internally linked
- Are important but difficult to discover

Either:

- Add meaningful internal links
- Improve navigation
- Reconsider whether the page should exist

---

# 24. Breadcrumbs

For hierarchical sites consider:

- Visual breadcrumbs
- BreadcrumbList structured data

Example:

Home → Products → Arduino → Arduino Uno

Breadcrumbs should represent the actual hierarchy.

Do not fabricate breadcrumb paths only for search engines.

---

# 25. Pagination

For large collections:

- Use crawlable URLs
- Avoid infinite-scroll-only discovery
- Provide accessible links where appropriate
- Use stable pagination URLs
- Avoid unnecessary parameter explosion

Do not blindly add old `rel=next/prev` implementations as if they are a current Google indexing requirement.

---

# 26. Faceted Navigation

Common in e-commerce.

Examples:

`/products?color=red`

`/products?brand=arduino`

`/products?sort=price`

`/products?color=red&brand=arduino&sort=price`

Audit whether each combination should exist in search.

Most combinations should not automatically become indexable pages.

Control:

- Crawlability
- Canonicalization
- Indexability
- Internal links
- Parameter handling
- Server load

Only index filter pages that have genuine standalone search value.

---

# 27. Internal Search

Internal search results generally should not become mass-indexed SEO landing pages.

Audit:

- `/search?q=...`
- Search parameters
- Empty search
- Automated query generation
- Infinite combinations

Prevent accidental indexation where appropriate.

---

# 28. JavaScript SEO

For SPA/SSR/hybrid apps verify:

- Important content appears in rendered HTML
- Routes have real URLs
- Navigation uses crawlable links
- History API/routing is correct
- No critical content depends exclusively on fragile client interaction
- Canonical is consistent before/after rendering
- Title/meta updates are correct
- Structured data is available correctly
- 404/redirect behavior works
- Nonexistent routes do not become soft 404s

Do not assume "it's React" means it is bad for SEO.

Do not assume "Google executes JavaScript" means rendering architecture is irrelevant.

---

# 29. Rendering Strategy

For public SEO-critical pages prefer an architecture that reliably exposes content to crawlers and users.

Possible approaches:

- SSR
- SSG
- ISR
- Server-rendered templates
- Hybrid rendering
- CSR where appropriate

Choose based on:

- Content freshness
- Scale
- Performance
- Hosting
- Data requirements
- SEO importance

Do not convert an entire application to SSR merely because one public page needs SEO.

---

# 30. Soft 404 Detection

Check:

- Nonexistent routes
- Deleted products
- Deleted articles
- Empty categories
- Invalid IDs
- Invalid slugs

They should not all return a successful-looking page with 200 status.

Provide an appropriate 404 or relevant redirect when a valid replacement exists.

---

# 31. Image SEO

For important images check:

- Correct `<img>`
- Descriptive filename
- Useful alt text
- Appropriate dimensions
- Responsive images
- `srcset`
- Modern formats where appropriate
- Compression
- Lazy loading for below-the-fold images
- Priority loading for genuinely critical images
- Width/height to reduce layout shifts
- CDN where appropriate

Do not keyword-stuff alt text.

Alt text describes the image for accessibility and context.

Decorative images may use empty alt text:

```html
alt=""
```

---

# 32. Preferred Images

For pages likely to appear in image-related search/discovery surfaces, ensure the preferred image is correctly represented through relevant page metadata and structured data where applicable.

Do not mark an image as a product/hero image if it does not actually represent the page/entity.

---

# 33. Image URLs

Ensure:

- Stable URLs
- No accidental auth requirement
- Correct content type
- No broken CDN links
- No unnecessary redirects
- Crawlable important images

---

# 34. Open Graph

For social sharing implement where appropriate:

```html
<meta property="og:title" content="...">
<meta property="og:description" content="...">
<meta property="og:type" content="website">
<meta property="og:url" content="https://example.com/page">
<meta property="og:image" content="https://example.com/image.jpg">
```

For articles/content where appropriate add relevant properties.

Open Graph is primarily for social previews, not a direct Google ranking system.

Do not confuse OG metadata with SEO metadata.

---

# 35. Twitter/X Cards

Where useful:

```html
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="...">
<meta name="twitter:description" content="...">
<meta name="twitter:image" content="...">
```

Use current platform-supported metadata and verify actual previews.

---

# 36. Favicon & Site Identity

Check:

- Favicon
- Appropriate formats
- Web app icons where applicable
- Manifest
- Consistent brand identity

Do not over-focus on favicon SEO; treat it as search-result/site identity hygiene.

---

# 37. Structured Data / Schema.org

Use JSON-LD by default when practical.

Example:

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Example",
  "url": "https://example.com/"
}
</script>
```

Rules:

- Valid JSON
- Correct schema type
- Correct properties
- Accurate values
- Matches visible page content
- No fake reviews
- No fake ratings
- No hidden information
- No irrelevant schema
- No mass-generated inaccurate markup

Structured data can make pages eligible for rich results; it does not guarantee rich-result display.

---

# 38. Organization Structured Data

For company/organization sites consider:

- Organization
- Name
- URL
- Logo
- SameAs
- Contact information where appropriate

Only include accurate properties.

---

# 39. WebSite Structured Data

For site-level identity/search features where appropriate use:

- WebSite
- Name
- URL

If implementing site-name related markup, ensure it reflects the actual site identity.

Do not create fake alternate names solely for SEO.

---

# 40. BreadcrumbList

For hierarchical pages:

```json
{
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": []
}
```

Build it dynamically from the actual page hierarchy.

---

# 41. Product Structured Data

For e-commerce product pages, assess:

- Product
- Name
- Description
- Image
- Brand
- SKU
- GTIN where legitimately available
- Offers
- Price
- Currency
- Availability
- URL
- AggregateRating/Review only when genuinely valid

Never invent:

- GTIN
- SKU
- Reviews
- Rating
- Price
- Availability

Ensure structured data agrees with the visible product information.

---

# 42. Product Variants

If variants have distinct URLs and represent meaningful product variations, ensure:

- Correct canonical strategy
- Variant-specific content
- Variant-specific structured data where applicable
- Correct price/availability
- Correct image
- Internal linking

Do not generate thousands of meaningless variant URLs.

---

# 43. Article Structured Data

For article content where applicable:

- Article type
- Headline
- Image
- Author
- Date published
- Date modified
- Main entity
- Publisher

Do not invent authorship or dates.

---

# 44. Person / Author Information

For expert content where relevant:

- Real author
- Author page
- Credentials where useful
- Relevant profile information
- Author relationship in structured data

Do not manufacture expertise.

---

# 45. Review Structured Data

Use only where legitimate and applicable.

Do not:

- Create fake reviews
- Mark up reviews that users cannot see
- Manipulate ratings
- Mark up third-party reviews incorrectly

---

# 46. FAQ / Q&A / Other Schema

Only implement structured-data types that are:

- Supported where relevant
- Correct for the content
- Properly implemented
- Useful to the search feature

Do not add every Schema.org type simply because it exists.

Search feature support changes over time; verify current Google documentation before implementing a rich-result-specific feature.

---

# 47. Local SEO

For local businesses assess:

- Business name
- Address
- Phone
- Opening hours
- Location pages
- Google Business Profile
- Local structured data
- Consistent business information
- Maps
- Service areas where relevant
- Local landing pages only when genuinely useful

Do not generate fake location pages for cities where the business has no meaningful presence.

---

# 48. International SEO

For multilingual/multiregional sites:

- Language URLs
- hreflang
- Canonical
- Language consistency
- Regional variants
- Sitemap
- Internal links

Example:

```html
<link rel="alternate"
      hreflang="en"
      href="https://example.com/en/page">

<link rel="alternate"
      hreflang="ar"
      href="https://example.com/ar/page">

<link rel="alternate"
      hreflang="x-default"
      href="https://example.com/page">
```

Rules:

- Use valid language/region codes
- Ensure reciprocal annotations
- Do not use hreflang to solve duplicate content unrelated to localization
- Do not canonicalize all language versions to one language
- Ensure each localized page is genuinely localized

---

# 49. RTL SEO

For Arabic/RTL projects verify:

- Correct `lang`
- Correct `dir`
- Arabic content
- Arabic title/meta
- Arabic URLs only when appropriate
- Correct hreflang
- Proper rendering
- No mixed-language metadata errors

SEO content should be written naturally for the target language, not translated mechanically just to fill tags.

---

# 50. Language Metadata

Use:

```html
<html lang="ar" dir="rtl">
```

or the appropriate project values.

Ensure the declared language matches the page's primary content.

---

# 51. Core Web Vitals & Page Experience

Monitor current Core Web Vitals:

- LCP
- INP
- CLS

Also monitor:

- TTFB
- FCP
- Overall responsiveness
- Mobile performance

Do not treat a perfect score as the goal by itself.

Optimize real user experience and business-critical pages.

---

# 52. LCP

Investigate:

- Hero image
- Main heading
- Server response
- CSS
- Fonts
- Render-blocking resources
- Image priority
- Client rendering

Do not lazy-load the actual LCP image if that delays it unnecessarily.

---

# 53. INP

Investigate:

- Long JavaScript tasks
- Heavy event handlers
- Excessive rendering
- Main-thread blocking
- Large hydration work
- Complex interactions

---

# 54. CLS

Prevent layout shifts caused by:

- Images without dimensions
- Ads
- Dynamic banners
- Fonts
- Late-loaded UI
- Injected content

Reserve space for dynamic content.

---

# 55. Mobile SEO

Verify:

- Responsive design
- Same primary content on mobile
- Same important metadata
- Same structured data
- Touch usability
- Mobile navigation
- No intrusive blocking UI
- Fast mobile experience
- No accidental mobile-only indexing differences

Do not create a separate mobile site unless there is a compelling reason.

---

# 56. Performance & SEO Interaction

Audit:

- Server response
- HTML size
- JS
- CSS
- Images
- Fonts
- API waterfalls
- Third-party scripts
- Ads
- Analytics
- Hydration
- Caching
- CDN

Do not remove useful functionality solely for a theoretical score.

---

# 57. Third-Party Scripts

Audit:

- Analytics
- Chat
- Ads
- Tracking
- Social widgets
- A/B testing
- Heatmaps

Check:

- Performance impact
- Blocking behavior
- Privacy
- Failure impact
- Duplicate scripts

---

# 58. Crawl Budget

For large sites only, assess:

- URL explosion
- Faceted navigation
- Duplicate URLs
- Infinite spaces
- Calendar pages
- Search results
- Session URLs
- Low-value archives
- Parameter combinations

Do not obsess over crawl budget for a small site where it is not a practical issue.

---

# 59. Indexing Control

Build a deliberate policy for:

### Index

- Important landing pages
- Products
- Categories
- Useful articles
- Useful service pages
- Public profiles where appropriate

### Usually exclude

- Admin
- Dashboard
- Login
- Cart
- Checkout
- Internal search
- Temporary preview
- Duplicate utility pages
- Private user data

But determine this per project.

---

# 60. Staging / Development Protection

Never accidentally expose staging environments as production SEO content.

Check:

- Authentication
- Network restrictions
- `noindex`
- robots
- DNS
- Canonical
- Environment variables
- Sitemap
- Search Console properties

For truly private environments, use access control; do not rely solely on robots.txt.

---

# 61. 404 / 410 / Deleted Content

When content disappears:

- Determine whether a replacement exists.
- If yes → relevant redirect.
- If no → appropriate 404/410.
- Remove from sitemap.
- Remove internal links.
- Update related structured data.

Do not redirect every deleted URL to the homepage.

---

# 62. Site Migration SEO

Before migration:

- Crawl old URLs
- Export indexed URLs
- Export top organic pages
- Export backlinks if available
- Map URLs
- Prepare redirects
- Preserve important content
- Preserve metadata
- Preserve canonicals
- Preserve structured data
- Preserve internal links

After migration:

- Test redirects
- Test canonicals
- Test sitemap
- Test robots
- Test status codes
- Test hreflang
- Test Search Console
- Monitor traffic/indexing
- Fix errors quickly

---

# 63. Domain Migration

If changing domain:

- Redirect old domain
- Preserve URL mapping
- Update canonical
- Update sitemap
- Update internal links
- Update OG URLs
- Update structured data
- Verify Search Console
- Monitor indexing

Do not launch the new domain with all old URLs redirecting to one homepage.

---

# 64. Analytics

Use appropriate measurement.

Possible:

- Google Search Console
- Analytics
- Server logs
- Business analytics
- SEO crawler

Track:

- Clicks
- Impressions
- CTR
- Queries
- Landing pages
- Indexing
- Coverage
- Rich-result performance
- Core Web Vitals
- Conversions
- Revenue where relevant

Do not optimize CTR at the expense of relevance or user satisfaction.

---

# 65. Search Console

Where access exists, inspect:

- URL Inspection
- Indexing
- Sitemaps
- Performance
- Core Web Vitals
- Manual actions
- Security issues
- Rich result reports

Use URL Inspection for important canonical/indexing questions.

Do not assume Search Console data is real-time.

---

# 66. Server Log SEO

For large/important sites, analyze crawler requests:

- Googlebot
- Bingbot where relevant
- Other legitimate crawlers

Look for:

- Crawl waste
- 5xx
- 4xx
- Redirects
- Parameter explosions
- Bot traps
- Important pages not crawled
- Unexpected URLs

Verify suspicious crawler identities before trusting user-agent strings.

---

# 67. Link Hygiene

Audit:

- Internal links
- Broken links
- Redirecting links
- Canonical mismatches
- Anchor text
- Orphan pages

External links:

- Use relevant, trustworthy sources
- Avoid manipulative link schemes
- Mark sponsored/UGC relationships correctly where applicable

---

# 68. Spam Policy Safety

Never implement:

- Keyword stuffing
- Cloaking
- Hidden text
- Doorway pages
- Fake structured data
- Fake reviews
- Link spam
- Automatically generated low-value pages
- Sneaky redirects
- Misleading metadata
- Scaled content created only to manipulate search

If a tactic exists primarily to manipulate rankings instead of helping users, reject it.

---

# 69. Programmatic SEO

If generating pages from database data:

Before allowing indexing verify each page has:

- Unique purpose
- Unique useful content
- Correct entity
- Accurate metadata
- Useful internal links
- Valid canonical
- Valid structured data
- Real search demand/value
- Quality threshold

Implement a quality gate.

Do not generate millions of near-identical pages.

---

# 70. E-commerce SEO

For e-commerce inspect:

- Home
- Categories
- Subcategories
- Products
- Variants
- Brands
- Filters
- Search
- Offers
- Inventory
- Out-of-stock products
- Reviews
- Breadcrumbs
- Product schema
- Merchant data where applicable
- Images
- Internal links

Out-of-stock handling should depend on whether the product is temporarily unavailable or permanently discontinued.

---

# 71. Product SEO

Each important product page should have:

- Unique title
- Useful description
- Product-specific H1
- Canonical
- Product structured data where applicable
- Price
- Availability
- Image
- Brand
- SKU
- GTIN where available
- Reviews only when legitimate
- Related products
- Category breadcrumb
- Internal links

Do not create unique SEO pages for every trivial option unless it provides genuine user/search value.

---

# 72. SaaS SEO

For SaaS:

Index:

- Homepage
- Features
- Solutions
- Use cases
- Pricing
- Integrations
- Documentation where useful
- Blog/resources
- Public comparison pages when genuinely useful

Usually exclude:

- Dashboard
- Account
- Private workspaces
- Internal app routes
- User-specific resources
- Private reports

Make public marketing pages server-rendered/SEO-accessible where appropriate.

---

# 73. Education SEO

For education/LMS:

Potentially index:

- Public courses
- Course categories
- Instructor profiles
- Educational articles
- Public lessons where intended
- Public resources

Usually exclude:

- Student dashboard
- Private grades
- Exams requiring login
- Private certificates
- Student-specific data

Never expose private educational data for SEO.

---

# 74. Image / Video / Media SEO

For media-heavy projects:

- Descriptive titles
- Captions where useful
- Alt text
- Thumbnails
- Structured data where applicable
- Stable media URLs
- Fast delivery
- Video metadata
- Transcripts when useful
- Indexable surrounding content

Do not create duplicate thin pages for every media asset without value.

---

# 75. SEO-Friendly API / Backend Behavior

SEO is not only frontend.

Backend must correctly provide:

- Status codes
- Redirects
- Canonicals
- Metadata
- Sitemap
- Robots
- Content
- Structured data
- Cache headers
- Compression
- Fast responses

Ensure APIs do not accidentally leak private data into public pages.

---

# 76. Metadata Architecture

Create a reusable SEO metadata system.

It should support:

- Default site metadata
- Per-page overrides
- Dynamic metadata
- Canonical
- Robots
- Open Graph
- Twitter/X
- Language
- Alternate URLs
- Structured data

Avoid copying metadata logic into dozens of components.

Use a single source of truth where practical.

---

# 77. Dynamic SEO Metadata

For dynamic routes:

Example:

`/products/[slug]`

Generate from real data:

- Title
- Description
- Canonical
- OG image
- Product schema
- Breadcrumb
- Robots state

If data does not exist:

- Return real 404
- Do not generate a fake product page
- Do not index it

---

# 78. SEO Image Architecture

Build a reusable system for:

- OG images
- Product images
- Article images
- Logo
- Favicon
- Responsive images

Do not generate expensive image transformations for every request if caching/static generation is sufficient.

---

# 79. SEO Component Architecture

Prefer reusable components such as:

- SEOHead/Metadata
- JsonLd
- Breadcrumbs
- Canonical
- OpenGraph
- Sitemap generator
- Robots generator

Do not build a giant "SEO framework" when simple metadata utilities are enough.

---

# 80. Technical SEO CI Checks

Where practical, automate:

- Broken links
- Missing title
- Duplicate title
- Missing description on important pages
- Missing H1
- Broken canonical
- Invalid canonical
- Noindex + sitemap conflict
- Sitemap invalid URLs
- Redirect chains
- 404 internal links
- Missing alt on important images
- Invalid JSON-LD
- Incorrect hreflang
- HTTP URLs in canonical
- Noncanonical URLs in sitemap

CI should fail only on issues that genuinely justify blocking a release.

Use warnings for lower-risk issues.

---

# 81. SEO Automated Validation

For each important route verify:

```text
HTTP status
Final URL
Canonical
Title
Meta description
Robots
H1
Lang
Hreflang
OG title
OG description
OG image
Structured data
Internal links
Images
Sitemap presence
```

---

# 82. SEO Security

Audit for:

- SEO spam injection
- Hacked pages
- Malicious redirects
- Injected canonical tags
- Injected sitemap URLs
- Fake structured data
- Cloaking
- Open redirects
- User-generated spam
- Comment spam
- Malicious links

A security compromise can become an SEO compromise.

---

# 83. Performance Budget

Set project-appropriate targets for:

- HTML
- JS
- CSS
- Images
- Fonts
- Requests
- TTFB
- LCP
- INP
- CLS

Do not blindly impose identical budgets on every project.

---

# 84. Accessibility × SEO

Check that:

- Important content is available to users
- Images have meaningful alternatives
- Navigation is usable
- Forms are labeled
- Headings are meaningful
- Content is not hidden from users purely for SEO

Accessibility and SEO overlap in many areas, but they are not identical systems.

---

# 85. SEO Over-Engineering Rules

Do NOT add:

- Hundreds of schema types
- Unnecessary SEO packages
- Complex metadata services
- Microservices for sitemap generation
- Separate SEO database
- Huge keyword tables
- Dozens of SEO dashboards
- Automated content factories
- Complex crawl systems

unless the project genuinely needs them.

For a small project:

Simple metadata + sitemap + robots + canonical + good content + performance + Search Console may be enough.

For a large e-commerce site:

Dynamic metadata + segmented sitemaps + faceted-navigation strategy + structured data + log analysis may be justified.

Scale the solution to the project.

---

# 86. SEO "Do Not Assume" Rules

Do not assume:

- More keywords = better SEO
- More pages = better SEO
- More schema = better SEO
- More backlinks = automatically better
- More text = better
- Higher Lighthouse score = guaranteed ranking
- Meta description = guaranteed snippet
- Canonical = guaranteed selected URL
- Sitemap = indexing guarantee
- `index,follow` is necessary on every page
- robots.txt removes a page from search
- JavaScript automatically prevents SEO
- SSR automatically guarantees SEO
- AI content is automatically bad
- AI content is automatically good

Verify each claim against the actual project and current search documentation.

---

# 87. SEO Audit Priority

Prioritize in this order unless project risk suggests otherwise:

## P0 — Critical

- Site not crawlable
- Important pages blocked
- Wrong domain canonical
- HTTPS/indexing catastrophe
- Entire site noindexed accidentally
- Major private data exposed publicly
- Massive redirect/404 failure
- Wrong robots.txt blocking important content

## P1 — High

- Broken canonical system
- Missing important pages from indexability
- Major JS rendering issue
- Duplicate URL explosion
- Multi-language misconfiguration
- Product/schema corruption
- Severe Core Web Vitals problems
- Major internal-link problems

## P2 — Medium

- Missing metadata
- Weak headings
- Broken breadcrumbs
- Image optimization
- Internal linking improvements
- Moderate performance issues

## P3 — Low

- Minor metadata improvements
- Minor semantic cleanup
- Non-critical enhancements

Do not spend hours on P3 while P0/P1 issues remain.

---

# 88. SEO Definition of Done

A public SEO-critical page is ready when:

- Correct URL
- Correct status code
- Intended indexability
- Correct canonical
- Correct title
- Useful description
- Correct H1
- Useful content
- Correct language
- Correct hreflang where applicable
- Internal links
- Breadcrumbs where useful
- Correct structured data where applicable
- Correct OG metadata
- Correct images
- Responsive
- Good performance
- No accidental duplicate
- No accidental noindex
- No accidental robots block
- Included in sitemap if appropriate
- No security exposure
- Valid error handling

---

# 89. Final SEO Audit Workflow

## Phase 1 — Discover

Inspect architecture, routes, content, rendering, domain, sitemap, robots, metadata, schema, performance, and analytics.

## Phase 2 — Inventory

Build route-level SEO matrix.

## Phase 3 — Crawlability

Check:

- robots
- sitemap
- links
- status codes
- redirects
- crawl traps

## Phase 4 — Indexability

Check:

- noindex
- canonicals
- duplicates
- soft 404
- staging
- private pages

## Phase 5 — On-Page

Check:

- title
- description
- H1
- headings
- content
- images
- links

## Phase 6 — Structured Data

Validate only relevant schemas.

## Phase 7 — Performance

Check:

- CWV
- TTFB
- JS
- CSS
- images
- mobile

## Phase 8 — International

Check language, hreflang, canonical, RTL/LTR.

## Phase 9 — Search Console / Analytics

Where available, inspect real search/indexing data.

## Phase 10 — Fix

Fix highest-impact issues first.

## Phase 11 — Regression

Re-check all SEO-critical routes after changes.

## Phase 12 — Report

Report:

- Passed
- Failed
- Fixed
- Remaining
- Priority
- Evidence
- Recommended action

---

# 90. SEO Audit Report Format

For every issue report:

```text
ID:
Category:
Severity:
URL/Component:
Current behavior:
Expected behavior:
Evidence:
Impact:
Root cause:
Recommended fix:
Verification:
Status:
```

Coverage:

```text
Technical SEO
Crawling
Indexing
Canonicalization
URLs
Redirects
Metadata
Content
Internal links
Images
Structured data
International SEO
Mobile
Performance
Accessibility
E-commerce
Security
Analytics
Migration
```

Never report an issue as confirmed if it was not actually verified.

---

# 91. Release Checklist

Before production:

## Technical

- HTTPS
- Preferred hostname
- Redirects
- Canonicals
- Robots
- Sitemap
- Status codes
- 404
- No accidental staging
- No accidental noindex

## On-page

- Titles
- Descriptions
- H1
- Content
- Images
- Internal links

## Structured data

- Valid JSON-LD
- Accurate entities
- No fake properties
- Relevant schema only

## International

- `lang`
- `dir`
- hreflang
- localized metadata
- localized canonicals

## Performance

- Mobile
- LCP
- INP
- CLS
- TTFB
- Images
- JS/CSS

## Measurement

- Search Console
- Analytics
- Sitemap submission
- Error monitoring

---

# 92. Post-Launch SEO Monitoring

After deployment monitor:

- Indexing
- Search impressions
- Clicks
- CTR
- Ranking trends
- Canonical selection
- Coverage
- 404s
- 5xx
- Redirects
- Sitemap errors
- Core Web Vitals
- Manual actions
- Security issues
- Organic conversions

Do not panic over normal short-term fluctuations.

Investigate meaningful changes with evidence.

---

# 93. Migration Monitoring

After a migration monitor:

- Old URLs
- New URLs
- Redirects
- Index coverage
- Canonicals
- Sitemap
- Traffic
- Search queries
- Top landing pages
- 404s
- 5xx
- Crawl behavior

Keep redirect mappings for an appropriate period and maintain them according to the migration strategy.

---

# 94. SEO Golden Rules

1. Crawlability comes before optimization.
2. Indexability comes before ranking optimization.
3. Correct URLs matter.
4. Canonicalization must be intentional.
5. Sitemap contains URLs you want discovered/indexed, not every URL.
6. Robots.txt is not access control.
7. Noindex requires crawlability to be reliably seen.
8. Redirects must be relevant.
9. Internal links matter.
10. Search intent matters more than keyword repetition.
11. Useful content beats filler.
12. Structured data must be truthful.
13. Schema does not guarantee rich results.
14. Metadata does not guarantee ranking.
15. Core Web Vitals matter, but scores are not the entire SEO strategy.
16. Mobile experience matters.
17. Accessibility improves overall quality but is not a synonym for SEO.
18. Multilingual pages need correct localization signals.
19. Programmatic SEO requires a quality threshold.
20. E-commerce requires careful product/indexation architecture.
21. Private data must never become public SEO content.
22. Security incidents can damage SEO.
23. Measure before optimizing.
24. Automate repeatable checks.
25. Keep SEO architecture simple unless scale requires more.
26. Never implement an SEO tactic solely because someone says "Google likes it."
27. Prefer current Google documentation over outdated SEO folklore.
28. Never claim an SEO improvement guarantees rankings.
29. Fix root causes.
30. Optimize for users first and search engines second.

---

# 95. Final Principle

SEOGuard must behave as an SEO engineer, not a meta-tag generator.

For every project:

**Understand → Inventory → Crawl → Index → Canonicalize → Optimize → Structure → Perform → Measure → Verify**

Be extremely thorough about SEO risk, but avoid unnecessary SEO complexity.

The best SEO implementation is not the one with the most tags, schemas, pages, keywords, plugins, or automation.

It is the simplest maintainable system that makes the site's important content:

- Discoverable
- Crawlable
- Renderable
- Indexable
- Canonically correct
- Understandable
- Useful
- Fast
- Accessible
- Secure
- Measurable

Always prioritize real search visibility and user value over SEO theater.

---

# 96. ProjectGuard Security Integration

SEOGuard and ProjectGuard are complementary. SEO must never weaken application security, privacy, authorization, or data isolation.

When both skills are active, verify:

- Private/authenticated routes cannot become public indexable pages.
- User-specific URLs are not exposed through sitemap, internal links, canonical tags, structured data, or public APIs.
- SEO rendering does not bypass authorization.
- SSR/SSG/ISR caches are correctly scoped and cannot serve one user's private content to another user or tenant.
- Public structured data contains no sensitive/internal fields.
- User-generated content cannot inject malicious links, schema, metadata, canonical tags, or redirects.
- SEO preview/image-generation endpoints cannot be abused to fetch internal resources or leak private data.
- Sitemap generation uses authorized/public data only.
- Search-engine crawlers cannot access content that normal users are not authorized to access.

Security takes precedence over SEO optimization. Never expose protected content to make it crawlable.

---

# 97. SEO Rendering & Cache Safety

For SSR, SSG, ISR, edge rendering, or CDN caching verify:

- Public pages contain only public data.
- User/tenant-specific content is never included in a shared cache response.
- Cache keys include every dimension that legitimately changes the response.
- Authentication state does not accidentally alter a shared public HTML response.
- Canonical, title, description, OG tags, and structured data cannot leak another entity's data.
- Revalidation/invalidation occurs after important content changes.
- Preview/draft content is not accidentally published or indexed.

---

# 98. SEO Content Injection & Metadata Security

Treat database/CMS/user-generated metadata as untrusted input. Audit:

- Title injection
- Description injection
- Canonical injection
- Open Graph injection
- JSON-LD injection
- HTML injection
- URL injection
- Redirect injection
- Sitemap injection

Escape/serialize values according to their output context. Do not concatenate untrusted strings into raw JSON-LD or HTML.

---

# 99. SEO Observability & Regression

For production projects, monitor SEO regressions after releases that change routing, rendering, content, deployment, or domains.

Automate where practical:

- Important routes return expected status codes.
- Important routes remain indexable.
- Canonicals remain correct.
- Sitemap contains intended URLs.
- Robots does not accidentally block important content.
- Titles/descriptions remain present and valid.
- Structured data remains parseable.
- No major increase in 404/5xx responses.
- No unexpected redirect chains.
- Public/private route boundaries remain intact.

---

# 100. Final SEO Engineering Rule

SEOGuard must operate as a senior technical SEO engineer working with the existing product architecture. It must inspect first, identify the pages that actually matter, implement the smallest maintainable SEO system that satisfies the project's needs, verify the rendered result, and regression-test the implementation.

Never sacrifice security, privacy, correctness, performance, accessibility, or maintainability for an SEO metric.
