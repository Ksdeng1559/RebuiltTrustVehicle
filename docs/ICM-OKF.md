# Interpretive Context Methodology (ICM) + Open Knowledge Framework (OKF)

## Purpose

RebuiltTrustVehicle uses an interpretive context layer and an open knowledge layer so its AI agents can operate with the right context, preserve provenance, remain auditable, and improve without turning chat history into the system of record.

The design follows two complementary responsibilities:

- **ICM** controls how operating context is assembled, staged, routed, reviewed, and handed from one workflow step or agent role to the next.
- **OKF** controls how approved knowledge is stored, linked, maintained, shared, and reused as a portable source-of-truth layer.

This separation matters because context is temporary and task-specific, while approved knowledge should be durable, structured, and reusable.

## Core Pattern

Source / Event → ICM Context Assembly → Agent or Workflow → Verification → Human Review / Approval → Action → Outcome → OKF Knowledge Capture

This makes the platform workflow-driven rather than chat-driven.

## 1. ICM — Interpretive Context Layer

### Objective

Give each AI agent the smallest correct context required to perform its current job safely.

The system should not load every dealer record, every vehicle record, or an entire conversation archive by default. Context is assembled selectively from declared inputs and authoritative sources.

### Context dimensions

For a buyer, seller, vehicle, dealer, or conversation, the ICM layer may assemble:

- current user identity and role;
- dealer organization and permissions;
- current VIN / vehicle record;
- verified facts;
- seller disclosures;
- inspection and repair evidence;
- warranty eligibility or issued-status data;
- financing workflow status;
- current conversation intent;
- prior relevant CRM activity;
- applicable policies and compliance constraints;
- approved FAQs and sales playbooks;
- unresolved questions;
- confidence and escalation conditions.

### Context contract

Every material AI workflow should declare:

- objective;
- required inputs;
- permitted knowledge sources;
- tools allowed;
- facts that must not be inferred;
- completion criteria;
- confidence threshold;
- verification rules;
- escalation conditions;
- output artifact;
- human approval requirement, if any.

### Context packet example

```yaml
context:
  workflow: buyer_vehicle_inquiry
  role: buyer_concierge
  objective: answer buyer questions and determine next action
  subject:
    vin: <VIN>
    dealer_id: <dealer-id>
  load:
    - vehicle.verified_facts
    - vehicle.seller_disclosures
    - vehicle.inspection_evidence
    - vehicle.warranty_status
    - listing.current_price
    - dealer.approved_faq
    - platform.compliance_rules
  do_not_infer:
    - financing_approval
    - warranty_coverage_not_confirmed
    - undisclosed_damage_history
  escalation:
    - low_confidence_material_fact
    - complaint_or_dispute
    - safety_question
    - financing_decision
    - warranty_dispute
```

## 2. Human-Gated Execution

Meaningful outputs must remain reviewable and auditable.

The platform should support three operating states:

1. **Automatic** — low-risk, evidence-backed factual responses.
2. **Draft / verify** — an agent produces a structured draft that requires validation or human approval.
3. **Human-controlled** — consequential commitments or sensitive matters are routed to a person.

Examples of human-gated actions include:

- final negotiated price exceptions;
- financing approval statements;
- warranty coverage commitments;
- disputes and complaints;
- legal or regulatory statements;
- safety-sensitive questions;
- changes to verified vehicle facts;
- public claims not supported by stored evidence.

## 3. Artifact-Based Handoffs

Agents should pass structured artifacts, not only conversational messages.

A handoff should contain:

```yaml
handoff:
  workflow_run_id: <run-id>
  task_id: <task-id>
  from_role: dm_response_agent
  to_role: sales_agent
  status: ready
  buyer_intent: financing_and_test_drive
  vehicle_id: <vehicle-id>
  evidence:
    - source: vehicle_record
    - source: conversation
  findings:
    - buyer_budget: <value-if-provided>
    - purchase_timeline: <value-if-provided>
  unresolved_questions:
    - trade_in_status
  confidence: <score>
  next_action: human_or_agent_follow_up
```

This permits replay, quality assurance, analytics, and accountability.

## 4. OKF — Open Knowledge Layer

### Objective

Store approved knowledge in a portable, model-neutral form that can be used by the website chatbot, in-house sales agent, DM response agent, administrators, and future systems.

The OKF layer should be separate from drafts and raw source material.

### Knowledge lifecycle

Ingest source → Draft linked concept → Verify / human review → Publish to knowledge layer → Update change log and lifecycle metadata

Provenance, verification state, or timestamps must never be invented.

### Recommended knowledge structure

```text
knowledge/
├── index.md
├── log.md
├── identity/
│   └── platform.md
├── vehicles/
│   └── <vin-or-vehicle-id>/
│       ├── passport.md
│       ├── repair-history.md
│       └── inspections.md
├── dealers/
│   └── <dealer-id>.md
├── strategy/
│   ├── buyer-trust.md
│   └── positioning.md
├── operations/
│   ├── buyer-concierge.md
│   ├── lead-qualification.md
│   ├── dm-response.md
│   ├── dealer-onboarding.md
│   └── human-handoff.md
├── governance/
│   ├── compliance.md
│   ├── disclosure-policy.md
│   └── ai-guardrails.md
├── evidence/
│   └── <source-summary>.md
├── partners/
│   ├── warranty.md
│   └── financing.md
├── projects/
└── decisions/
```

## 5. Knowledge Object Requirements

Every approved knowledge concept should have a non-empty `type` and should distinguish source, status, and verification when those fields are actually grounded.

Example:

```yaml
---
type: VehiclePassport
title: Vehicle Passport — <VIN>
status: current
sources:
  - id: inspection-record
    resource: <source-reference>
verified:
  - by: <verified-actor-if-known>
    at: <verified-time-if-known>
---
```

Useful object types include:

- VehiclePassport
- VehicleFact
- SellerDisclosure
- InspectionEvidence
- DealerProfile
- WarrantyPolicy
- FinancingPolicy
- FAQ
- SOP
- Playbook
- CompliancePolicy
- Decision
- EvidenceSummary
- ConversationInsight

## 6. One Home Per Fact

A material fact should have one authoritative home.

Agents link to that fact rather than copying it into multiple prompts, documents, or dealer notes.

Examples:

- current asking price belongs to the listing record;
- rebuilt status belongs to the vehicle record;
- seller-supplied damage explanation belongs to seller disclosure;
- confirmed warranty issuance belongs to the warranty transaction/status record;
- buyer communication consent belongs to the CRM/contact record;
- reusable sales procedure belongs to an approved SOP or Playbook.

This prevents contradictory agent responses.

## 7. Progressive Disclosure

Agents and operators should enter through small routing indexes rather than loading the whole knowledge base.

`knowledge/index.md` should answer:

- what knowledge domains exist;
- which object is authoritative for each domain;
- where an agent should go for a specific task;
- what is draft versus approved;
- what requires human verification.

## 8. AI Agent Integration

### Website Buyer Concierge

ICM assembles the specific vehicle, buyer intent, dealer, policy, warranty, and financing context required for the current inquiry.

OKF supplies approved FAQs, trust explanations, disclosure rules, vehicle knowledge, and operating playbooks.

### In-House AI Sales Agent

ICM assembles current lead stage, buyer preferences, relevant vehicles, prior activity, dealer rules, and approved next-action context.

OKF supplies sales playbooks, qualification SOPs, objection-handling guidance, dealer policies, and reusable lessons.

### AI DM Response Agent

ICM assembles channel, message intent, referenced listing, buyer identity when known, consent state, and escalation rules.

OKF supplies approved responses, channel policy, product knowledge, financing/warranty boundaries, and handoff procedures.

## 9. Learning Loop

Agent outcomes should not automatically become knowledge.

The sequence is:

Conversation / action → outcome capture → candidate lesson → validation → human approval where material → OKF publication

Examples of reusable learning:

- common buyer objections;
- questions that predict high purchase intent;
- effective vehicle-comparison patterns;
- frequent financing friction;
- common warranty misunderstandings;
- dealer response practices associated with higher conversion.

This turns operational activity into institutional memory without letting model-generated assumptions contaminate the source of truth.

## 10. Data Architecture Relationship

The OKF layer does not replace Supabase/Postgres.

- **Supabase/Postgres** remains the transactional system of record.
- **Object storage** stores uploaded documents and media.
- **OKF** represents approved, linked knowledge and reusable operating context.
- **ICM** determines what context is assembled for a workflow or agent run.
- **CRM** holds buyer/dealer relationships and sales activity.
- **Audit events** record what an agent or human did and why.

## 11. Acceptance Criteria

The ICM/OKF architecture is successful when:

1. An agent can determine the correct authoritative sources without loading the entire workspace.
2. Each material workflow defines its context inputs and escalation rules.
3. Verified facts, seller disclosures, derived insights, and AI-generated drafts remain distinguishable.
4. Material agent handoffs use structured artifacts.
5. High-risk actions can pause for human approval.
6. Approved knowledge has one authoritative home and can be linked rather than duplicated.
7. Knowledge provenance can be reconstructed where source data exists.
8. Agents cannot silently promote draft or inferred content into verified knowledge.
9. Reusable lessons can be reviewed and converted into approved knowledge.
10. A new agent can use the routing/index layer to understand where to retrieve relevant context.

## Product Principle

The platform should not merely remember conversations. It should **interpret the right context for the current task, execute within explicit boundaries, verify consequential outputs, and convert approved learning into durable institutional knowledge**.
