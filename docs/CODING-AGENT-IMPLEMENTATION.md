# Coding Agent Technical Implementation Plan

## Purpose
This document converts the product and architecture documentation into an execution plan suitable for autonomous or semi-autonomous coding agents such as Claude Code.

## Primary Objective
Implement RebuiltTrustVehicle as a secure, auditable, role-aware marketplace and transaction system for rebuilt-status vehicles.

The first usable product is not a generic marketplace. It is the smallest complete workflow that connects approved dealer supply to structured Private Buyer demand.

## Milestone 0 — Repository Health
Agent tasks:
- verify `pnpm install` succeeds;
- verify each app has a dev/build/typecheck path;
- normalize shared TypeScript configuration if needed;
- add lint/test scripts if absent;
- document local startup order.

Acceptance criteria:
- root commands can install and run the monorepo;
- web/API/worker each start independently;
- no secrets are committed.

## Milestone 1 — Identity, Tenant Model and RLS
Agent tasks:
- integrate Clerk in `apps/web`;
- verify Clerk tokens server-side in `apps/api`;
- sync Clerk user identity into application users;
- implement organization memberships and app roles;
- create server helpers such as `requireUser`, `requireRole`, `requireOrganizationAccess`;
- create initial RLS policies for user-owned and organization-owned records;
- document service-role usage.

Acceptance criteria:
- signed-out users cannot perform protected writes;
- buyers cannot read another buyer's private demand profile;
- one dealer cannot modify another dealer's inventory;
- admin-only actions reject non-admin users;
- service-role key never appears in client bundle.

## Milestone 2 — Dealer Onboarding and Vehicle Supply
Agent tasks:
- dealer organization profile CRUD;
- seller profile and approval state;
- admin dealer-review endpoint/page;
- VIN-based vehicle creation;
- listing CRUD;
- evidence metadata and upload workflow;
- publish/unpublish workflow;
- audit events for material listing changes.

Acceptance criteria:
- only approved dealers can publish commercial listings;
- rebuilt status is required and visible;
- VIN normalization prevents accidental duplicate canonical vehicles;
- unpublished listings are not returned through public marketplace endpoints;
- evidence records retain provenance.

## Milestone 3 — Private Buyer Network
Agent tasks:
- Private Buyer profile CRUD;
- vehicle-buying profile CRUD;
- support desired make/model, years, price, geography, mileage, EV, drivetrain, warranty, financing, purchase timeframe and optional payment target;
- buyer dashboard;
- saved search/demand activation state;
- trade-in intent field where defined by schema.

Acceptance criteria:
- a buyer can maintain multiple demand profiles;
- profiles can be activated/deactivated without deletion;
- buyer data is isolated by authorization and RLS;
- demand profiles use typed validation shared with matching logic.

## Milestone 4 — Explainable Matching Engine
Agent tasks:
- create shared matching domain package;
- hard-filter active listings;
- calculate weighted preference score;
- return structured explanation;
- persist matches idempotently;
- create worker job for new/changed listing and new/changed buyer demand;
- create match status transitions;
- create dealer opportunity when required threshold is reached.

Recommended output contract:
```ts
type MatchResult = {
  buyerProfileId: string;
  listingId: string;
  score: number;
  matchedCriteria: string[];
  unmetPreferences: string[];
  recommendationReason: string;
  eligibleForNotification: boolean;
};
```

Acceptance criteria:
- failed hard filters never receive a score;
- identical buyer/listing input produces identical result;
- explanation identifies why the listing matched;
- rerunning the worker does not create duplicate active matches;
- tests cover boundary values such as maximum price and year range.

## Milestone 5 — Inquiry, CRM and Appointment Flow
Agent tasks:
- inquiry creation from listing or match;
- lead/opportunity state;
- qualification fields;
- conversation timeline abstraction;
- appointment booking record;
- human handoff status;
- basic dealer lead inbox.

Acceptance criteria:
- inquiry is associated with buyer, listing/vehicle and seller organization;
- dealer sees only its own opportunities;
- AI-originated actions are distinguishable from human actions;
- state transitions are explicit and audited.

## Milestone 6 — Financing Adapter
Agent tasks:
- create provider-neutral finance adapter interface;
- finance consent record;
- finance case status machine;
- vehicle/seller payload assembly;
- provider reference storage;
- webhook/status update endpoint;
- separate applicant-sensitive data from public marketplace data.

Suggested states:
`draft -> consented -> submitted -> pending -> more_info -> conditional_approval -> final_approval -> declined -> funded -> cancelled`

Acceptance criteria:
- conditional approval is never rendered as final approval;
- provider status and timestamp are preserved;
- webhooks are authenticated/verified according to provider capability;
- finance PII is not exposed in listing APIs.

## Milestone 7 — Lubrico Warranty Adapter
Agent tasks:
- create provider-neutral warranty adapter interface;
- VIN eligibility request;
- quote/plan representation;
- status history;
- contract reference storage after issuance;
- provider webhook or operator-update path if no API exists.

Suggested states:
`not_checked -> checking -> eligible -> ineligible -> quoted -> selected -> issued -> expired -> cancelled`

Acceptance criteria:
- `eligible` never means `issued`;
- buyer-facing UI clearly distinguishes the states;
- source/provider is attached to the status;
- no agent invents plan details that have not been returned or entered by an authorized operator.

## Milestone 8 — Buyer Concierge
Agent tasks:
- OpenRouter model adapter;
- system/tool contract for Buyer Concierge;
- retrieval of listing facts and public trust evidence;
- buyer-intent capture;
- inquiry creation tool;
- buyer-profile creation/update tool subject to consent;
- audit record containing model/provider, input context references, tools called and output classification.

Acceptance criteria:
- AI cannot create verified vehicle evidence;
- missing facts produce a transparent unknown/not-provided response;
- all consequential writes are performed through authorized tools, not direct DB access from prompts;
- conversation can escalate to human.

## Milestone 9 — AI Sales Agent and DM Agent
Agent tasks:
- shared CRM context service;
- follow-up queue;
- matched inventory recommendation tool;
- appointment tool;
- channel adapter interface for DMs;
- human takeover flag;
- stale-lead workflow.

Acceptance criteria:
- agents share the same authoritative CRM record;
- messages are associated with channel and participant identity;
- sensitive claims use verified provider status;
- human takeover stops autonomous follow-up when required.

## Milestone 10 — Transaction Record
Agent tasks:
- transaction creation from qualified opportunity;
- agreed price;
- selected finance/warranty references;
- milestones and completion status;
- immutable history of material state changes;
- outcome event for analytics.

Acceptance criteria:
- one completed transaction references a specific vehicle, buyer and seller;
- finance/warranty references are optional but attributable when present;
- completion produces an auditable domain event.

## Coding Standards for Agents
- TypeScript strict mode.
- Avoid `any` except at external/untyped boundaries; narrow immediately.
- Validate external input with a schema validator.
- Keep domain status values centralized as enums/unions.
- Keep provider adapters behind interfaces.
- Database access should be isolated in repository/query modules rather than scattered across route handlers.
- Route handlers orchestrate; domain services decide.
- UI components do not contain authorization or core matching logic.
- Never catch and discard errors silently.
- Errors returned to clients should be safe and stable; detailed traces belong in server logs.

## Pull Request Contract
A coding agent PR should state:
- user-visible behavior added/changed;
- database migrations;
- RLS or permission changes;
- endpoints added/changed;
- tests added;
- environment variables added;
- unresolved provider/compliance assumptions;
- screenshots for meaningful UI changes when available.

## Decision Escalation
Stop implementation and surface the decision rather than inventing an answer when any of these are undefined:
- legal requirements for private seller volume/licensing;
- warranty provider contractual eligibility rules;
- lender underwriting or finance disclosure requirements;
- what qualifies for a platform trust designation;
- handling of regulated/high-risk personal financial data beyond documented requirements;
- any action that would present the platform as ICBC/government/mechanical certification.

## Recommended First Coding-Agent Prompt
Use this after cloning the repository:

> Read `CLAUDE.md`, `docs/PRD.md`, `docs/IMPLEMENTATION-BLUEPRINT.md`, and the current Supabase migration. Implement Milestone 1 from `docs/CODING-AGENT-IMPLEMENTATION.md`: Clerk authentication, application user synchronization, role/organization authorization helpers, and baseline RLS policies. Preserve the modular-monolith architecture. Do not implement dealer inventory yet. Run typecheck/tests/build, document any missing environment variables, and return a concise summary of files changed, security assumptions, and remaining blockers.
