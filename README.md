# RebuiltTrustVehicle

A trust-first marketplace, buyer network, and transaction platform for rebuilt-status vehicles in British Columbia.

## Mission

Create a safer, more transparent and more liquid market for ICBC rebuilt vehicles by connecting verified supply with structured buyer demand, while integrating warranty, financing, standardized disclosure, specialist evidence, AI-assisted sales, and portable institutional knowledge.

## Core Model

RebuiltTrustVehicle is designed around seven trust and transaction layers:

1. **Authorized Dealer Network** — approved used-car dealers form the primary commercial seller and inventory network.
2. **Private Buyer Network** — consumers create structured vehicle-buying profiles so the platform can match demand to current and incoming rebuilt inventory.
3. **Private Seller Network** — individuals may introduce limited-volume inventory under tighter identity, ownership, disclosure, and transaction controls.
4. **Vehicle Trust Record** — VIN, rebuilt status, inspection evidence, repair history, disclosure, specialist evidence, warranty state, and listing evidence are tied to the vehicle record.
5. **Transaction Protection** — eligible warranty, financing, documentation, inspections, and risk controls are integrated into the buying journey.
6. **AI Engagement & Matching Layer** — a Buyer Concierge, in-house AI Sales Agent, AI DM Response Agent, and buyer-to-inventory matching engine qualify demand, recommend vehicles, follow up leads, and route consequential decisions to humans.
7. **ICM + OKF Knowledge Layer** — Interpretive Context Methodology assembles task-specific context for agents; the Open Knowledge Framework stores approved, linked, provenance-aware knowledge for reuse across the platform.

## Current Commercial Direction

- Primary market: British Columbia, Canada
- Vehicle type: ICBC rebuilt-status vehicles, including newer late-model vehicles, EVs and rebuilt Teslas
- Primary supply: authorized used-car dealers
- Secondary supply: private sellers under controlled limits
- Demand network: private buyers seeking rebuilt vehicles for personal use
- Buyer demand model: structured vehicle-buying profiles, saved demand, alerts, and AI matching
- Warranty direction: Lubrico Warranty, subject to VIN eligibility and contract confirmation
- Financing: integrated vehicle-financing workflow through participating brokers/lenders
- Specialist layer: rebuild, inspection, Tesla/EV and other technical partners where appropriate
- AI engagement: website concierge, internal sales agent, DM response agent, and inventory matching
- Context architecture: ICM-based selective context assembly and human-gated workflows
- Knowledge architecture: OKF-based portable knowledge, provenance, lifecycle, and reusable SOPs/playbooks
- Platform objective: increase buyer confidence, dealer conversion, response speed, transaction velocity, institutional learning, and liquidity for rebuilt vehicles

## Marketplace Structure

### Supply
Authorized Dealers + Private Sellers + Rebuild / Inspection / EV Specialists

### Platform
RebuiltTrustVehicle = Marketplace + Trust Record + Buyer Demand + Financing + Warranty + AI + Transaction Infrastructure

### Demand
Private Buyer Network

The strategic model is therefore not only **vehicle listing → wait for buyer**. It also supports **buyer joins → defines desired vehicle → AI matches current or incoming inventory → dealer receives qualified opportunity**.

## Implementation Direction

The first build uses a modular-monolith architecture with clear domain boundaries:

- **Web:** Vite + React + TypeScript
- **Identity:** Clerk + application-level roles/organization membership
- **System of Record:** Supabase/Postgres
- **Documents:** Supabase Storage or compatible object storage
- **API:** authenticated `/api/v1` service with provider adapters and webhooks
- **Worker:** matching, notifications and asynchronous agent workflows where required
- **AI Routing:** OpenRouter abstraction
- **Analytics:** DuckDB/MotherDuck when analytical workloads justify them

The MVP north-star loop is:

**Approved dealer inventory → VIN trust record → Private Buyer demand → explainable match → inquiry/opportunity → financing/warranty handoff → appointment → transaction.**

## Repository Layout

```text
apps/
  web/       React/Vite customer and dealer experience
  api/       API and integration boundary
  worker/    matching, notifications and async jobs
supabase/
  migrations/ database schema migrations
docs/        product, architecture and operating documentation
```

## Local Development

Prerequisites: Node.js 22+, pnpm, and access to the configured Clerk/Supabase environments.

```bash
cp .env.example .env
pnpm install
pnpm dev
```

Default local endpoints:

- Web: Vite development URL
- API: `http://localhost:4000`
- API health: `GET /health`
- API index: `GET /api/v1`

The initial migration at `supabase/migrations/20260831_001_core_marketplace.sql` creates the first marketplace entities for users, organizations, seller profiles, VIN-based vehicles, listings, vehicle evidence, Private Buyer demand profiles, explainable matches, and inquiries.

## Project Wiki

### Product
- [Product Requirements Document](docs/PRD.md)
- [Product Vision & Trust Model](docs/PRODUCT-VISION.md)
- [User Roles & Access Model](docs/USER-ROLES.md)
- [Private Buyer Network](docs/PRIVATE-BUYER-NETWORK.md)
- [Marketplace Workflows](docs/MARKETPLACE-WORKFLOWS.md)
- [AI Agent Layer](docs/AI-AGENTS.md)
- [ICM + OKF Context & Knowledge Architecture](docs/ICM-OKF.md)

### Implementation
- [Implementation Blueprint](docs/IMPLEMENTATION-BLUEPRINT.md)
- [Application Database Schema](docs/DATABASE-SCHEMA.md)
- [API Roadmap](docs/API-ROADMAP.md)
- [Build Roadmap](docs/BUILD-ROADMAP.md)
- [System Architecture](docs/ARCHITECTURE.md)
- [Data Model](docs/DATA-MODEL.md)
- [Integrations](docs/INTEGRATIONS.md)

### Trust, Warranty & Risk
- [Rebuilt Vehicle Trust Framework](docs/TRUST-FRAMEWORK.md)
- [Warranty Strategy](docs/WARRANTY.md)
- [Financing Strategy](docs/FINANCING.md)
- [Risk & Reserve Model](docs/RISK-RESERVE-MODEL.md)

### Operations
- [Dealer Onboarding](docs/DEALER-ONBOARDING.md)

### Governance
- [Compliance & Disclosure](docs/COMPLIANCE.md)
- [Product Roadmap](docs/ROADMAP.md)
- [Decision Log](docs/DECISION-LOG.md)

## Guiding Principle

A rebuilt title should not be hidden or minimized. The platform should make the vehicle's rebuilt history explicit, understandable, evidence-backed, and commercially manageable.

RebuiltTrustVehicle should become **trusted commerce infrastructure for rebuilt vehicles** by owning both sides of the marketplace: verified vehicle supply and structured buyer demand.
