# System Architecture

## Design Goals

- Multi-tenant dealer support
- Strong role-based access
- VIN-centric data model
- Secure document storage
- Clear separation of source data, derived trust status, and partner decisions
- Replaceable warranty and financing providers
- Shared AI engagement layer across website, sales, and DM channels
- Human-in-the-loop escalation for material decisions
- Auditability
- Railway/Vercel deployment compatibility

## Proposed Stack

### Frontend
Vite + React.

### Authentication
Clerk or equivalent multi-tenant identity provider.

### Application/API Layer
Node/TypeScript service layer deployed to Railway or compatible runtime.

### System of Record
Supabase/Postgres.

### Document Storage
Supabase Storage or compatible object storage.

### Analytics / Enrichment
DuckDB/MotherDuck may be used for analytical workloads, enrichment staging, and reporting. It should not replace the transactional system of record.

### AI Layer
OpenRouter or another model abstraction can support document extraction, classification, listing assistance, buyer conversations, lead qualification, follow-up, DM response, and internal operations. AI output must be provenance-aware and should not overwrite verified facts without review.

The AI layer should expose three product roles:
- Website Buyer Concierge;
- In-House AI Sales Agent;
- AI DM Response Agent.

All three should share one policy, knowledge, CRM, and audit layer rather than maintaining independent facts.

## Logical Architecture

User / Social Channel → Web App or Conversation Gateway → Auth / Identity → AI Orchestrator or Application API → Policy & Permission Layer → Postgres/System of Record

Application and agent services connect to:
- inventory and vehicle trust-record service;
- document storage;
- warranty adapter;
- financing adapter;
- VIN/data providers;
- CRM / lead service;
- messaging / channel adapters;
- appointment and task services;
- notification services;
- analytics/enrichment layer;
- human handoff queue;
- admin/audit services.

## AI Conversation Architecture

Channel / Website → Conversation Gateway → AI Orchestrator → Policy Engine → Tool Calls → Response → CRM Summary + Audit Event

### AI Orchestrator responsibilities
- load dealer/tenant context;
- identify buyer and vehicle context;
- retrieve approved knowledge;
- choose allowed tools;
- enforce channel and dealer-specific automation rules;
- determine confidence and escalation;
- create structured CRM events;
- prevent unsupported warranty, financing, price, safety, or legal claims.

### Conversation modes
- **Auto-answer** for low-risk, evidence-backed questions.
- **Draft-for-approval** for sensitive or low-confidence responses.
- **Human takeover** for disputes, negotiations outside authority, warranty/finance decisions, safety issues, or legal/regulatory questions.

## Multi-Tenancy

Organizations represent dealers or partner entities. Every dealer-owned record, conversation, prompt configuration, lead, and automation policy must carry an organization identifier and authorization must be enforced server-side.

## Integration Pattern

Use provider adapters:
- WarrantyProvider
- FinanceProvider
- VehicleDataProvider
- InspectionProvider
- NotificationProvider
- CRMProvider
- MessagingChannelProvider
- ModelProvider

This avoids hard-coding Lubrico, any single finance partner, messaging provider, or model vendor into core product logic.

## Auditability

Material changes and AI actions should create immutable audit events containing actor/agent, timestamp, entity, prior state where appropriate, new state, source, tool used, confidence/escalation state where relevant, and human approval where required.

See [AI Agent Layer](AI-AGENTS.md) for detailed behavior and guardrails.
