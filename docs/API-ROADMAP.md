# API Roadmap

## Purpose

This document defines the first implementation surface for RebuiltTrustVehicle. The API should be resource-oriented, tenant-aware, auditable and designed around the smallest complete marketplace transaction loop.

## API Conventions

- Prefix: `/api/v1`
- JSON request/response bodies
- Clerk session/JWT authentication
- Server-side authorization against application roles and organization membership
- Idempotency keys for consequential create/update calls where appropriate
- Provider callbacks handled through signed webhooks
- Material writes generate audit events
- API responses distinguish verified facts, seller disclosures, third-party assessments and platform-derived statuses

## Identity and Profile Endpoints

### Current user
- `GET /me`
- `PATCH /me`

### Organizations
- `GET /organizations/:id`
- `GET /organizations/:id/members`
- `POST /organizations/:id/members`
- `PATCH /organizations/:id/members/:membershipId`

## Dealer Network

- `POST /dealers/applications`
- `GET /dealers/:dealerId`
- `PATCH /dealers/:dealerId`
- `POST /dealers/:dealerId/evidence`
- `POST /admin/dealers/:dealerId/approve`
- `POST /admin/dealers/:dealerId/reject`

## Private Buyer Network

### Buyer profile
- `GET /buyers/me`
- `POST /buyers`
- `PATCH /buyers/me`

### Vehicle Buying Profiles
- `GET /buyers/me/demands`
- `POST /buyers/me/demands`
- `GET /buyers/me/demands/:demandId`
- `PATCH /buyers/me/demands/:demandId`
- `POST /buyers/me/demands/:demandId/activate`
- `POST /buyers/me/demands/:demandId/pause`
- `POST /buyers/me/demands/:demandId/fulfill`

### Matches
- `GET /buyers/me/matches`
- `GET /buyers/me/matches/:matchId`
- `POST /buyers/me/matches/:matchId/interested`
- `POST /buyers/me/matches/:matchId/reject`
- `POST /buyers/me/matches/:matchId/feedback`

### Saved searches
- `GET /buyers/me/saved-searches`
- `POST /buyers/me/saved-searches`
- `PATCH /buyers/me/saved-searches/:id`
- `DELETE /buyers/me/saved-searches/:id`

## Private Seller Network

- `POST /private-sellers`
- `GET /private-sellers/me`
- `PATCH /private-sellers/me`
- `POST /private-sellers/me/ownership-evidence`

## Vehicle Registry and Trust Record

### Vehicles
- `POST /vehicles`
- `GET /vehicles/:vehicleId`
- `GET /vehicles/by-vin/:vin`
- `PATCH /vehicles/:vehicleId`

### Evidence
- `GET /vehicles/:vehicleId/evidence`
- `POST /vehicles/:vehicleId/evidence`
- `GET /vehicles/:vehicleId/trust-status`

### Disclosures and inspections
- `POST /vehicles/:vehicleId/disclosures`
- `POST /vehicles/:vehicleId/inspections`
- `POST /vehicles/:vehicleId/specialist-assessments`

## Listings

### Public marketplace
- `GET /listings`
- `GET /listings/:listingId`
- `GET /listings/:listingId/trust-record`

Search parameters should support make, model, year, price, mileage, region, EV/fuel type, warranty availability and financing availability.

### Seller listing management
- `POST /listings`
- `PATCH /listings/:listingId`
- `POST /listings/:listingId/publish`
- `POST /listings/:listingId/unpublish`
- `POST /listings/:listingId/media`

## Buyer Matching Engine

Internal/service endpoints:
- `POST /internal/matching/listing/:listingId/run`
- `POST /internal/matching/demand/:demandId/run`
- `GET /internal/matching/:matchId/explanation`

Admin/debug endpoints should expose the criteria that produced a match without revealing sensitive buyer information to unauthorized users.

## Inquiry and CRM

### Buyer actions
- `POST /listings/:listingId/inquiries`
- `GET /buyers/me/inquiries`

### Dealer CRM
- `GET /dealers/:dealerId/opportunities`
- `GET /opportunities/:opportunityId`
- `PATCH /opportunities/:opportunityId`
- `POST /opportunities/:opportunityId/qualify`
- `POST /opportunities/:opportunityId/handoff`

### Conversations
- `GET /conversations/:conversationId`
- `POST /conversations/:conversationId/messages`
- `POST /conversations/:conversationId/human-takeover`

### Appointments
- `POST /opportunities/:opportunityId/appointments`
- `PATCH /appointments/:appointmentId`

## Financing

Buyer-facing:
- `POST /listings/:listingId/finance-applications`
- `GET /finance-applications/:applicationId`

Partner/admin:
- `POST /finance-applications/:applicationId/submit`
- `GET /finance-applications/:applicationId/status`

Webhook:
- `POST /webhooks/finance/:provider`

The platform must not represent an application as approved until the finance partner reports that status.

## Warranty

- `POST /vehicles/:vehicleId/warranty/eligibility`
- `GET /warranty-cases/:caseId`
- `POST /warranty-cases/:caseId/quote`
- `POST /warranty-cases/:caseId/select-plan`

Webhook:
- `POST /webhooks/warranty/:provider`

For Lubrico, an adapter should isolate provider-specific payloads from the core domain model.

## AI Engagement

### Buyer Concierge
- `POST /ai/concierge/messages`

Context may include listing, vehicle trust record, public policy knowledge and authenticated buyer demand.

### AI Sales Agent
- `POST /ai/sales-agent/runs`
- `POST /ai/sales-agent/opportunities/:opportunityId/follow-up`

### AI DM Agent
- `POST /webhooks/messaging/:channel`

### Human approval / escalation
- `GET /admin/ai/handoffs`
- `POST /admin/ai/handoffs/:id/resolve`

Every material agent run should create an `agent_run` record plus an artifact containing findings, confidence, unresolved questions and next action.

## Transactions

- `POST /listings/:listingId/reservations`
- `POST /transactions`
- `GET /transactions/:transactionId`
- `PATCH /transactions/:transactionId/status`
- `POST /transactions/:transactionId/complete`

## Notifications

- `GET /me/notifications`
- `PATCH /me/notifications/:id/read`
- `PATCH /me/notification-preferences`

Internal:
- `POST /internal/notifications/send`

## Admin and Compliance

- `GET /admin/review-queue`
- `GET /admin/audit-events`
- `GET /admin/vehicles/:vehicleId/history`
- `POST /admin/listings/:listingId/hold`
- `POST /admin/listings/:listingId/release`
- `POST /admin/vehicle-evidence/:evidenceId/verify`
- `POST /admin/vehicle-evidence/:evidenceId/reject`

## Webhook Requirements

All partner webhooks should:
1. verify signature or shared authentication;
2. preserve raw provider event metadata;
3. enforce idempotency;
4. translate provider-specific states to internal enums;
5. append rather than silently overwrite important state history;
6. create audit events;
7. trigger domain events for downstream notifications or CRM updates.

## Implementation Sequence

### API Milestone 1 — Marketplace Foundation
- auth/me
- organizations/dealers
- vehicles
- evidence
- listings
- public search

### API Milestone 2 — Buyer Demand
- buyer profile
- Vehicle Buying Profiles
- matching engine
- match notifications
- inquiries

### API Milestone 3 — Dealer Conversion
- CRM opportunities
- conversations
- appointments
- AI Concierge and qualification handoff

### API Milestone 4 — Transaction Enablement
- warranty eligibility
- finance application handoff
- transaction/reservation state

### API Milestone 5 — Automation and Scale
- DM agent channels
- AI Sales Agent follow-up
- worker/event processing
- analytics feeds
- specialist partner APIs

## Definition of API MVP

The API MVP is complete when this flow can be executed end-to-end with auditable records:

**Approved dealer publishes a rebuilt vehicle → active private buyer demand is matched → buyer is notified → inquiry is created → dealer opportunity is qualified → warranty/financing can be requested → appointment is recorded → transaction can be marked completed.**