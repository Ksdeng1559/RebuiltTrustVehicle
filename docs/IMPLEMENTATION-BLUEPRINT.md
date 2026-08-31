# Implementation Blueprint

## Purpose

This document converts the RebuiltTrustVehicle product model into an implementation-ready application structure.

## Recommended Runtime Shape

### Frontend
- Vite + React + TypeScript
- Responsive marketplace and portal UI
- Role-aware navigation
- Deploy to Vercel or Railway

### Identity and Multi-Tenancy
- Clerk for authentication and user identity
- Organization membership for dealers and partners
- Application-level role/permission records in Supabase

### Transactional Backend
- Supabase/Postgres as the system of record
- Supabase Storage for vehicle evidence and controlled documents
- Row Level Security for tenant and participant isolation
- Server-side API/service layer for consequential writes and partner integrations

### Analytics and Enrichment
- DuckDB locally for analytical transforms where useful
- MotherDuck for shared/cloud analytical workloads where required
- Neither replaces the transactional Postgres system of record

### AI and Agent Layer
- OpenRouter as model-routing abstraction
- ICM context contracts for each agent workflow
- OKF-approved knowledge as reusable policy/SOP context
- Shared CRM/conversation records so agents do not operate from isolated memory

## Application Modules

### 1. Identity & Access
Owns users, organizations, memberships, roles, permissions, consent and session-related application state.

### 2. Dealer Network
Owns dealer profile, licensing/verification, staff, onboarding, approval status, policy acknowledgements and dealer performance metadata.

### 3. Private Buyer Network
Owns private buyer profile, vehicle-buying profiles, saved searches, demand preferences, purchase timeframe, financing preference, warranty preference, trade-in intent, alerts and match history.

### 4. Private Seller Network
Owns private seller verification, ownership evidence, listing limits, seller disclosures and seller-specific review controls.

### 5. Vehicle Registry
Owns canonical VIN-centered vehicle identity, title/rebuilt status, vehicle attributes and lifecycle state.

### 6. Vehicle Trust Record
Owns evidence, inspections, repair documentation, before/after photos, specialist assessments, disclosure provenance and evidence-completeness status.

### 7. Marketplace Listings
Owns listing publication, pricing, merchandising, search visibility, seller relationship and listing state.

### 8. Buyer Matching
Owns explainable buyer-to-inventory matching, match scores/status, notification eligibility, dealer opportunity creation and buyer feedback.

### 9. CRM & Conversations
Owns inquiries, leads, opportunities, conversations, channels, appointments, notes, tasks, human handoffs and disposition.

### 10. Financing
Owns financing consent, application handoff, broker/lender routing, status tracking, conditional/final approval and funding references.

### 11. Warranty
Owns Lubrico eligibility workflow, provider responses, quote/plan state, issued contract references and warranty status.

### 12. Specialist Network
Owns rebuild, inspection, Tesla/EV and technical partner profiles plus specialist assessments attached to vehicles.

### 13. Transactions
Owns reservation/purchase milestones, buyer/seller/vehicle relationship, agreed price, financing reference, warranty reference and completion state.

### 14. AI Engagement
Owns Buyer Concierge, AI Sales Agent and AI DM Response Agent orchestration, context assembly, guardrails, tool calls, audit events and human escalation.

### 15. Notifications
Owns email/SMS/DM/app alerts for matches, lead follow-up, appointments, application status and operational events.

### 16. Admin & Compliance
Owns review queues, audit trail, trust-state overrides, policy configuration, consent controls, disputes and compliance operations.

## Suggested Repository Structure

```text
/apps
  /web                 # Vite + React marketplace and portals
  /api                 # HTTP/API service or Railway service
/packages
  /domain              # domain types, enums and validation
  /db                  # schema, migrations, query helpers
  /auth                # Clerk + app RBAC integration
  /trust               # trust record and evidence logic
  /matching            # buyer-inventory matching engine
  /ai                   # agent contracts, prompts, tool adapters
  /integrations        # Lubrico, finance, messaging, CRM adapters
  /events               # domain events and notification contracts
  /ui                   # shared UI components
/docs
  ...
```

A monorepo is preferred because the marketplace, dealer portal, buyer network, API and shared domain logic will evolve together.

## Service Boundaries

The first implementation should be a modular monolith rather than premature microservices.

Recommended deployable units:
1. `web` — frontend application.
2. `api` — authenticated application API, partner adapters and webhook handling.
3. `worker` — asynchronous jobs for matching, notifications, document processing and agent follow-up when needed.

Modules should communicate through explicit domain services and events so individual capabilities can be separated later without redesigning the domain.

## Core Domain Events

- `dealer.approved`
- `buyer_profile.created`
- `buyer_demand.updated`
- `vehicle.created`
- `vehicle_evidence.added`
- `listing.published`
- `listing.changed`
- `match.created`
- `match.accepted`
- `inquiry.created`
- `opportunity.qualified`
- `appointment.booked`
- `warranty.eligibility_updated`
- `finance.status_updated`
- `transaction.completed`

## Matching Engine — MVP

The first matching engine should be deterministic and explainable rather than opaque ML.

### Hard filters
- make/model
- acceptable year range
- maximum price
- geography
- rebuilt accepted
- active listing

### Weighted preferences
- mileage
- trim/features
- EV preference
- AWD/drivetrain
- warranty availability
- financing availability
- desired monthly payment compatibility

### Output
Every match should return:
- match score;
- matched criteria;
- unmet preferences;
- reason for recommendation;
- notification status;
- buyer response;
- dealer opportunity state.

ML/ranking models can be introduced only after the platform has enough real buyer behavior and transaction outcomes to evaluate them.

## AI Agent Contracts

### Buyer Concierge
Reads public/authorized vehicle facts, buyer intent and approved platform knowledge. It can explain, compare, capture demand and create inquiries. It cannot invent repair facts, financing approval or warranty coverage.

### AI Sales Agent
Reads CRM state, buyer profile, inventory, matches, approved financing/warranty status and conversation history. It can qualify, recommend, follow up and schedule. Consequential claims remain tied to verified source data.

### AI DM Response Agent
Handles channel-specific inbound messages, resolves vehicle context, captures intent and routes qualified opportunities into the shared CRM.

## Security Principles

- Tenant isolation is mandatory.
- Finance applicant PII is separated from public marketplace data.
- Partner access is scoped to records necessary for the relevant case.
- Vehicle documents can have public, buyer-shared, partner-only and admin-only access levels.
- Material changes create immutable audit events.
- Sensitive writes and provider callbacks are server-side.
- AI access is constrained by role, purpose and ICM context contract.

## Build Principle

Ship the smallest complete transaction loop first:

**Dealer inventory → trust record → Private Buyer demand → match → inquiry/qualification → financing/warranty handoff → appointment → transaction status.**

Everything else should strengthen this loop rather than delay it.