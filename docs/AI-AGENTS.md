# AI Agent Layer

## Purpose

RebuiltTrustVehicle should include an in-house AI engagement layer that improves response speed, lead qualification, buyer education, dealer conversion, and follow-up while preserving human oversight for regulated, contractual, financing, warranty, pricing, and dispute-sensitive decisions.

The recommended design is three cooperating agents with shared access to the same approved knowledge, CRM context, Interpretive Context Methodology (ICM), and Open Knowledge Framework (OKF).

## Operating Model

The agents should not simply receive a large prompt or full conversation history.

For every material task:

Trigger / Message → ICM Context Assembly → Agent Role → Tool / Knowledge Use → Verification → Response or Human Approval → CRM / Audit → Outcome Capture → Candidate OKF Learning

ICM determines the smallest correct context required for the current task. OKF provides approved, linked, reusable knowledge. Drafts, inferred conclusions, and raw chat history do not automatically become authoritative knowledge.

## 1. Website Chatbot — Buyer Concierge

### Role
A public-facing conversational assistant embedded in the marketplace.

### Primary jobs
- Answer questions about rebuilt-status vehicles and how the platform works.
- Explain the Vehicle Trust Record and available evidence.
- Help buyers search and compare inventory.
- Explain the difference between verified facts, seller disclosures, third-party assessments, platform-derived trust status, and AI-generated interpretation.
- Surface warranty eligibility status without representing it as issued coverage.
- Explain financing pathways without making approval promises.
- Capture contact information with consent.
- Create or update a lead in the CRM.
- Schedule or request contact with an authorized dealer or platform representative.
- Escalate complex, sensitive, or uncertain questions to a human.

### ICM context packet
The Buyer Concierge should normally receive only the relevant:
- buyer identity / intent where known;
- current VIN or listing;
- verified vehicle facts;
- seller disclosures;
- inspection evidence;
- approved platform FAQ;
- current warranty status;
- current financing pathway status;
- dealer organization context;
- consent state;
- applicable guardrails.

### Useful tools
- inventory search;
- vehicle detail retrieval;
- trust-record retrieval;
- approved OKF knowledge retrieval;
- lead creation;
- appointment/request creation;
- conversation logging.

## 2. In-House AI Sales Agent

### Role
An internal sales-development and conversion agent that works across qualified leads, dealer inventory, and CRM opportunities.

### Primary jobs
- Score and prioritize inbound leads.
- Match buyers with suitable vehicles.
- Follow up on abandoned inquiries.
- Ask qualification questions such as budget, down payment, preferred vehicle type, purchase timeline, trade-in, warranty interest, and financing interest.
- Recommend next-best actions to sales staff.
- Draft personalized follow-ups.
- Re-engage stale leads.
- Route finance-ready buyers to the financing workflow.
- Route warranty-interested buyers to the eligibility workflow.
- Create sales tasks and reminders.
- Maintain CRM summaries and lead stage recommendations.

### ICM context packet
The Sales Agent should normally receive:
- buyer profile and consent;
- current lead stage;
- purchase intent and timing;
- prior relevant CRM activity;
- shortlisted vehicles;
- dealer pricing authority and sales rules;
- financing / warranty workflow state;
- approved sales SOPs and playbooks from OKF;
- unresolved qualification questions;
- escalation rules.

### Suggested lead stages
New → Engaged → Qualified → Vehicle Matched → Test Drive / Appointment → Financing / Warranty → Negotiation → Sold → Follow-up.

### Guardrails
The AI Sales Agent should not independently:
- bind a vehicle sale;
- commit a dealer to a final price unless explicitly authorized by configured business rules;
- state that financing is approved;
- state that warranty coverage exists before confirmed issuance;
- provide legal or insurance advice;
- hide or minimize rebuilt-title status;
- change verified vehicle facts without an auditable source;
- promote an inferred sales conclusion into approved OKF knowledge without validation.

## 3. AI DM Response Agent

### Role
A channel-response agent for direct messages from social and messaging channels.

Potential channels include Instagram, Facebook Messenger, WhatsApp, website messaging, SMS, and other supported dealer channels.

### Primary jobs
- Respond rapidly to inventory questions.
- Identify which vehicle or listing a prospect is referring to.
- Answer approved FAQs.
- Ask lightweight qualification questions.
- Capture buyer intent and contact information with appropriate consent.
- Send vehicle links and evidence summaries.
- Offer appointment or call handoff.
- Route financing and warranty questions to the appropriate workflow.
- Create/update the CRM conversation and lead record.
- Escalate low-confidence, complaint, dispute, legal, pricing-exception, financing-decision, or warranty-coverage conversations to a human.

### ICM context packet
The DM agent should normally receive:
- channel and message context;
- referenced listing or VIN;
- known buyer identity and consent;
- approved channel response rules;
- verified vehicle facts;
- approved FAQs and playbooks;
- dealer routing information;
- escalation conditions.

### DM response modes
1. **Auto-answer** — low-risk factual questions backed by approved data.
2. **Draft-for-approval** — pricing exceptions, unusual vehicle questions, sensitive claims, or low-confidence answers.
3. **Human takeover** — complaints, disputes, negotiations beyond defined limits, financing decisions, warranty disputes, legal questions, or safety concerns.

## Shared Agent Architecture

All three agents should use a shared orchestration and policy layer rather than separate independent knowledge stores.

Recommended flow:

Channel / Website → Conversation Gateway → AI Orchestrator → ICM Context Service → Policy & Permission Layer → Tools / OKF / CRM → Verification → Response → Audit Log

Shared services:
- model router;
- ICM context service;
- OKF knowledge service;
- retrieval service;
- inventory service;
- vehicle trust-record service;
- CRM/lead service;
- conversation service;
- dealer organization context;
- warranty adapter;
- financing adapter;
- appointment/task service;
- verification service;
- audit/event service;
- human handoff queue.

## Knowledge Hierarchy

Agents should answer from the following hierarchy:

1. Verified vehicle facts and authoritative platform records.
2. Approved dealer inventory and pricing data.
3. Confirmed warranty or financing partner status.
4. Approved OKF platform policies, SOPs, playbooks, and FAQs.
5. Seller disclosures, clearly identified as seller-supplied.
6. AI-generated interpretation based on the above, clearly non-authoritative where appropriate.
7. General model knowledge only where it does not conflict with platform data.

If the system cannot establish a sufficiently reliable answer, it should say so and escalate rather than inventing details.

## Artifact-Based Handoffs

Material handoffs between agents or from AI to humans should use structured artifacts rather than only conversational messages.

A handoff should capture:
- workflow run and task;
- source and destination role;
- objective;
- relevant VIN / lead / dealer;
- evidence references;
- findings;
- unresolved questions;
- confidence;
- recommended next action;
- verification / human approval state where applicable.

## CRM Requirements

Every meaningful conversation should be associated with:
- contact / lead;
- dealer organization where applicable;
- vehicle / VIN where applicable;
- channel;
- conversation transcript or structured summary;
- intent;
- qualification state;
- next action;
- owner / human assignee;
- AI confidence / escalation reason;
- consent and communication preference where required;
- references to material context or handoff artifacts where useful.

## OKF Knowledge Lifecycle

Agents do not write directly into approved knowledge by default.

The lifecycle is:

Source or outcome → Draft concept / candidate lesson → Verification → Human review where material → Publish to OKF → Update knowledge log / lifecycle state.

Reusable knowledge may include:
- buyer objection patterns;
- approved answers;
- dealer sales SOPs;
- warranty explanation playbooks;
- financing routing rules;
- human escalation procedures;
- vehicle trust education content;
- validated sales lessons.

A material fact should have one authoritative home and be linked rather than copied across prompts.

## Agent Identity and Transparency

The platform should use clear, non-deceptive agent identity. The AI may operate under a branded assistant name, but the experience should not falsely imply that an automated system is a specific human employee.

## Human-in-the-Loop Rules

Human review or takeover is required for:
- final price exceptions and negotiated commitments outside configured authority;
- financing approval or lender decisions;
- definitive warranty coverage statements unless returned directly from a confirmed provider status;
- complaints or disputes;
- legal, regulatory, insurance, or liability questions;
- vehicle safety concerns;
- requests involving sensitive personal or financial information beyond the approved workflow;
- low-confidence answers involving material purchase decisions;
- changes to authoritative facts or policies;
- promotion of material inferred knowledge into approved OKF.

## Recommended Metrics

- first-response time;
- percentage of inquiries automatically resolved;
- human handoff rate;
- lead capture rate;
- qualified-lead rate;
- appointment rate;
- finance application rate;
- warranty-interest and attachment rate;
- inquiry-to-sale conversion;
- stale-lead reactivation rate;
- response accuracy / QA score;
- complaint and correction rate;
- context retrieval accuracy;
- percentage of material responses backed by authoritative sources;
- knowledge reuse rate;
- approved knowledge correction / staleness rate;
- revenue influenced by AI-assisted conversations.

## MVP Scope

For the first release:

### Phase A
- website Buyer Concierge;
- inventory and trust-record Q&A;
- ICM context packet generation;
- approved OKF FAQ / policy retrieval;
- lead capture;
- CRM conversation logging;
- human handoff.

### Phase B
- internal AI Sales Agent;
- qualification and lead scoring;
- next-best-action recommendations;
- approved sales SOP/playbook retrieval;
- automated follow-up under dealer-configured rules;
- structured artifact handoffs.

### Phase C
- AI DM Response Agent;
- social/messaging channel adapters;
- unified conversation inbox;
- cross-channel identity matching;
- configurable auto-answer, draft, and handoff policies;
- validated outcome-to-knowledge learning loop.

## Product Principle

AI should accelerate trust and sales without weakening disclosure. Every agent is designed to make rebuilt-vehicle information easier to understand, move qualified buyers toward the right vehicle, and route high-risk decisions to accountable humans.

The agents should **interpret the right context for the task, use approved knowledge, create auditable handoffs, and turn only validated outcomes into institutional knowledge**.

See [ICM + OKF Context & Knowledge Architecture](ICM-OKF.md) for the full methodology.
