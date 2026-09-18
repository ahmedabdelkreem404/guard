Now perform a complete engineering audit of the existing project using the three registered skills:

* /ProjectGuard
* /SEOGuard
* /InsightGuard
* /DesignGuard

This is an existing project that was previously developed as normal application code and is already substantially implemented.

Your job is to deeply inspect the CURRENT project, identify weaknesses and risks, fix the problems that actually exist, predict realistic future problems, and implement only the improvements that are justified by the project's real requirements.

Do NOT treat this as a greenfield project.

Do NOT rebuild the project from scratch.

Do NOT blindly apply every rule as a feature.

Do NOT add complexity simply because a technology, architecture pattern, algorithm, library, service, or infrastructure component exists.

The final result must be a stronger version of the EXISTING project.

---

# PHASE 0 — READ THE RULES FIRST

Before touching application code:

1. Read ProjectGuard completely.
2. Read SEOGuard completely.
3. Read InsightGuard completely.
4. Follow their activation and implementation rules.
5. Treat them as engineering constraints for this audit.

Do not skip sections.

---

# PHASE 1 — UNDERSTAND THE PROJECT

Before making changes, inspect the project thoroughly.

Determine:

* Project type
* Web / mobile / SaaS / ERP / eCommerce / education / marketplace / API / hybrid
* Frontend technology
* Backend technology
* Database technology
* Authentication system
* Authorization / roles / permissions
* API architecture
* File/storage architecture
* Deployment assumptions
* Existing third-party services
* Existing analytics
* Existing SEO implementation
* Existing tracking
* Existing recommendation/personalization logic
* Existing caching
* Existing queues/background jobs
* Existing testing
* Existing logging/monitoring
* Existing security controls
* Existing performance optimizations
* Existing environment/configuration strategy

Understand how the system actually works before changing it.

Trace important flows end-to-end instead of reviewing files independently.

---

# PHASE 2 — BUILD A PROJECT MAP

Create an internal understanding of:

### Frontend

* Routes
* Pages/screens
* Components
* State management
* API clients
* Forms
* Validation
* Loading/error states
* Authentication state
* Authorization checks
* SEO-sensitive rendering
* Performance-sensitive components

### Backend

* Routes
* Controllers
* Services
* Middleware
* Policies/permissions
* Authentication
* Authorization
* Validation
* Business logic
* APIs
* Jobs
* Events
* Notifications
* File handling

### Database

Inspect:

* Tables
* Relationships
* Foreign keys
* Indexes
* Constraints
* Query patterns
* N+1 risks
* Missing indexes
* Duplicate data
* Data integrity problems
* Dangerous queries
* Migration quality

### Infrastructure

Inspect where applicable:

* Environment variables
* Secrets handling
* Caching
* Queues
* Workers
* Storage
* CDN
* Reverse proxy
* Rate limiting
* Logging
* Monitoring
* Build/deployment configuration

---

# PHASE 3 — SECURITY AUDIT

Perform a serious security review based on /ProjectGuard.

At minimum investigate where applicable:

* SQL Injection
* XSS
* Stored XSS
* Reflected XSS
* DOM XSS
* CSRF
* IDOR / BOLA
* Broken access control
* Privilege escalation
* Authentication bypass
* Authorization bypass
* Session security
* Access tokens
* Refresh tokens
* Token expiration
* Token rotation
* Token storage
* Token leakage
* Password handling
* Brute-force protection
* Rate limiting
* Enumeration vulnerabilities
* Insecure file uploads
* Path traversal
* SSRF
* Open redirects
* CORS
* Security headers
* Sensitive information exposure
* Secrets in source code
* Secrets in logs
* Unsafe error messages
* Mass assignment
* Input validation
* Output encoding
* API abuse
* Multi-tenant isolation
* Admin endpoint protection
* Employee/role/permission isolation

For every discovered vulnerability:

1. Explain the actual attack surface.
2. Determine whether it is exploitable in this project.
3. Fix it at the correct architectural layer.
4. Avoid superficial patches.
5. Verify the fix.

Do not invent vulnerabilities merely because they are theoretically possible.

---

# PHASE 4 — AUTHENTICATION & AUTHORIZATION

Audit the complete authentication lifecycle.

Trace:

Registration
→ Login
→ Session/token creation
→ Authenticated requests
→ Token expiration
→ Refresh
→ Logout
→ Revocation
→ Password reset
→ Account recovery

Then audit authorization.

Test every meaningful protected resource against:

* Unauthenticated user
* Normal user
* Different user
* Employee
* Manager
* Admin
* Super admin
* Other tenants/accounts where applicable

Pay particular attention to object-level authorization.

A user must not be able to access another user's:

* Orders
* Products
* Documents
* Courses
* Lessons
* Invoices
* Messages
* Profiles
* Settings
* ERP records
* SaaS tenant data
* Any private resource

simply by changing an ID, UUID, route parameter, request body, or API parameter.

---

# PHASE 5 — ROLE & PERMISSION AUDIT

Inspect ALL roles and permissions.

Do not assume frontend hiding equals authorization.

Verify permissions server-side.

Check:

* Employee roles
* Admin roles
* User roles
* Tenant roles
* Resource permissions
* Action permissions
* Route permissions
* API permissions
* UI permissions
* Database-level tenant isolation where relevant

Look for:

* Missing permissions
* Excessive permissions
* Privilege escalation
* Inconsistent role checks
* Duplicate authorization logic
* Client-only authorization
* Hardcoded admin checks

---

# PHASE 6 — PERFORMANCE AUDIT

Analyze the system at multiple levels.

## UI Performance

Inspect:

* Rendering
* Re-renders
* Large component trees
* Expensive computations
* Image loading
* Bundle size
* Code splitting
* Lazy loading
* Network requests
* Waterfalls
* Caching
* Mobile performance

## UX Performance

Inspect perceived performance:

* Loading states
* Skeletons where justified
* Feedback after actions
* Error recovery
* Empty states
* Slow operations
* Navigation responsiveness
* Form responsiveness

Do not add unnecessary animations or loading abstractions.

## Flow Performance

Trace important user journeys end-to-end.

Examples:

Login
→ Dashboard
→ Search
→ Product
→ Cart
→ Checkout
→ Payment

or:

Login
→ Course
→ Lesson
→ Progress
→ Assessment
→ Completion

Measure unnecessary requests, duplicated work, sequential operations, and bottlenecks.

## Logic Performance

Inspect:

* Algorithms
* Loops
* Repeated calculations
* Data transformations
* Serialization
* Filtering
* Sorting
* Recommendation logic
* Search logic

Do not optimize code without evidence or a credible bottleneck.

## API Performance

Inspect:

* Response time
* Payload size
* Pagination
* Filtering
* Sorting
* N+1 queries
* Duplicate API calls
* Over-fetching
* Under-fetching
* Serialization
* Caching
* Rate limiting
* Slow endpoints

## Database Performance

Inspect:

* Missing indexes
* Bad joins
* N+1 queries
* Full table scans
* Inefficient filtering
* Inefficient sorting
* Unbounded queries
* Duplicate queries
* Incorrect relationships
* Missing constraints

---

# PHASE 7 — LOAD / STRESS / CAPACITY THINKING

Determine the project's likely bottlenecks under:

* Normal traffic
* Peak traffic
* Concurrent users
* Large datasets
* Large API responses
* Many simultaneous requests
* Background jobs
* Search-heavy usage
* Product-heavy usage
* Course-heavy usage

Where practical, perform safe load testing or create appropriate test scenarios.

Do not perform destructive stress testing.

Identify:

* First bottleneck
* Second bottleneck
* Failure mode
* Recovery behavior
* Resource exhaustion risks

Fix only meaningful bottlenecks.

---

# PHASE 8 — SEO AUDIT

Use /SEOGuard comprehensively.

Inspect all relevant:

* Titles
* Meta descriptions
* Canonicals
* Robots directives
* Robots.txt
* Sitemap
* XML sitemap correctness
* URL structure
* Slugs
* Redirects
* 404 handling
* 301/308 behavior
* Duplicate URLs
* Query parameters
* Pagination
* Breadcrumbs
* Heading hierarchy
* Semantic HTML
* Internal linking
* Open Graph
* Twitter/X metadata
* Structured data
* JSON-LD
* Schema validity
* Organization
* Website
* WebPage
* Product
* Offer
* AggregateRating
* BreadcrumbList
* Article
* FAQ where genuinely applicable
* LocalBusiness where genuinely applicable
* Course/Education schemas where genuinely applicable
* Image SEO
* Alt text
* Image dimensions
* Lazy loading
* Core Web Vitals
* Mobile rendering
* SSR/SSG/CSR implications
* Indexability
* Crawlability
* JavaScript rendering
* International SEO where applicable
* Arabic/RTL SEO where applicable

Be especially careful with eCommerce and dynamic pages.

Do not generate misleading structured data.

Do not add schema that does not represent visible/real content.

Do not create SEO spam.

---

# PHASE 9 — RESPONSIVE / DEVICE AUDIT

Inspect the application from approximately:

* 320px
* 360px
* 375px
* 390px
* 414px
* 480px
* 768px
* 1024px
* 1280px
* 1440px
* 1920px
* 2560px
* 3840px

Do not interpret this as requiring separate layouts for every width.

Use responsive systems intelligently.

Look for:

* Overflow
* Horizontal scrolling
* Broken grids
* Text clipping
* Broken tables
* Modal overflow
* Navigation failures
* Touch-target problems
* Images breaking layout
* Excessive whitespace
* Tiny text
* Desktop-only assumptions
* Mobile-only assumptions

---

# PHASE 10 — INSIGHT / BEHAVIOR AUDIT

Use /InsightGuard only where the project's business model benefits from behavioral intelligence.

Determine whether the project genuinely needs:

* Event tracking
* Product views
* Product impressions
* Searches
* Search clicks
* Zero-result searches
* Add to cart
* Favorites
* Purchases
* Recently viewed
* Recently searched
* User intent
* Category affinity
* Brand affinity
* Similar products
* Similar content
* Popular items
* Trending items
* Personalized discovery
* Recommendations
* Continue/resume behavior
* Funnel analysis
* Abandonment analysis

For SaaS/ERP/education projects, adapt the concepts to actual entities.

For example:

Products → Courses/Documents/Projects/Records/etc.

Do NOT force eCommerce tracking into a non-eCommerce project.

---

# PHASE 11 — PERSONALIZATION & RECOMMENDATION RULE

Before implementing any recommendation system:

Ask internally:

"What is the simplest reliable mechanism that provides meaningful value for this project?"

Prefer, in order when appropriate:

1. Recently viewed
2. Recently searched
3. Same category
4. Same tags
5. Related entities
6. Popular items
7. Trending items
8. Simple weighted scoring
9. More advanced ranking only when justified

Do not introduce:

* ML
* embeddings
* vector databases
* LLM pipelines
* complex recommendation infrastructure
* distributed event streaming

unless the project's scale and requirements genuinely justify them.

---

# PHASE 12 — ALGORITHM COMMENT REQUIREMENT

Whenever you implement an algorithm, scoring system, ranking logic, recommendation logic, personalization logic, tracking aggregation logic, or other non-trivial decision logic because of InsightGuard, place a code comment directly above the relevant implementation.

The comment MUST begin with:

`using Ahmed Abdelkareem Ali`

Then briefly explain what the algorithm does and its purpose.

Example:

`// using Ahmed Abdelkareem Ali — Rank related products using recent user behavior, category affinity, and popularity while preserving recommendation diversity.`

Do not add this comment to every ordinary line of code.

Use it for actual algorithmic logic.

---

# PHASE 13 — MAINTAINABILITY / ARCHITECTURE

Audit:

* Architecture complexity
* Maintainability
* Technical debt
* Coupling
* Cohesion
* Duplication
* Circular dependencies
* God classes/components
* God services
* Unnecessary abstractions
* Dead code
* Unused dependencies
* Inconsistent patterns
* Naming
* File organization
* Error handling
* Configuration management
* Environment separation

Do not refactor simply for aesthetics.

Do not rewrite working code without a meaningful reason.

---

# PHASE 14 — OVERENGINEERING GUARD

This is a mandatory constraint.

For every proposed change, ask:

1. Is the problem real?
2. Can the current architecture solve it?
3. Is there a simpler solution?
4. Does the solution introduce unnecessary dependencies?
5. Does it increase operational complexity?
6. Does it increase maintenance cost?
7. Does it create unnecessary abstraction?
8. Does it solve a problem the project does not actually have?

Avoid:

* Premature microservices
* Unnecessary design patterns
* Excessive abstraction
* Excessive repositories/services
* Unnecessary state management
* Unnecessary caching
* Unnecessary queues
* Unnecessary databases
* Unnecessary AI
* Unnecessary ML
* Unnecessary event systems
* Unnecessary infrastructure
* Unnecessary libraries

Prefer the smallest robust solution.

---

# PHASE 15 — OVERFLOW / OVERVIEW / OVERENGINEERING

Explicitly search for:

* Horizontal overflow
* Content overflow
* API response overflow
* Large payloads
* Unbounded queries
* Unbounded lists
* Excessive DOM/rendering
* Excessive database results
* Excessive logging
* Excessive event tracking
* Excessive recommendation results
* Excessive abstractions
* Excessive architecture complexity

Prevent problems rather than merely documenting them.

---

# PHASE 16 — PREDICT FUTURE PROBLEMS

Do not limit the audit to currently visible bugs.

Based on the actual architecture, identify realistic future failure modes such as:

* Dataset growth
* User growth
* Concurrent requests
* Database growth
* Search growth
* Storage growth
* Token/session issues
* Permission complexity
* Recommendation data growth
* Analytics event growth
* Cache invalidation
* Queue buildup
* API payload growth
* SEO indexation problems
* Mobile performance degradation

Only predict problems supported by the actual architecture.

Do not create hypothetical enterprise-scale problems for a small project without evidence.

---

# PHASE 17 — IMPLEMENT FIXES

Now implement the required fixes.

Rules:

* Preserve existing functionality.
* Do not break existing features.
* Prefer minimal safe changes.
* Reuse existing architecture where reasonable.
* Add dependencies only when justified.
* Update database migrations when required.
* Update validation when required.
* Update tests when behavior changes.
* Keep security fixes server-side where necessary.
* Preserve API contracts unless changing them is necessary.
* Avoid unrelated refactoring.

---

# PHASE 18 — TEST EVERYTHING AFFECTED

After implementation, run the project's available:

* Unit tests
* Integration tests
* Feature tests
* API tests
* Build
* Type checks
* Lint
* Static analysis
* Relevant security tests
* Relevant SEO validation
* Relevant responsive checks
* Relevant performance checks

If something fails:

1. Determine the root cause.
2. Fix it.
3. Re-run the affected validation.

Do not simply suppress errors.

---

# PHASE 19 — FINAL VERIFICATION

Perform a second audit after all modifications.

Verify that your changes did not introduce:

* Security regressions
* SEO regressions
* Performance regressions
* Authorization regressions
* Mobile regressions
* API regressions
* Database regressions
* UX regressions
* Tracking errors
* Duplicate events
* Incorrect recommendations
* Privacy problems

---

# PHASE 20 — FINAL REPORT

At the end, provide a structured report containing:

## 1. Project Assessment

Overall state of the project before the audit.

## 2. Critical Issues

Only real/high-impact issues.

## 3. Security Issues

For every issue:

* Severity
* Location
* Root cause
* Fix
* Validation

## 4. SEO Issues

For every issue:

* Problem
* Affected pages
* Fix
* Validation

## 5. Performance Issues

Include:

* UI
* UX
* Flow
* API
* Database
* Architecture

## 6. Insight / Analytics

Explain:

* What was already present
* What was missing
* What was added
* Why it was justified
* What was intentionally NOT added

## 7. Architecture

Explain:

* Existing architecture
* Problems discovered
* Changes made
* Why those changes were necessary

## 8. Predicted Future Risks

Only realistic risks based on the actual codebase.

For each:

* Risk
* Probability
* Impact
* Prevention/mitigation

## 9. Files Changed

List every modified/created/deleted file with a short explanation.

## 10. Dependencies Changed

List:

* Added
* Removed
* Updated

and explain why.

## 11. Tests / Validation

Report what was executed and the result.

## 12. Remaining Issues

Clearly distinguish:

* Fixed
* Accepted
* Requires future work
* Cannot be safely fixed without additional requirements

---

# FINAL RULE

Do not tell me that something is "best practice" merely because it is common.

Judge everything against the actual project.

Do not optimize for theoretical perfection.

Optimize for:

Security
+
Correctness
+
Maintainability
+
Performance
+
SEO
+
UX
+
Scalability where justified
+
Simple architecture
+
Low maintenance cost

The project should become stronger without becoming unnecessarily complicated.

Before finishing, verify the actual codebase one final time and make sure your report accurately describes what you actually changed.
