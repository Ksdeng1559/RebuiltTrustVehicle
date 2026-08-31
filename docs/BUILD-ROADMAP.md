# Build Roadmap

## Objective

Turn the current PRD into a production-capable MVP without overbuilding. The build sequence is organized around one north-star transaction loop:

**Verified dealer inventory → VIN trust record → Private Buyer demand → match → qualified opportunity → financing/warranty handoff → appointment → transaction.**

## Phase 0 — Project Foundation

### Deliverables
- monorepo scaffold;
- Vite + React + TypeScript web app;
- API service scaffold;
- shared domain/types package;
- Supabase project and migration workflow;
- Clerk integration;
- environment configuration;
- lint/test/build CI;
- baseline observability and error logging.

### Exit criteria
- authenticated user can sign in;
- API can identify user and role;
- database migration can be applied cleanly;
- web and API deploy from GitHub.

## Phase 1 — Dealer and Vehicle Trust Foundation

### Deliverables
- dealer organization onboarding;
- dealer approval workflow;
- VIN-normalized vehicle records;
- rebuilt-status disclosure;
- vehicle evidence upload;
- document visibility controls;
- listing create/edit/publish flow;
- public marketplace search;
- trust-record page;
- admin review/audit events.

### Exit criteria
An approved dealer can publish a rebuilt vehicle with a visible, provenance-aware trust record.

## Phase 2 — Private Buyer Network

### Deliverables
- private buyer onboarding;
- Vehicle Buying Profile creation;
- multiple active demands per buyer;
- saved searches;
- buyer preferences for financing, warranty, EV, price, mileage and geography;
- buyer dashboard;
- alert preferences.

### Exit criteria
A private buyer can define exactly what vehicle they want before suitable inventory exists.

## Phase 3 — Buyer-to-Inventory Matching

### Deliverables
- deterministic matching engine;
- hard filters and weighted preferences;
- explainable match score;
- listing-triggered match jobs;
- demand-triggered match jobs;
- match inbox for buyers;
- interested/not interested feedback;
- dealer matched-opportunity creation;
- notification pipeline.

### Exit criteria
Publishing a qualifying listing automatically produces explainable matches for active buyer demand and can create dealer opportunities.

## Phase 4 — CRM and AI Conversion Layer

### Deliverables
- inquiry records;
- opportunities and stages;
- shared conversation threads;
- appointment booking;
- human takeover queue;
- Buyer Concierge grounded in listing/trust data;
- AI Sales Agent qualification workflow;
- AI DM Response Agent inbound adapter architecture;
- agent run/artifact audit trail.

### Exit criteria
A matched buyer can enter a conversation, be qualified, and reach an appointment with dealer visibility and human control.

## Phase 5 — Financing and Warranty

### Financing
- buyer consent;
- finance application handoff;
- broker/lender partner routing;
- application status model;
- conditional/final approval states;
- webhook adapter pattern.

### Warranty
- Lubrico adapter interface;
- VIN eligibility request;
- eligibility/quote status;
- plan display;
- issued contract reference;
- explicit distinction between eligibility and coverage.

### Exit criteria
A dealer opportunity can carry verified financing and warranty workflow status through the transaction journey.

## Phase 6 — Transaction Layer

### Deliverables
- reservation state;
- transaction record;
- agreed price;
- financing/warranty linkage;
- status milestones;
- completion event;
- post-transaction review/referral triggers.

### Exit criteria
The marketplace can record the full lifecycle from vehicle publication to completed transaction.

## Phase 7 — Private Seller Network

### Deliverables
- private seller verification;
- ownership evidence;
- listing volume controls;
- additional review gates;
- private-seller labeling;
- optional dealer-assisted transaction routing.

### Exit criteria
Limited private inventory can enter the marketplace without weakening dealer-first trust controls.

## Phase 8 — Specialist and EV Trust Network

### Deliverables
- specialist organizations;
- inspection provider workflow;
- repair/rebuild specialist assessments;
- Tesla/EV specialist assessments;
- battery/high-voltage evidence types;
- optional RebuiltTrust EV Verified evidence package.

### Exit criteria
Relevant specialist evidence can materially strengthen the trust record without being misrepresented as a platform guarantee.

## Phase 9 — Analytics and Marketplace Intelligence

### Deliverables
- buyer demand analytics;
- match-to-inquiry conversion;
- inquiry-to-appointment conversion;
- dealer response time;
- financing application rate;
- warranty attachment rate;
- days-to-sale;
- demand by make/model/year/price/geography;
- inventory gaps;
- dealer sourcing recommendations.

MotherDuck/DuckDB may be introduced here for analytical workloads while Supabase/Postgres remains the system of record.

## Priority Backlog

### P0 — Required for first live transaction
- authentication/RBAC
- dealer approval
- vehicle/VIN
- rebuilt disclosure
- evidence storage
- listing publication
- buyer profile
- Vehicle Buying Profile
- matching
- inquiry/opportunity
- financing handoff
- warranty eligibility handoff
- appointment
- audit log

### P1 — Strong conversion multipliers
- AI Concierge
- AI Sales Agent
- DM agent
- match alerts
- saved searches
- trade-in intent
- specialist evidence
- buyer/dealer dashboards

### P2 — Scale and monetization
- Buyer+ membership
- advanced sourcing concierge
- promoted dealer inventory
- deeper provider integrations
- marketplace intelligence
- advanced dealer analytics
- pricing intelligence

## Delivery Guardrails

- Do not build a general-purpose CRM before the rebuilt-vehicle sales loop works.
- Do not build opaque ML matching before deterministic matching generates enough outcome data.
- Do not represent warranty eligibility as issued coverage.
- Do not store more finance applicant data than is necessary.
- Do not permit AI-generated claims to overwrite source facts.
- Do not introduce microservices until operational scaling requires them.
- Do not allow private seller expansion to undermine dealer-first verification standards.

## Initial Product Team Workstreams

1. **Frontend** — marketplace, dealer portal, buyer dashboard, admin.
2. **Backend** — domain services, API, RLS, events, partner adapters.
3. **Trust/Compliance** — evidence types, disclosures, review workflows.
4. **Growth/CRM** — demand capture, matching, qualification, follow-up.
5. **Integrations** — Lubrico, finance partners, messaging channels.
6. **AI** — context contracts, concierge, sales agent, DM agent, QA.

## First Release Definition

The first commercially useful release is not defined by feature count. It is defined by proving this loop with real participants:

1. approved dealer publishes a rebuilt vehicle;
2. vehicle displays a credible trust record;
3. private buyer has a saved demand profile;
4. system matches buyer to vehicle;
5. buyer engages;
6. AI/human process qualifies the opportunity;
7. financing and warranty can be requested;
8. appointment is booked;
9. dealer can close and record the transaction.

That loop should drive implementation priority.