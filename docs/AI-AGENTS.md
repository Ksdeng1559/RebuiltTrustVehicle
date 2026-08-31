# AI Agent Layer

## Purpose

RebuiltTrustVehicle should include an in-house AI engagement layer that improves response speed, lead qualification, buyer education, dealer conversion, and follow-up while preserving human oversight for regulated, contractual, financing, warranty, pricing, and dispute-sensitive decisions.

The recommended design is three cooperating agents with shared access to the same approved knowledge and CRM context.

## 1. Website Chatbot — Buyer Concierge

### Role
A public-facing conversational assistant embedded in the marketplace.

### Primary jobs
- Answer questions about rebuilt-status vehicles and how the platform works.
- Explain the Vehicle Trust Record and available evidence.
- Help buyers search and compare inventory.
- Explain the difference between verified facts, seller disclosures, third-party assessments, and platform-derived trust status.
- Surface warranty eligibility status without representing it as issued coverage.
- Explain financing pathways without making approval promises.
- Capture contact information with consent.
- Create or update a lead in the CRM.
- Schedule or request contact with an authorized dealer or platform representative.
- Escalate complex, sensitive, or uncertain questions to a human.

### Useful tools
- inventory search;
- vehicle detail retrieval;
- trust-record retrieval;
- FAQ/knowledge retrieval;
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
- change verified vehicle facts without an auditable source.

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

### DM response modes
1. **Auto-answer** — low-risk factual questions backed by approved data.
2. **Draft-for-approval** — pricing exceptions, unusual vehicle questions, sensitive claims, or low-confidence answers.
3. **Human takeover** — complaints, disputes, negotiations beyond defined limits, financing decisions, warranty disputes, legal questions, or safety concerns.

## Shared Agent Architecture

All three agents should use a shared orchestration and policy layer rather than separate independent knowledge stores.

Recommended flow:

Channel / Website → Conversation Gateway → AI Orchestrator → Policy & Permission Layer → Tools / Knowledge / CRM → Response → Audit Log

Shared services:
- model router;
- retrieval/knowledge service;
- inventory service;
- vehicle trust-record service;
- CRM/lead service;
- conversation service;
- dealer organization context;
- warranty adapter;
- financing adapter;
- appointment/task service;
- audit/event service;
- human handoff queue.

## Knowledge Hierarchy

Agents should answer from the following hierarchy:

1. Verified vehicle facts and authoritative platform records.
2. Approved dealer inventory and pricing data.
3. Confirmed warranty or financing partner status.
4. Approved platform policies and FAQs.
5. Seller disclosures, clearly identified as seller-supplied.
6. General model knowledge only where it does not conflict with platform data.

If the system cannot establish a sufficiently reliable answer, it should say so and escalate rather than inventing details.

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
- consent and communication preference where required.

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
- low-confidence answers involving material purchase decisions.

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
- revenue influenced by AI-assisted conversations.

## MVP Scope

For the first release:

### Phase A
- website Buyer Concierge;
- inventory and trust-record Q&A;
- lead capture;
- CRM conversation logging;
- human handoff.

### Phase B
- internal AI Sales Agent;
- qualification and lead scoring;
- next-best-action recommendations;
- automated follow-up under dealer-configured rules.

### Phase C
- AI DM Response Agent;
- social/messaging channel adapters;
- unified conversation inbox;
- cross-channel identity matching;
- configurable auto-answer, draft, and handoff policies.

## Product Principle

AI should accelerate trust and sales without weakening disclosure. Every agent is designed to make rebuilt-vehicle information easier to understand, move qualified buyers toward the right vehicle, and route high-risk decisions to accountable humans.
