# ProjectGuard Skill

## Purpose

This skill is a reusable, project-agnostic quality, security, performance, architecture, and reliability review framework.

When working on ANY software project—web, mobile, desktop, API, SaaS, ERP, LMS/education, e-commerce, admin dashboard, backend, frontend, or full-stack—apply this framework proactively without requiring the user to repeat the checklist.

The goal is not to "test everything blindly." The goal is to discover real defects, security weaknesses, performance bottlenecks, architectural risks, maintainability problems, and poor UX while avoiding unnecessary complexity, over-engineering, false positives, and destructive testing.

---

# 0. Core Operating Rules

1. Inspect the project before changing it.
2. Understand the architecture, stack, data model, authentication, authorization, integrations, and critical user flows first.
3. Build a project-specific test matrix from this skill.
4. Prioritize by risk and business impact.
5. Never assume that frontend validation is security.
6. Never trust client-controlled IDs, roles, prices, permissions, tenant IDs, or state.
7. Test both happy paths and hostile/invalid paths.
8. Test at boundaries: browser/app ↔ API, API ↔ database, service ↔ service, user ↔ tenant, client ↔ storage.
9. Prefer reproducible, automated tests where practical.
10. Do not weaken production systems to make tests pass.
11. Do not perform destructive security or load testing against production unless explicitly authorized and safely controlled.
12. Separate confirmed bugs from hypotheses and tool limitations.
13. Fix root causes rather than hiding symptoms.
14. After fixes, run focused regression tests and then broader regression where appropriate.
15. Do not introduce infrastructure, libraries, abstractions, patterns, or services without a concrete need.
16. Avoid over-view: do not create excessive dashboards, pages, abstractions, or architecture merely because they might be useful.
17. Avoid overflow: prevent content, data, layouts, logs, queues, memory, database results, and UI states from growing without bounds.
18. Avoid over-engineering: use the simplest design that safely satisfies current requirements and foreseeable needs.
19. Preserve existing behavior unless a change is intentionally required.
20. Keep security, performance, reliability, and maintainability proportional to the project's actual risk.

---

# 1. Initial Project Reconnaissance

Before testing deeply, inspect:

## Project Structure

- Frontend
- Backend
- Mobile apps
- APIs
- Database
- Workers/jobs
- Queues
- Cron/scheduled tasks
- Storage
- Authentication
- Authorization
- Third-party integrations
- Payment systems
- Email/SMS/push
- Analytics
- Caching
- CDN
- CI/CD
- Infrastructure
- Environment configuration
- Tests
- Documentation

## Identify

- Frameworks and versions
- Runtime versions
- Package managers
- Build tools
- ORM
- Database engine/version
- API style: REST/GraphQL/RPC/etc.
- Authentication strategy
- Session/token strategy
- Role/permission model
- Multi-tenancy model
- File storage model
- Deployment model
- Critical business entities
- Critical workflows
- External dependencies

## Documentation Review

Check:

- README
- Architecture documentation
- API documentation
- Database/schema documentation
- Environment/config documentation
- Deployment documentation
- ADRs if present
- Security documentation
- Test documentation

Do not demand documentation that is unnecessary for a small project. Improve documentation only where it reduces real operational or maintenance risk.

---

# 2. Requirements & Functional Testing

Verify that implemented behavior matches requirements.

## Test

- Registration
- Login
- Logout
- Password reset
- Profile
- CRUD operations
- Search
- Filtering
- Sorting
- Pagination
- Forms
- Validation
- Notifications
- Emails
- Uploads/downloads
- Imports/exports
- Settings
- Admin functions
- Permissions
- Billing
- Subscriptions
- Payments
- Reports
- Dashboards
- Integrations

For every feature verify:

- Valid input
- Invalid input
- Missing input
- Boundary input
- Duplicate input
- Unauthorized input
- Unauthenticated input
- Conflicting state
- Retry behavior
- Failure behavior
- Recovery behavior

---

# 3. Authentication Testing

## Registration

Check:

- Duplicate email/username
- Invalid email
- Weak/invalid password according to requirements
- Missing fields
- Case handling
- Email verification
- Verification-token expiration
- Verification-token reuse
- Enumeration risks
- Rate limiting
- Abuse prevention

## Login

Check:

- Correct credentials
- Wrong password
- Unknown account
- Empty values
- Case sensitivity rules
- Rate limiting
- Brute-force protection
- Account lockout/temporary throttling where appropriate
- MFA if implemented
- Remember-me behavior
- Session creation
- Device/session behavior
- Logout

## Password Reset

Check:

- Token entropy
- Token expiration
- One-time use
- Token reuse
- Account enumeration
- Rate limiting
- Password update
- Existing-session invalidation according to security policy

## Session Security

Check:

- Session expiration
- Idle timeout if required
- Absolute timeout if required
- Logout invalidation
- Logout-all-devices
- Session fixation
- Concurrent sessions
- Re-authentication for sensitive actions
- Secure cookie configuration when cookies are used

Additional authentication checks:

- Passwords are stored with a slow, salted password-hashing algorithm such as Argon2id, bcrypt, or scrypt; never plaintext, reversible encryption, or fast hashes alone.
- Email-change flow requires verification of the new email before it becomes the login identity. Notify the old email where appropriate.
- Test trial/promo abuse when eligibility is tied to one email address, including disposable-email abuse where relevant.

---

# 4. Access Token & Refresh Token Testing

When token-based authentication exists:

## Access Token

Check:

- Expiration
- Invalid token
- Missing token
- Malformed token
- Tampered token
- Wrong audience/issuer where applicable
- Wrong scope
- Wrong permissions
- Token replay considerations
- Secure transport
- Safe storage strategy
- No unnecessary sensitive data in token payload

## Refresh Token

Check:

- Expiration
- Rotation
- Revocation
- Reuse detection where appropriate
- Logout invalidation
- Password-change invalidation where appropriate
- Device/session behavior
- Secure storage
- Secure transport
- Token theft/replay resilience

Never assume JWT = secure. Validate the complete authentication design.

---

# 5. Authorization & RBAC

Authorization must be tested independently from authentication.

Test:

- Role permissions
- Resource permissions
- Action permissions
- Ownership rules
- Organization/tenant boundaries
- Admin boundaries
- Employee boundaries
- Manager boundaries
- User boundaries
- Guest boundaries

For every important resource test:

- View
- Create
- Update
- Delete
- Approve
- Reject
- Publish
- Unpublish
- Export
- Import
- Assign
- Archive
- Restore
- Manage

Build a role × resource × action matrix.

Expected outcomes must be explicit:

- Allowed → correct result
- Authenticated but forbidden → 403 or appropriate equivalent
- Unauthenticated → 401 or appropriate equivalent
- Nonexistent resource → appropriate 404/response without leaking information

Never rely on hidden UI buttons as authorization.

Also inspect business-sensitive fields in API responses, even when the UI does not render them. Examples include cost price, margin, supplier pricing, internal analytics, and other employee-only fields.

---

# 6. IDOR / BOLA / Object-Level Authorization

Test whether one user can access another user's resources by changing:

- Numeric IDs
- UUIDs
- Slugs
- Query parameters
- Path parameters
- Request bodies
- Nested resource IDs
- File IDs
- Order IDs
- Invoice IDs
- Course IDs
- Student IDs
- Employee IDs
- Report IDs

Examples of resources:

- Users
- Orders
- Payments
- Invoices
- Files
- Courses
- Lessons
- Exams
- Certificates
- Employees
- Students
- Reports
- Organizations
- Tenants

Test read, update, delete, download, export, and action endpoints—not only GET.

---

# 7. Multi-Tenant SaaS Isolation

For SaaS projects, treat tenant isolation as a critical security boundary.

Verify:

- Tenant identification
- Tenant authorization
- Database queries scoped to tenant
- API responses scoped to tenant
- Search scoped to tenant
- Reports scoped to tenant
- Exports scoped to tenant
- Files scoped to tenant
- Cache keys scoped to tenant
- Queues/jobs scoped to tenant
- Notifications scoped to tenant
- Background workers scoped to tenant
- Webhooks scoped correctly
- Analytics scoped correctly

Test:

Tenant A user → cannot read/write/delete/export Tenant B data.

Test both normal endpoints and indirect access paths.

---

# 8. Injection Security

Test according to the technologies actually used:

- SQL Injection
- NoSQL Injection
- Command Injection
- OS Command Injection
- LDAP Injection
- XPath Injection
- Template Injection
- Header Injection
- CRLF Injection
- Expression-language injection where applicable

Use safe, controlled test inputs and do not damage data.

---

# 9. XSS Testing

Test:

- Reflected XSS
- Stored XSS
- DOM-based XSS
- Search
- Query parameters
- Forms
- Comments
- User profiles
- Product descriptions
- Rich text editors
- Admin fields
- Notifications
- Imported content
- URLs

Verify output encoding and sanitization according to context.

Do not rely solely on a generic sanitizer. Context matters: HTML, attribute, URL, JavaScript, CSS, etc.

---

# 10. CSRF

Where cookie/session authentication is used, test:

- State-changing requests
- Missing CSRF token
- Invalid CSRF token
- Reused token behavior
- Cross-origin requests
- SameSite cookie behavior

For bearer-token APIs that do not automatically authenticate using cookies, assess whether CSRF applies rather than adding unnecessary CSRF mechanisms.

---

# 11. CORS

Check:

- Allowed origins
- Unauthorized origins
- Credentials
- Preflight
- Methods
- Headers
- Wildcard configuration
- Development origins accidentally allowed in production

Never treat CORS as an authentication or authorization mechanism.

---

# 12. SSRF

For server-side URL fetching features, test:

- URL validation
- Redirect handling
- Internal network access
- Cloud metadata endpoints
- Private IP ranges
- Localhost
- DNS rebinding considerations
- Protocol restrictions
- Allowlist/denylist design

Only test authorized environments and do not access real sensitive infrastructure.

---

# 13. Path Traversal

Test file/path handling for:

- Relative paths
- Parent-directory traversal
- Encoded traversal
- Alternate path representations
- Download endpoints
- Preview endpoints
- Import/export paths
- Template paths

Verify canonicalization and authorization before access.

---

# 14. File Upload Security

Test:

- Extension validation
- MIME validation
- Content validation
- File size
- Filename handling
- Path handling
- Executable content
- Scriptable formats
- SVG handling
- Image processing
- Archive handling
- Duplicate names
- Private/public storage
- Direct URL access
- Unauthorized downloads
- Malware scanning where required

Never trust only the filename or client-provided MIME type.

For spreadsheet exports, test CSV/Excel formula injection: values beginning with `=`, `+`, `-`, or `@` must be neutralized or explicitly treated as text.

---

# 15. Sensitive Data Protection

Check:

- Passwords never returned unnecessarily
- Tokens not exposed
- Secrets not exposed
- API keys not exposed
- Payment data handled correctly
- PII minimized
- Sensitive fields excluded from logs
- Sensitive fields excluded from analytics
- Error messages do not leak internals
- Debug mode disabled in production
- Stack traces not exposed to users
- Source maps handled according to security policy

---

# 16. Secrets Management

Check:

- Environment variables
- Secret storage
- API keys
- Database credentials
- Signing keys
- Encryption keys
- Third-party credentials
- CI/CD secrets
- Mobile configuration

Look for accidentally committed secrets.

Never hardcode production secrets.

Additional checks:
- Run dependency vulnerability scanning routinely, not only once at project setup.
- Review lock files and dependency changes as part of CI/review.
- Treat dependency and supply-chain risk as a recurring security control.

Do not expose server-only secrets in frontend/mobile bundles.

---

# 17. Security Headers & Transport

Where applicable check:

- HTTPS
- HSTS
- Content-Security-Policy
- X-Content-Type-Options
- Referrer-Policy
- Frame protection
- Permissions-Policy
- Secure cookies
- HttpOnly cookies
- SameSite cookies

Use headers appropriate to the actual architecture. Do not blindly add conflicting policies.

---

# 18. Rate Limiting & Abuse Prevention

Identify sensitive/expensive endpoints:

- Login
- Password reset
- Registration
- OTP
- Search
- Expensive reports
- File processing
- AI generation
- Email sending
- SMS sending
- Payment actions
- Public APIs

Check:

- Rate limits
- Burst behavior
- Per-user limits
- Per-IP limits where appropriate
- Per-tenant limits
- Retry behavior
- 429 responses
- Abuse-resistant expensive operations

---

# 19. DoS / DDoS Resilience

Do not perform destructive DDoS attacks.

Assess resilience through controlled testing:

- Rate limiting
- CDN
- WAF
- Connection limits
- Request-size limits
- Upload limits
- Query limits
- Pagination limits
- Queue limits
- Timeouts
- Circuit breakers where appropriate
- Caching
- Autoscaling where appropriate

For expensive operations test controlled resource exhaustion in a safe environment.

---

# 20. Business Logic Security

Test rules that cannot be caught by generic security scanners.

Examples:

- Price manipulation
- Negative quantity
- Negative balance
- Discount > allowed limit
- Coupon reuse
- Expired coupon
- Coupon stacking
- Refund greater than paid amount
- Unauthorized approval
- Unauthorized state transition
- Bypassing subscription restrictions
- Accessing expired content
- Changing ownership
- Changing payment status
- Skipping required workflow steps
- Replaying actions

Additional business-logic checks:
- Subscription proration on upgrade/downgrade mid-cycle.
- Failed recurring-payment dunning: grace period, retries, and exact access-cutoff behavior.
- Downgrade data handling: preserve, hide, or destroy feature data intentionally.
- Reviews/ratings: enforce verified-purchase rules when required and sanitize review content.

Never trust client-supplied:

- Price
- Discount
- Role
- Permission
- Status
- Ownership
- Tenant ID
- Balance
- Subscription tier

---

# 21. Race Conditions & Concurrency

Test operations that can happen simultaneously:

- Stock decrement
- Payments
- Refunds
- Wallet/balance changes
- Coupon usage
- Seat allocation
- Enrollment
- Approval
- File processing
- Job creation

Look for:

- Lost updates
- Double spending
- Double booking
- Duplicate orders
- Duplicate payments
- Duplicate jobs
- Inconsistent state

Use transactions, locking, idempotency, or other mechanisms only where justified.

---

# 22. Idempotency

For operations where retries can cause damage, test:

- Payment creation
- Order creation
- Refunds
- Webhooks
- Emails
- Notifications
- Background jobs

Verify safe retry behavior.

A timeout must not automatically mean the operation did not happen.

---

# 23. API Testing

Test:

- Every endpoint
- HTTP method
- Authentication
- Authorization
- Input validation
- Output schema
- Error schema
- Status codes
- Pagination
- Filtering
- Sorting
- Search
- Rate limiting
- Caching behavior
- Idempotency
- Timeouts
- Retries
- Versioning

Input tests:

- Missing fields
- Null
- Empty strings
- Wrong types
- Very long strings
- Huge numbers
- Negative numbers
- Boundary values
- Duplicate values
- Unexpected fields
- Malformed JSON
- Unsupported methods

Never accept arbitrary mass-assignment fields without explicit control.

---

# 24. API Performance

Measure:

- Response time
- TTFB
- Throughput
- Requests/sec
- Concurrent requests
- Error rate
- P50
- P90
- P95
- P99
- CPU
- Memory
- Database time
- External API time
- Queue time

Do not optimize based only on average latency.

---

# 25. Database Testing

Check:

- Schema
- Relationships
- Foreign keys
- Unique constraints
- Nullability
- Indexes
- Query plans
- Slow queries
- JOINs
- N+1 queries
- Pagination
- Transactions
- Deadlocks
- Connection pool
- Lock contention
- Data integrity
- Large datasets
- Backup
- Restore

---

# 26. Database JOIN & Query Performance

Specifically inspect:

- JOIN correctness
- JOIN cardinality
- Missing indexes
- Unnecessary JOINs
- SELECT *
- Large result sets
- Expensive aggregations
- Sorting without indexes
- Filtering without indexes
- Repeated queries
- ORM-generated queries

Avoid premature indexing. Add indexes based on real query patterns and constraints.

---

# 27. N+1 Query Detection

Look for:

- Loop → query
- Component → repeated API calls
- ORM lazy-loading explosions
- Nested resource fetching

Prefer appropriate eager loading, batching, caching, or query redesign where justified.

---

# 28. Pagination & Data Growth

Every potentially unbounded collection should be assessed.

Check:

- Pagination
- Cursor pagination where appropriate
- Maximum page size
- Default page size
- Sorting
- Filtering
- Search
- Large datasets
- Export limits

Never allow an endpoint to accidentally return millions of records.

---

# 29. Overflow / Unbounded Growth

"Overflow" means more than visual overflow.

Check:

## UI overflow

- Long text
- Huge numbers
- Wide tables
- Large images
- Small screens
- RTL
- 4K screens

## Data overflow

- Huge database tables
- Unlimited logs
- Unlimited notifications
- Unlimited history
- Unlimited uploads
- Unlimited API responses

## Resource overflow

- Memory
- CPU
- Queue length
- Connections
- Disk
- Cache
- Browser storage

Every unbounded resource should have an intentional strategy.

---

# 30. Performance Testing

Use the appropriate test:

### Load Testing

Expected normal traffic.

### Stress Testing

Find breaking points.

### Spike Testing

Sudden traffic increase.

### Soak Testing

Long-duration stability.

### Volume Testing

Large data volume.

### Scalability Testing

Behavior as resources/users/data increase.

Never invent unrealistic performance requirements. Derive targets from product requirements and expected usage.

---

# 31. Frontend / UI Performance

Check:

- Initial load
- FCP
- LCP
- INP
- TTFB
- JavaScript bundle
- CSS
- Images
- Fonts
- Lazy loading
- Code splitting
- Rendering
- Re-renders
- Memory usage
- API waterfalls
- Caching
- Large lists
- Virtualization where genuinely needed

Do not optimize tiny theoretical issues while leaving obvious bottlenecks unresolved.

---

# 32. Mobile Performance

For native/hybrid mobile:

- Cold start
- Warm start
- Screen transition
- Memory usage
- CPU
- Battery
- Network usage
- Offline behavior
- Image loading
- Large lists
- Background work
- App size
- Crash rate
- ANR/UI freezes
- Slow devices
- Low-memory devices

Test both strong and poor network conditions.

---

# 33. UX / Usability

Test:

- Navigation
- Information hierarchy
- Clear labels
- Forms
- Error messages
- Loading states
- Empty states
- Success states
- Confirmation
- Undo where appropriate
- Destructive actions
- Search
- Filtering
- Feedback
- Consistency
- Mobile usability

A technical error should not be the only explanation shown to users.

---

# 34. User Flow / E2E Testing

Identify critical journeys.

Example e-commerce:

Register → Login → Browse → Product → Cart → Checkout → Payment → Order → Confirmation

Example education:

Register → Enroll → Course → Lesson → Exam → Result → Certificate

Example ERP:

Login → Dashboard → Employee → Transaction → Approval → Report

Test:

- Happy path
- Invalid path
- Interrupted path
- Retry
- Back navigation
- Refresh
- Session expiration
- Network failure
- Partial failure
- Permission changes

---

# 35. Responsive Testing

Test approximately from small mobile widths around 300px through large desktop/4K displays.

Check:

- Layout
- Navigation
- Sidebar
- Tables
- Forms
- Modals
- Cards
- Charts
- Images
- Typography
- Buttons
- Touch targets
- Horizontal scrolling
- Text wrapping
- Long values
- RTL/LTR

Do not treat "looks fine in Chrome desktop" as responsive testing.

---

# 36. Accessibility

Assess:

- Keyboard navigation
- Focus visibility
- Focus order
- Screen reader semantics
- Labels
- Form errors
- Alt text
- Semantic HTML
- ARIA where needed
- Color contrast
- Motion
- Touch targets
- Dialog accessibility

Use the project's required accessibility standard when one exists.

---

# 37. Cross-Browser & Device Compatibility

Web:

- Chrome
- Firefox
- Safari
- Edge
- Mobile browsers

Mobile:

- iOS versions/devices relevant to support policy
- Android versions/devices relevant to support policy
- Different screen sizes
- Different performance tiers

Do not test every device ever made. Test the supported matrix.

---

# 38. Internationalization & Localization

If applicable:

- Arabic
- English
- RTL
- LTR
- Long translations
- Mixed-language content
- Dates
- Times
- Time zones
- Currency
- Number formatting
- Plurals
- Unicode
- Emoji

Check layout after translation expansion.

---

# 39. Date / Time Testing

Check:

- Time zones
- DST where applicable
- Month boundaries
- Year boundaries
- Leap years
- Expiration
- Subscription renewal
- Scheduled jobs
- Server/client timezone mismatch
- Date formatting

Store and compare timestamps consistently.

---

# 40. E-commerce Testing

If applicable:

## Products

- Search
- Filters
- Sorting
- Categories
- Variants
- Stock
- Pricing

## Cart

- Add
- Remove
- Quantity
- Stock changes
- Price changes
- Persistence

## Checkout

- Address
- Shipping
- Tax
- Coupon
- Payment
- Failure
- Retry

## Payments

- Success
- Failure
- Cancellation
- Timeout
- Duplicate callback
- Webhook verification
- Refund
- Partial refund

## Orders

- Pending
- Paid
- Processing
- Shipped
- Delivered
- Cancelled
- Returned
- Refunded

---

# 41. Education / LMS Testing

If applicable:

- Students
- Teachers
- Admins
- Parents
- Enrollment
- Course access
- Lessons
- Videos
- PDFs
- Exams
- Questions
- Answers
- Grades
- Certificates
- Attendance
- Assignments
- Progress
- Course expiration
- Paid content
- Teacher permissions
- Student isolation

Verify one student cannot access another student's private data.

---

# 42. ERP Testing

If applicable:

- Employees
- Departments
- Roles
- Permissions
- Attendance
- Payroll
- Inventory
- Purchasing
- Sales
- Accounting
- Reports
- Approvals
- Audit logs

Pay special attention to authorization and financial calculations.

---

# 43. Notifications & Messaging

Test:

- Email
- SMS
- Push
- In-app notifications
- Templates
- Preferences
- Unsubscribe
- Duplicate messages
- Retry
- Failure
- Queue behavior
- Rate limits

Do not allow notification failures to corrupt the primary business transaction unless explicitly designed that way.

---

# 44. Background Jobs / Queues

Check:

- Retry
- Backoff
- Timeout
- Dead-letter behavior
- Duplicate execution
- Idempotency
- Queue growth
- Worker failure
- Job ordering where required
- Tenant isolation
- Observability

---

# 45. External Integrations

For every external API:

- Timeout
- Failure
- Retry
- Rate limit
- Authentication failure
- Invalid response
- Slow response
- Schema changes
- Duplicate webhook
- Out-of-order webhook
- Webhook signature
- Idempotency

Never assume third-party services always respond correctly.

---

# 46. Caching

Check:

- Correct cache keys
- Tenant isolation
- User isolation
- Permission-sensitive caching
- TTL
- Invalidation
- Stale data
- Cache stampede
- Memory growth

Never cache private data in a way that can cross users or tenants.

---

# 47. Reliability & Fault Tolerance

Test failures of:

- Database
- Cache
- Queue
- External APIs
- Email
- Storage
- Network
- Authentication provider

Check:

- Timeouts
- Retries
- Graceful degradation
- Error handling
- Recovery
- Data consistency

Retries must not create duplicate side effects.

---

# 48. Backup & Disaster Recovery

For important systems:

- Backup frequency
- Backup integrity
- Restore testing
- Recovery procedures
- RPO
- RTO
- Database backup
- File backup
- Configuration backup
- Disaster recovery documentation

A backup that has never been restored/tested should not be treated as proven recovery capability.

---

# 49. Logging, Monitoring & Observability

Check:

- Application logs
- Error logs
- Authentication logs
- Authorization failures
- Audit logs
- Payment events
- Critical business events
- Queue failures
- Database failures

Monitor:

- CPU
- Memory
- Disk
- Database
- API latency
- Error rate
- Queue depth
- Cache
- Traffic
- Crashes

Do not log passwords, tokens, secrets, or unnecessary sensitive information.

---

# 50. Audit Logging

For systems requiring accountability, record important actions:

- Login/security events
- Permission changes
- Role changes
- Financial actions
- Data exports
- Deletions
- Approvals
- Critical configuration changes

Audit logs should be:

- Accurate
- Timestamped
- Attributable
- Tamper-resistant according to requirements
- Appropriately retained

---

# 51. Code Quality

Review:

- Readability
- Naming
- Duplication
- Function size
- Component size
- Class responsibilities
- Coupling
- Cohesion
- Error handling
- Type safety
- Dead code
- Unused dependencies
- Deprecated APIs

Do not refactor code solely for aesthetic reasons when risk is low.

---

# 52. Maintainability

Assess:

- Ease of changing features
- Ease of debugging
- Testability
- Modularity
- Documentation
- Dependency management
- Configuration
- Consistency
- Clear boundaries

A maintainable solution is not necessarily the most abstract solution.

---

# 53. Architecture Complexity

Review:

- Number of services
- Number of layers
- Dependencies
- Coupling
- Data flow
- API boundaries
- Event flow
- State management
- Caching
- Queues
- Deployment complexity

Ask:

"Does this complexity solve a real problem?"

If not, simplify.

---

# 54. Technical Debt

Look for:

- TODO/FIXME
- Duplicated code
- Temporary workarounds
- Deprecated dependencies
- Dead code
- Large functions
- God classes
- God components
- Fragile integrations
- Missing tests
- Repeated bug patterns

Prioritize debt that creates:

- Security risk
- Reliability risk
- Performance risk
- High change cost

Do not eliminate all technical debt blindly.

---

# 55. Over-Engineering Prevention

Before introducing:

- New service
- New abstraction
- New design pattern
- New dependency
- New database
- New queue
- New cache
- Microservices
- Complex state management
- Generic framework
- Excessive configuration

Ask:

1. What concrete problem does it solve?
2. Is the problem happening now?
3. Is there a simpler solution?
4. What operational cost does it introduce?
5. Will the team understand and maintain it?

Prefer the simplest safe architecture.

---

# 56. Over-View Prevention

Avoid excessive:

- Pages
- Dashboards
- Metrics
- UI states
- Admin controls
- Configuration options
- Documentation that nobody uses
- Abstractions
- Alerts

Only expose information/actions that help a real user or operator make a decision.

---

# 57. Overflow Prevention

Prevent:

- Unbounded arrays
- Unlimited pagination
- Unlimited uploads
- Unlimited logs
- Unlimited notifications
- Unlimited history
- Huge API responses
- Huge database queries
- Memory leaks
- Queue explosions
- Cache growth
- File-storage growth
- UI text overflow

Every growth path should have a deliberate boundary, retention policy, pagination, aggregation, or cleanup mechanism where appropriate.

---

# 58. Error Handling

Test:

- Validation errors
- Authentication errors
- Authorization errors
- Not found
- Conflict
- Rate limit
- Server errors
- Network errors
- Timeout
- Third-party errors
- Database errors

Errors should:

- Be consistent
- Be actionable
- Avoid sensitive information
- Preserve correct HTTP semantics where applicable
- Be logged appropriately

---

# 59. Data Integrity

Verify:

- Referential integrity
- Unique constraints
- Transaction boundaries
- Atomic operations
- Decimal/money precision
- Rounding
- State transitions
- Duplicate prevention
- Soft-delete behavior
- Restore behavior

Never use floating-point arithmetic blindly for financial values.

---

# 60. Search / Filter / Sort

Test:

- Exact match
- Partial match
- Case handling
- Unicode
- Arabic
- Special characters
- Empty search
- Huge search
- Pagination
- Sorting
- Multiple filters
- Permission filtering
- Tenant filtering
- Performance

Search must not leak unauthorized records.

---

# 61. Import / Export

Test:

- CSV
- Excel
- JSON
- PDF
- Other supported formats

Check:

- Validation
- Large files
- Malformed files
- Duplicate data
- Unauthorized export
- Sensitive data exposure
- Injection risks in exported spreadsheets
- CSV/Excel formula injection: neutralize values beginning with `=`, `+`, `-`, or `@`.
- Import rollback
- Partial failure

---

# 62. Mobile-Specific Security

For mobile apps assess:

- Secure credential storage
- Token storage
- TLS
- Certificate validation according to platform requirements
- Deep links
- Universal/App links
- WebViews
- Clipboard exposure
- Screenshots where sensitive screens require protection
- Local databases
- Cached sensitive data
- Debug builds
- Secrets in app bundle
- Root/jailbreak considerations when relevant

Do not rely on obfuscation as a security boundary.

---

# 63. Mobile Offline / Network Testing

Test:

- Offline start
- Offline navigation
- Request failure
- Slow network
- Network switching
- Retry
- Duplicate requests
- Resume after background
- App termination during request
- Sync conflicts

Offline state must not silently corrupt data.

---

# 64. Regression Testing

After every meaningful fix/change:

1. Reproduce the original problem.
2. Confirm the fix.
3. Run related tests.
4. Run critical-path regression.
5. Run broader regression when risk warrants it.

Pay special attention to:

- Auth
- Permissions
- Payments
- Database
- APIs
- Core business flows

---

# 65. Test Automation Strategy

Use the appropriate layer:

## Unit

Business logic and isolated components.

## Integration

Database, services, APIs, integrations.

## API

Endpoint contracts and security.

## E2E

Critical user journeys.

## Security

Automated scanners plus targeted manual testing.

## Performance

Repeatable controlled benchmarks.

Do not force every test into E2E.

---

# 66. Test Data Strategy

Use:

- Realistic data
- Boundary data
- Invalid data
- Large datasets
- Multiple users
- Multiple roles
- Multiple tenants
- Expired records
- Deleted records
- Archived records

Do not use real production secrets or sensitive customer data in test environments.

---

# 67. Performance Baseline

Before optimizing:

1. Measure.
2. Identify bottleneck.
3. Set a reasonable target.
4. Change one meaningful thing.
5. Measure again.
6. Keep the change only if it materially improves the result without unacceptable tradeoffs.

Do not optimize based on guesses.

---

# 68. Security Severity

Classify findings:

### Critical
Immediate severe compromise, broad data exposure, account takeover, or major business impact.

### High
Serious exploitable security or reliability issue.

### Medium
Meaningful issue requiring realistic conditions or limited impact.

### Low
Minor weakness with limited practical impact.

### Informational
Observation or hardening recommendation without a demonstrated vulnerability.

Always include:

- Finding
- Evidence
- Impact
- Affected component
- Reproduction method
- Recommended fix
- Verification status

---

# 69. Bug Severity

Use:

- Blocker
- Critical
- Major
- Minor
- Trivial

Consider:

- User impact
- Business impact
- Frequency
- Reproducibility
- Security
- Data integrity
- Availability

---

# 70. Final Quality Gate

Before declaring a project ready, verify:

## Functional

- Critical features work
- Critical flows work
- Validation works
- Errors work

## Security

- Authentication
- Authorization
- IDOR/BOLA
- Injection
- XSS
- CSRF where applicable
- CORS
- SSRF where applicable
- File upload
- Secrets
- Rate limiting
- Sensitive data
- Tenant isolation

## Performance

- API latency
- Database
- UI
- Mobile
- Load
- Large data
- Resource usage

## UX

- Responsive
- Accessibility
- Loading
- Empty
- Error
- Success states

## Reliability

- Retries
- Timeouts
- Recovery
- Backups
- Restore
- Monitoring
- Logging

## Architecture

- Maintainability
- Complexity
- Technical debt
- Dependency health
- No unnecessary over-engineering

## Release

- Production configuration
- Secrets
- HTTPS
- Database migrations
- Backups
- Rollback
- Monitoring
- Error tracking

---

# 71. Mandatory Project Workflow

For every project, follow this sequence unless the project clearly requires a different order:

### Phase 1 — Discover

Inspect project structure, requirements, architecture, dependencies, data model, auth, roles, integrations, and critical flows.

### Phase 2 — Map

Create:

- Feature map
- Role/permission matrix
- API map
- Data/resource map
- Critical-flow map
- Security-boundary map
- Performance-risk map

### Phase 3 — Test

Run applicable:

- Functional tests
- Security tests
- Authorization tests
- API tests
- Database tests
- Performance tests
- UI/UX tests
- Compatibility tests
- Reliability tests
- Edge-case tests

### Phase 4 — Diagnose

For every finding determine:

- Root cause
- Scope
- Severity
- Reproduction
- Business impact
- Security impact
- Regression risk

### Phase 5 — Fix

Fix the smallest correct root cause.

Avoid unrelated refactors.

### Phase 6 — Verify

Re-run:

- Original reproduction
- Targeted tests
- Related regression
- Critical-path regression

### Phase 7 — Final Audit

Repeat the highest-risk checks and confirm no new vulnerabilities/regressions were introduced.

### Phase 8 — Report

Provide a concise report containing:

- Passed
- Failed
- Fixed
- Remaining
- Risk level
- Recommended next actions

---

# 72. Definition of Done

A feature/project is not "done" merely because it works in the happy path.

A feature is ready when:

- Functional behavior is correct.
- Invalid input is handled.
- Authorization is enforced server-side.
- Security boundaries are respected.
- Business logic cannot be trivially bypassed.
- Data integrity is preserved.
- Reasonable performance is demonstrated.
- UI is responsive where applicable.
- UX states are complete.
- Accessibility is acceptable for the required target.
- Errors are safe and useful.
- Critical failures recover safely.
- Tests exist at appropriate levels.
- Regression risk is addressed.
- No unnecessary architecture was introduced.
- No unbounded growth path was introduced.
- Documentation/configuration is sufficient for maintenance.
- Production risks are understood.

---

# 73. Critical Principle

Do NOT interpret this skill as:

"Run every possible test on every project."

Interpret it as:

"Evaluate every relevant risk category, then test deeply where the project's architecture, features, data, users, and threat model make it necessary."

A simple static website should not receive the same complexity as a multi-tenant ERP with payments and sensitive data.

A financial SaaS should receive substantially deeper authorization, concurrency, audit, data-integrity, and recovery testing.

A mobile app should receive deeper device, storage, offline, lifecycle, and network testing.

An e-commerce application should receive deeper payment, inventory, order-state, webhook, coupon, and concurrency testing.

Always be comprehensive about risk, but economical about implementation.

---

# 74. Golden Rules

1. Security is server-side.
2. Authentication is not authorization.
3. Hidden UI is not permission control.
4. Client input is untrusted.
5. IDs are untrusted.
6. Prices are untrusted.
7. Roles are untrusted when supplied by clients.
8. Tenant IDs are untrusted.
9. Status values are untrusted.
10. Frontend validation is not security.
11. Average latency is not the whole performance story.
12. A backup is not proven until restoration is tested.
13. A retry is not safe unless side effects are controlled.
14. A cache must respect data boundaries.
15. Pagination must protect against unbounded data.
16. Complexity must have a reason.
17. Abstraction must solve a real problem.
18. More features do not automatically mean better software.
19. More tests do not automatically mean better quality.
20. Fix root causes.
21. Measure before optimizing.
22. Automate repeatable checks.
23. Manually investigate high-risk logic.
24. Never confuse "not observed" with "secure."
25. Never claim a test passed if it was not actually performed.

---

# 75. Output Format for Project Audits

When reporting results, use:

## Executive Summary

- Overall status
- Critical findings
- Major risks
- Release recommendation

## Findings

For each issue:

- ID
- Category
- Severity
- Location
- Description
- Evidence
- Impact
- Reproduction
- Root cause
- Fix
- Verification

## Coverage

- Functional
- Security
- Authorization
- API
- Database
- Performance
- UI/UX
- Reliability
- Architecture
- Compatibility

## Remaining Risks

Explicitly list anything not tested because:

- Not applicable
- No test environment
- Missing credentials
- Missing infrastructure
- Requires external service
- Requires explicit authorization
- Tool limitation
- Time/risk constraints

Never silently skip an important category.

---

# 76. Final Rule

Be aggressively thorough about **real risk** and aggressively conservative about **unnecessary complexity**.

The best implementation is not the one with the most code, tests, services, abstractions, dashboards, or tools.

The best implementation is the simplest system that:

- Correctly fulfills the requirements.
- Protects users and data.
- Enforces authorization.
- Handles failures.
- Performs adequately.
- Scales to justified needs.
- Remains maintainable.
- Can be tested and operated confidently.

Always optimize for **correctness, security, reliability, performance, maintainability, and simplicity**—in that order according to project risk.

---

# Appendix A1 — OAuth / SSO / Federated Authentication

Apply when the project supports Google, Microsoft, Apple, Facebook, enterprise SSO, OIDC, or another external identity provider.

Check:

- `redirect_uri` uses an exact allowlist; no user-controlled redirect target or unsafe wildcard.
- OAuth `state` is present, unique, single-use, and bound to the local session.
- PKCE is used for public clients such as SPAs and mobile apps.
- Authorization codes are short-lived and single-use.
- OIDC ID tokens are verified for signature, issuer, audience, and nonce where applicable; never merely decoded and trusted.
- Account linking cannot silently merge an external identity into an existing password account solely because the email strings match.
- Provider-side consent revocation is handled safely.
- Users do not become permanently locked out when unlinking their only login method without a recovery path.

---

# Appendix A2 — Data Privacy & Regulatory Compliance

Apply according to the actual users, markets, data, and contractual obligations. This is a technical checklist, not legal advice.

Check:

- Applicable privacy requirements are identified for the users/markets served.
- Non-essential consent is captured before non-essential collection where required.
- Account deletion removes or properly anonymizes data across primary storage and relevant secondary systems according to the documented policy.
- User data export works in a usable format where required.
- Retention and deletion schedules exist for relevant data classes.
- Products serving minors receive additional privacy and access-control scrutiny.
- Privacy-policy statements are checked against actual application behavior and third-party sharing.

---

# Appendix A3 — Payment Compliance & Scope

Check:

- Minimize PCI scope through processor-hosted fields/SDKs or tokenization where appropriate.
- Raw card data does not appear in logs, error tracking, screenshots, or databases.
- Every payment webhook is authenticated/signature-verified.
- Webhooks are idempotent and replay-safe.
- Refunds, voids, chargebacks, and payment reversals reconcile correctly.
- Manual payment proof is not treated as authoritative until independently verified.

---

# Appendix A4 — Dependency & Supply Chain Security

Check routinely:

- Dependency vulnerability scanning.
- Lock files committed and respected in CI.
- New dependencies reviewed for maintenance activity, known vulnerabilities, and license compatibility.
- Untrusted install/build scripts are not executed blindly in privileged CI contexts.
- Dependency confusion and malicious package risks are considered.
- Bundled third-party fonts, icons, images, templates, and libraries have appropriate licenses, especially when the same codebase is resold to multiple clients.

---

# Appendix A5 — Infrastructure, Cloud & CI/CD Pipeline Security

Apply when deployment/infrastructure is under project control.

Check:

- Object storage is not publicly listable/readable unless intentionally public.
- Runtime cloud credentials follow least privilege.
- CI/CD secrets use the provider secret store and never appear in source or logs.
- Production deployment has an appropriate review/approval boundary.
- Database/admin services are not unnecessarily exposed to the public internet.
- Only required ports/services are public.
- TLS certificate renewal is automated or monitored.

---

# Appendix A6 — AI / LLM Feature Security

Apply only when the product embeds AI.

Check:

- Prompt injection cannot override system controls or cross tenant/user boundaries.
- User/file/web content is treated as untrusted model input.
- AI output is treated as untrusted output and sanitized before HTML/UI rendering.
- AI output is never passed directly to code execution, shell execution, SQL, or equivalent dangerous sinks.
- Per-user/tenant request and token limits prevent uncontrolled cost abuse.
- RAG retrieval respects the same authorization boundary as source documents.
- AI-assisted grading/recommendations cannot leak another student's/user's private context.
- Provider retention/training/data-use terms are reviewed before sending sensitive customer data.

---

# Appendix A7 — Compliance Framework Alignment

Apply only when required by the client, market, contract, or sales process.

Assess whether requirements such as SOC 2, ISO 27001, or another framework materially affect:

- Audit logging
- Access control
- Encryption
- Change management
- Evidence retention
- Incident response
- Vendor management

Do not build expensive compliance infrastructure without an actual requirement or justified risk.

---

# Appendix A8 — Paid Digital Content Protection

Apply to paid video, live streams, premium downloads, and digital courses.

Check:

- Media URLs are not permanently public when access is supposed to be restricted.
- Signed/expiring access URLs or equivalent controls are used where appropriate.
- Authorization is enforced for every protected media/file request, not only the initial page.
- Revoked subscriptions/purchases lose access according to the intended policy.
- Downloadable PDFs/slides/assets use the same authorization boundary as the course.
- Live stream access is protected and stream identifiers are not guessable/shareable.
- Anti-recording controls are treated as deterrents, not guarantees; do not claim a web/OS control can completely prevent screen recording.

---

# Appendix A9 — SEO Security Handoff

When the project also uses an SEO skill such as SEOGuard, security and SEO must be reviewed together. Check for:

- SEO spam injection.
- Hacked pages or injected links.
- Malicious redirects.
- Canonical/sitemap injection.
- Public exposure of private pages through indexable routes.
- User-generated content becoming an SEO abuse surface.
- Open redirects affecting search/social URLs.
- Staging or development environments becoming indexable.

Do not use SEO mechanisms such as `robots.txt` or canonical tags as security controls.

---

# Appendix A10 — Additional Golden Rules

26. A third-party login provider is part of the authentication surface.
27. Compliance obligations follow the users/markets and actual processing, not merely server location.
28. A dependency you did not write is still code you are responsible for.
29. AI-generated output is untrusted until safely handled.
30. A webhook without signature verification must never be trusted for security-sensitive state changes.
31. A payment screenshot is a claim, not confirmation.
32. Private data must never become public merely because a route is technically reachable.
33. Security and SEO must not be allowed to contradict each other.

# Final Integration Rule

When SEOGuard is present, run the SEO audit alongside ProjectGuard for every public-facing application. Resolve conflicts by preserving security, privacy, authorization, and correct application behavior first; never expose protected data merely to improve indexing.
