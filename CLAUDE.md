# CLAUDE.md — RebuiltTrustVehicle Coding Agent Guide

## Mission
Build RebuiltTrustVehicle as trusted commerce infrastructure for rebuilt-status vehicles in British Columbia.

The MVP must connect verified vehicle supply with structured private-buyer demand and move both sides through an auditable transaction workflow.

## Read First
Before coding, read these files in order:
1. `docs/PRD.md`
2. `docs/IMPLEMENTATION-BLUEPRINT.md`
3. `docs/DATABASE-SCHEMA.md`
4. `docs/API-ROADMAP.md`
5. `docs/BUILD-ROADMAP.md`
6. `docs/PRIVATE-BUYER-NETWORK.md`
7. `docs/TRUST-FRAMEWORK.md`
8. `docs/AI-AGENTS.md`

Treat these as authoritative unless a newer dated decision appears in `docs/DECISION-LOG.md`.

## Product North Star
Ship and preserve this end-to-end loop:

`Approved dealer inventory -> VIN trust record -> Private Buyer demand -> explainable match -> inquiry/opportunity -> financing/warranty handoff -> appointment -> transaction`

Do not add architecture that does not strengthen this loop.

## Runtime Architecture
Use a modular monolith with three runtime concerns:
- `apps/web` — Vite + React + TypeScript
- `apps/api` — authenticated HTTP API and partner/webhook layer
- `apps/worker` — asynchronous matching, notifications, document and agent jobs

System of record: Supabase/Postgres.
Identity: Clerk.
AI routing: OpenRouter abstraction.
Analytics: DuckDB/MotherDuck only for analytical workloads, never as the transactional source of truth.

## Repository Boundaries
Prefer this layout when adding functionality:

```text
/apps
  /web
  /api
  /worker
/packages
  /domain
  /db
  /auth
  /trust
  /matching
  /ai
  /integrations
  /events
  /ui
/supabase
  /migrations
/docs
```

Do not create a new service unless the current API/worker boundary is demonstrably insufficient.

## Core Domain Modules
Preserve these explicit domains:
- Identity & Access
- Dealer Network
- Private Buyer Network
- Private Seller Network
- Vehicle Registry
- Vehicle Trust Record
- Marketplace Listings
- Buyer Matching
- CRM & Conversations
- Financing
- Warranty
- Specialist Network
- Transactions
- AI Engagement
- Notifications
- Admin & Compliance

Cross-domain writes should happen through explicit services or domain events, not hidden table coupling.

## Data Rules
1. VIN is a normalized domain key, not the sole primary key.
2. Verified facts, seller assertions, third-party assessments, platform-derived status and AI interpretation must remain distinguishable.
3. Never overwrite material evidence silently. Supersede or append where possible.
4. Finance PII must remain separated from public marketplace records.
5. Every consequential provider decision must remain attributable to the provider.
6. Every material change should be audit-reconstructable.
7. New tables must include ownership/tenant fields required for Row Level Security.
8. Every migration must be additive and reversible where practical.
9. Never place secrets in migrations, source files or fixtures.

## RLS and Authorization
RLS is mandatory for application tables.

Do not use RLS as the only authorization layer. Consequential writes must also be checked server-side.

Minimum access model:
- Platform admins can review all operational records.
- Dealer users only access their organization-scoped data.
- Private buyers only access their own profiles, saved demand, matches and permitted transaction records.
- Private sellers only access their own seller/listing records.
- Finance/warranty/specialist partners only access cases explicitly assigned to them.
- Public users only access published listing fields and explicitly public trust evidence.

Never expose service-role credentials to the web client.

## Matching Engine Rules
The MVP matcher must be deterministic and explainable.

Hard filters first:
- listing is active
- rebuilt accepted
- make/model
- year range
- maximum price
- geography

Weighted preferences may include:
- mileage
- trim/features
- EV preference
- AWD/drivetrain
- warranty availability
- financing availability
- monthly-payment compatibility

Every generated match must store or return:
- score
- matched criteria
- unmet preferences
- recommendation reason
- notification state
- buyer response state
- dealer opportunity state

Do not introduce opaque ML ranking before real behavioral and transaction data exists.

## AI Agent Safety Contracts
### Buyer Concierge
May explain verified/public vehicle facts, compare vehicles, capture buyer intent and create inquiries.
Must not invent repair history, inspection results, financing approval or warranty coverage.

### AI Sales Agent
May use CRM, buyer profiles, inventory, matches and verified financing/warranty status to qualify and follow up.
Must not represent conditional finance as final approval or eligibility as issued warranty coverage.

### AI DM Response Agent
May resolve vehicle context, capture demand, answer approved FAQs and route opportunities into CRM.
Must escalate when material facts are missing or uncertain.

All material AI actions should emit an audit event and preserve the source context used.

## External Integrations
Use adapters for all external providers.

Required integration categories:
- Clerk
- Supabase
- OpenRouter
- Lubrico Warranty
- finance broker/lender handoff
- messaging/DM channels

Never embed provider-specific assumptions directly into domain logic. Domain services should depend on interfaces; adapters implement provider details.

## API Conventions
Use versioned routes under `/api/v1`.

Prefer resource-oriented endpoints.

Expected high-level resources:
- `/dealers`
- `/vehicles`
- `/listings`
- `/evidence`
- `/buyers`
- `/buyer-profiles`
- `/matches`
- `/inquiries`
- `/opportunities`
- `/appointments`
- `/finance-cases`
- `/warranty-cases`
- `/transactions`
- `/admin/review-queue`
- `/webhooks/*`

Validate all inputs at the boundary.
Use typed response contracts.
Return explicit state rather than ambiguous booleans where workflows have multiple statuses.

## Frontend Conventions
The web app must be mobile-first and role-aware.

Primary experiences:
- public marketplace
- vehicle trust record
- private buyer dashboard
- dealer portal
- private seller portal
- admin review queue

Do not hide rebuilt status behind marketing language.
Warranty and financing states must be explicit and source-backed.

## Implementation Order
Unless a task explicitly says otherwise, work in this sequence:

### Phase 1 — Platform Foundation
- Clerk auth
- application user sync
- organizations/memberships
- role checks
- Supabase client/server wiring
- base RLS policies
- shared domain types

### Phase 2 — Dealer and Vehicle Supply
- dealer onboarding/approval
- vehicle creation by VIN
- listing CRUD
- evidence upload metadata
- publish/unpublish workflow

### Phase 3 — Private Buyer Demand
- private buyer profile
- vehicle-buying profile CRUD
- saved demand
- buyer dashboard

### Phase 4 — Matching
- deterministic matcher
- persisted match explanations
- worker execution
- match notifications
- dealer opportunity creation

### Phase 5 — CRM Transaction Flow
- inquiry
- opportunity qualification
- appointment
- conversation log
- human handoff

### Phase 6 — Financing and Warranty
- finance case handoff/status
- Lubrico eligibility/quote/status adapter
- explicit provider status history

### Phase 7 — AI Layer
- Buyer Concierge
- AI Sales Agent
- AI DM Response Agent
- ICM context contracts
- audit logging and escalation

### Phase 8 — Transaction Completion
- reservation/purchase milestones
- financing/warranty references
- transaction completion
- analytics events

## Definition of Done
A task is not complete until:
- code compiles/type-checks;
- new API inputs are validated;
- authorization is enforced;
- database changes include migration(s);
- RLS implications are handled;
- meaningful error states exist;
- tests are added for core business logic;
- no secrets are committed;
- docs are updated if behavior or architecture changed;
- the change does not blur verified facts with claims or AI interpretation.

## Testing Priorities
Highest priority tests:
1. authorization and tenant isolation;
2. matching hard filters and explanation output;
3. rebuilt-status disclosure visibility;
4. warranty eligibility vs issued-coverage distinction;
5. financing conditional vs final status distinction;
6. evidence provenance and audit history;
7. buyer/dealer workflow transitions.

## Do Not Do
- Do not convert the project into microservices prematurely.
- Do not replace Supabase/Postgres with DuckDB/MotherDuck for transactional data.
- Do not allow AI to write verified vehicle facts without source-backed workflow.
- Do not expose service-role keys client-side.
- Do not bypass RLS with broad service-role queries unless the API action is explicitly authorized and audited.
- Do not infer warranty coverage.
- Do not infer financing approval.
- Do not present a platform trust score as mechanical certification.
- Do not merge Private Buyer and Private Seller into one generic role.
- Do not create hidden business logic in UI components.

## Working Style for Claude Code
For every task:
1. inspect relevant files first;
2. state the smallest implementation plan;
3. make focused changes;
4. run typecheck/tests/build where available;
5. report changed files, migrations, tests and unresolved risks;
6. stop and surface uncertainty when a product/compliance decision is missing rather than inventing one.

Prefer small coherent commits over broad rewrites.
Preserve existing naming and domain boundaries unless a change is explicitly justified in the PR.