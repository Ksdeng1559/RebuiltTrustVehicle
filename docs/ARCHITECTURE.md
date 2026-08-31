# System Architecture

## Design Goals

- Multi-tenant dealer support
- Strong role-based access
- VIN-centric data model
- Secure document storage
- Clear separation of source data, derived trust status, and partner decisions
- Replaceable warranty and financing providers
- Shared AI engagement layer across website, sales, and DM channels
- Interpretive Context Methodology (ICM) for selective, task-specific context assembly
- Open Knowledge Framework (OKF) for approved, linked, portable institutional knowledge
- Human-in-the-loop escalation for material decisions
- Artifact-based agent handoffs
- Provenance-aware knowledge lifecycle
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

All three should share one policy, knowledge, CRM, ICM context, and audit layer rather than maintaining independent facts.

## Logical Architecture

User / Social Channel → Web App or Conversation Gateway → Auth / Identity → AI Orchestrator or Application API → ICM Context Assembly → Policy & Permission Layer → Tools / System of Record / OKF Knowledge → Verification → Response or Human Approval → CRM + Audit + Outcome Capture

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
- ICM context service;
- OKF knowledge service;
- verification service;
- human handoff queue;
- admin/audit services.

## ICM Context Architecture

ICM determines what context an agent receives for a specific task. It should load the smallest sufficient context rather than the full dealer, vehicle, CRM, or conversation history.

Each material workflow should define:
- objective;
- required inputs;
- permitted knowledge sources;
- allowed tools;
- facts that must not be inferred;
- completion criteria;
- confidence threshold;
- verification rules;
- escalation conditions;
- output artifact;
- human approval requirement where applicable.

Examples of context inputs include:
- buyer identity and intent;
- dealer organization and permissions;
- VIN and vehicle record;
- verified facts;
- seller disclosures;
- inspection and repair evidence;
- warranty status;
- financing workflow status;
- prior relevant CRM activity;
- applicable policies;
- approved FAQs and sales playbooks.

## OKF Knowledge Architecture

OKF is the approved knowledge layer. It does not replace Postgres or object storage.

- Postgres stores transactional state.
- Object storage stores source documents and media.
- OKF stores approved, linked, reusable knowledge concepts.
- ICM selects which concepts and records are relevant to the current task.

The knowledge lifecycle is:

Source ingestion → Draft concept → Verification / human review → Publish to approved knowledge → Update knowledge log / lifecycle metadata

The platform should preserve one authoritative home per material fact and link to that fact rather than duplicating it across prompts or agent memories.

Useful OKF object types include:
- VehiclePassport;
- VehicleFact;
- SellerDisclosure;
- InspectionEvidence;
- DealerProfile;
- WarrantyPolicy;
- FinancingPolicy;
- FAQ;
- SOP;
- Playbook;
- CompliancePolicy;
- Decision;
- EvidenceSummary.

## AI Conversation Architecture

Channel / Website → Conversation Gateway → AI Orchestrator → ICM Context Assembly → Policy Engine → Tool Calls / OKF Retrieval → Verification → Response → CRM Summary + Audit Event + Outcome

### AI Orchestrator responsibilities
- load dealer/tenant context;
- identify buyer and vehicle context;
- request the correct ICM context packet;
- retrieve approved OKF knowledge;
- choose allowed tools;
- enforce channel and dealer-specific automation rules;
- determine confidence and escalation;
- create structured CRM events;
- generate artifact-based handoffs;
- prevent unsupported warranty, financing, price, safety, or legal claims.

### Conversation modes
- **Auto-answer** for low-risk, evidence-backed questions.
- **Draft-for-approval** for sensitive or low-confidence responses.
- **Human takeover** for disputes, negotiations outside authority, warranty/finance decisions, safety issues, or legal/regulatory questions.

## Artifact-Based Handoffs

Agents should not rely solely on conversation history when passing work to another agent or human. Material handoffs should include structured artifacts containing the workflow run, objective, evidence, findings, unresolved questions, confidence, and recommended next action.

This allows replay, QA, analytics, verification, and audit reconstruction.

## Learning Loop

Operational outcomes must not automatically become approved knowledge.

Conversation / action → Outcome capture → Candidate lesson → Validation → Human review when material → OKF publication

This creates institutional memory without allowing model-generated assumptions to contaminate the source of truth.

## Multi-Tenancy

Organizations represent dealers or partner entities. Every dealer-owned record, conversation, prompt configuration, lead, context packet, knowledge permission, and automation policy must carry an organization identifier and authorization must be enforced server-side.

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
- KnowledgeProvider
- ContextProvider

This avoids hard-coding Lubrico, any single finance partner, messaging provider, model vendor, or knowledge implementation into core product logic.

## Auditability

Material changes and AI actions should create immutable audit events containing actor/agent, timestamp, entity, prior state where appropriate, new state, source, context references, tool used, confidence/escalation state where relevant, verification result, and human approval where required.

See [AI Agent Layer](AI-AGENTS.md) and [ICM + OKF Context & Knowledge Architecture](ICM-OKF.md) for detailed behavior and guardrails.
