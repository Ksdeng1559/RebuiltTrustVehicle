# Product Requirements Document — RebuiltTrustVehicle

## 1. Executive Summary

RebuiltTrustVehicle is a BC-focused trust, marketplace, buyer-network, and transaction platform for rebuilt-status vehicles.

The platform addresses the central market failure in rebuilt vehicles: buyers often face incomplete history, inconsistent disclosure, limited warranty availability, financing friction, uncertain repair quality, and difficulty locating newer rebuilt vehicles that fit their needs.

RebuiltTrustVehicle increases trust and liquidity by:
- restricting commercial seller access to authorized dealers;
- supporting a separately governed Private Seller Network;
- creating a dedicated Private Buyer Network;
- capturing structured buyer demand before inventory appears;
- matching buyers to current and incoming rebuilt inventory;
- standardizing VIN-centric evidence and disclosure;
- integrating warranty and financing pathways;
- supporting rebuild/inspection/Tesla/EV specialist evidence;
- adding governed AI engagement and sales workflows;
- using Interpretive Context Methodology (ICM) and an Open Knowledge Framework (OKF) for reliable AI context and institutional knowledge.

The strategic model is not only `vehicle listed → wait for buyer`. It also supports `buyer joins → defines desired vehicle → AI matches inventory → dealer receives qualified opportunity`.

## 2. Problem

Rebuilt vehicles can represent strong value, but the market is fragmented and trust-deficient.

### Buyer problems
- unclear prior damage and repair history;
- inconsistent disclosure;
- uncertainty regarding inspections;
- limited warranty options;
- financing difficulty;
- uncertainty about resale value;
- concern that future mechanical failure may be related to prior damage;
- difficulty finding specific newer/late-model rebuilt vehicles;
- no persistent way to express purchase demand and be matched when suitable inventory appears.

### Dealer problems
- lower buyer confidence;
- longer days-to-sale;
- financing objections;
- difficulty differentiating professionally rebuilt inventory from poor-quality inventory;
- lack of a standardized trust framework;
- limited visibility into what rebuilt vehicles buyers actually want;
- inefficient follow-up across website, social, DM, and marketplace leads.

## 3. Product Vision

Create the most trusted commerce network for rebuilt-status vehicles by connecting verified vehicle supply with structured buyer demand, transparent evidence, financing, warranty, specialist expertise, and governed AI-assisted sales.

Long-term positioning: **trusted commerce infrastructure for rebuilt vehicles**.

## 4. Target Market

### Initial geography
British Columbia, Canada.

### Vehicle focus
ICBC rebuilt-status vehicles, including conventional ICE vehicles, newer/late-model vehicles, premium vehicles, EVs, and rebuilt Teslas.

### Primary supply — Authorized Dealer Network
Authorized used-car dealers approved by the platform.

### Secondary supply — Private Seller Network
Private sellers may participate under stricter controls, lower listing/transaction limits, identity and ownership verification, and applicable legal/licensing rules.

### Demand — Private Buyer Network
Consumers who intentionally want to purchase rebuilt vehicles for personal use. Buyers can browse normally or create structured Vehicle Buying Profiles that allow the platform to match them to current and incoming inventory.

## 5. User Roles

- Platform Administrator
- Authorized Dealer
- Dealer Staff
- Private Buyer
- Private Seller
- Finance Partner
- Warranty Partner
- Inspection / Repair Evidence Provider
- Rebuild / EV Specialist
- Compliance / Review Operator
- AI Buyer Concierge
- AI Sales Agent
- AI DM Response Agent

Private Buyer and Private Seller are distinct roles. One user may hold both where permitted.

## 6. Core Product Modules

### 6.1 Dealer Verification
Dealers complete business identity, licensing, contact, banking/payment, and platform-policy verification before listing inventory.

### 6.2 Private Buyer Network
Private buyers may create one or more structured Vehicle Buying Profiles.

Potential fields include:
- preferred make;
- preferred model;
- year range;
- maximum purchase price;
- target monthly payment;
- down payment;
- financing requirement;
- warranty requirement/preference;
- trade-in indicator;
- EV preference;
- acceptable mileage;
- geographic preference;
- purchase timeframe;
- required features;
- optional preferences.

Explicitly stated requirements must remain distinguishable from AI-inferred preferences.

### 6.3 Buyer-to-Inventory Matching Engine
The platform evaluates active buyer demand against:
- current authorized-dealer inventory;
- incoming dealer inventory;
- eligible private-seller inventory;
- specialist-reviewed inventory where available.

A match should preserve:
- hard criteria satisfied;
- hard criteria not satisfied;
- optional preferences satisfied;
- source of buyer requirement;
- explanation of why the vehicle was recommended;
- match status;
- buyer notification status;
- dealer routing status;
- AI/human disposition.

High-intent matches may create or update CRM opportunities for dealer follow-up.

### 6.4 VIN-Centric Vehicle Record
Each listing is anchored to a VIN and stores:
- vehicle identity;
- rebuilt status;
- seller;
- inspection evidence;
- repair disclosures;
- images and supporting documents;
- specialist assessments where applicable;
- warranty eligibility/status;
- financing eligibility/status;
- listing history;
- transaction history where appropriate.

### 6.5 Listing Workflow
Sellers create a listing by entering the VIN first. The platform then guides them through required evidence, disclosures, condition information, pricing, and media.

A vehicle cannot receive a high-trust designation until required evidence is complete.

Once a listing is published or materially updated, the buyer-match engine may evaluate it against active demand.

### 6.6 Trust Score / Trust Status
The platform may assign a trust status based on evidence completeness rather than making an unsupported prediction of mechanical reliability.

Potential factors:
- VIN verified;
- rebuilt status disclosed;
- inspection uploaded;
- repair documentation uploaded;
- before/after photos available;
- seller verified;
- warranty eligibility confirmed;
- independent mechanical inspection available;
- specialist assessment available;
- disclosure completeness.

### 6.7 Warranty
Lubrico Warranty is the current preferred warranty direction, subject to written confirmation of eligibility for the specific rebuilt-status vehicle and VIN.

The platform must never imply warranty coverage until eligibility and contract terms are confirmed.

Warranty states should distinguish eligibility from issued coverage.

### 6.8 Vehicle Financing
The marketplace includes a financing workflow allowing a buyer to request financing from participating lenders or brokers.

The vehicle record should transmit relevant data to finance partners, including VIN, price, rebuilt status, seller, down payment, and applicant-authorized information.

The platform must not represent a buyer as approved until the participating finance partner has actually issued that status.

### 6.9 Private Seller Network
The private seller channel is separated from the authorized-dealer channel in the UI and trust model.

Controls may include:
- identity verification;
- ownership verification;
- lower listing limits;
- additional documentation requirements;
- transaction-volume monitoring;
- explicit seller-type labeling;
- admin review;
- dealer/partner routing where appropriate.

### 6.10 Specialist Trust Network
The platform may support inspection, rebuild, collision, mechanical, Tesla/EV, battery, high-voltage, calibration, and other specialist evidence providers.

For rebuilt EVs/Teslas, specialist scope may include:
- battery condition;
- high-voltage systems;
- charging functionality;
- cameras and sensors;
- structural repair;
- ADAS/calibration;
- software functionality;
- related technical findings supported by the provider.

Specialist findings remain attributable to the provider and are not automatically converted into platform-certified facts.

### 6.11 Private Buyer Journey
Join → browse or create Vehicle Buying Profile → receive matches/alerts → open vehicle trust record → compare → AI concierge/inquiry → warranty information → financing option → qualification → appointment/test drive → due diligence → purchase documentation → transaction.

### 6.12 AI Engagement Layer
The platform includes three governed AI roles:

- Website Buyer Concierge;
- In-House AI Sales Agent;
- AI DM Response Agent.

These agents share approved knowledge, CRM context, VIN records, dealer context, buyer profiles, policy rules, and audit controls. They must not operate from isolated or conflicting knowledge stores.

The AI Sales Agent may:
- collect buyer requirements;
- qualify demand;
- recommend matching inventory;
- identify financing/warranty/trade-in/timeframe interest;
- follow up leads;
- schedule appointments;
- route high-intent opportunities to dealers;
- update CRM activity within allowed permissions.

The AI DM Response Agent may perform similar qualification for approved inbound channels such as web, social, DM, SMS, or WhatsApp where implemented.

### 6.13 Interpretive Context Methodology (ICM)
ICM governs how the platform assembles the smallest correct context for a specific agent task or workflow step.

Each material AI workflow must declare:
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

ICM context may include the current VIN, verified facts, seller disclosures, inspection evidence, dealer policies, buyer intent, CRM history, warranty status, financing status, consent, and applicable compliance rules.

### 6.14 Open Knowledge Framework (OKF)
OKF provides the approved, portable knowledge layer used across AI agents, administrators, and future integrations.

Approved knowledge should be represented as linked concepts with one authoritative home per material fact. Reusable SOPs and playbooks should be separated from dealer-specific or buyer-specific facts.

The knowledge lifecycle is:

Source ingestion → Draft concept → Verification / human review → Publish → Log / lifecycle update.

Provenance, verification state, and timestamps must not be invented.

### 6.15 Artifact-Based Handoffs and Learning
Material agent handoffs should use structured artifacts containing evidence, findings, unresolved questions, confidence, and next action.

Operational outcomes may generate candidate lessons, but agent output must not automatically become approved knowledge. Material lessons require validation and, where appropriate, human approval before being promoted to OKF.

## 7. Trust Framework

The platform should distinguish between:

**Verified fact** — supported by a document or authoritative source.

**Seller disclosure** — supplied by seller and identified as such.

**Buyer requirement** — explicitly supplied by the buyer.

**AI-inferred preference** — inferred from conversation or behaviour and never treated as an explicit buyer instruction without confirmation where consequential.

**Third-party assessment** — supplied by mechanic, inspector, warranty provider, lender, rebuild/EV specialist, or other third party.

**Platform-derived status** — indicates evidence completeness, workflow status, or match status; it must not be represented as a guarantee of vehicle quality.

**AI-generated interpretation** — contextual guidance or summary produced from approved inputs; it must remain distinguishable from verified facts.

## 8. Business Model

Potential revenue streams:
- dealer subscriptions;
- listing fees;
- promoted listings;
- qualified buyer-match opportunities;
- transaction fees where permitted;
- warranty referral/revenue share where permitted;
- financing referral/revenue share where permitted;
- inspection/specialist services;
- trust certification/document package fees;
- private seller services;
- future Buyer+ membership;
- vehicle sourcing/concierge services;
- dealer software tools;
- AI sales-assistant subscription or usage tier;
- premium lead-response / CRM automation features.

## 9. Warranty Reserve / Self-Funded Protection Research

A separate actuarial/risk workstream evaluates whether the platform could support a reserve-backed repair protection product or dealer-funded protection program.

This must remain separate from the MVP until legal, actuarial, insurance, tax, claims-administration, and regulatory requirements have been validated.

## 10. MVP Requirements

MVP must include:
- account authentication;
- role-based access;
- dealer approval workflow;
- Private Buyer onboarding;
- Vehicle Buying Profile;
- saved buyer preferences;
- Private Seller workflow;
- VIN-based listings;
- rebuilt-status disclosure;
- document uploads;
- vehicle photo gallery;
- search and filters;
- buyer inquiry;
- initial buyer-to-inventory matching;
- match alerts or CRM routing;
- website Buyer Concierge;
- CRM lead capture and conversation logging;
- human handoff queue;
- ICM context contracts for AI workflows;
- approved knowledge retrieval layer;
- clear separation of draft/inferred versus verified knowledge;
- warranty eligibility workflow/status;
- financing lead/application handoff;
- admin review dashboard;
- audit log for material listing, buyer-demand, match, and AI actions.

## 11. Non-Functional Requirements

- Mobile-first responsive UI
- Canadian privacy-conscious data handling
- Secure document storage
- Role-based authorization
- Auditability
- VIN uniqueness and normalization
- Structured buyer-demand storage
- Explainable buyer-to-vehicle matching
- Consent-aware messaging and lead workflows
- Clear disclosure provenance
- Scalable multi-tenant dealer structure
- API-ready architecture
- Selective context loading
- One authoritative home per material fact
- Portable, model-neutral knowledge representation
- Human-gated consequential actions
- Reconstructable agent handoffs and decisions

## 12. Proposed Technical Direction

Frontend: Vite + React.

Hosting: Vercel for frontend or Railway where a unified deployment is preferred.

Application/backend services: Railway-compatible service layer.

Authentication / multi-tenant identity: Clerk is a candidate.

System of record: Supabase/Postgres.

Object/document storage: Supabase Storage or compatible object storage.

Analytics/enrichment: DuckDB/MotherDuck where useful.

AI/model routing: OpenRouter or equivalent abstraction.

Context layer: ICM-based context service that selects task-specific authoritative inputs.

Knowledge layer: OKF-style approved knowledge bundle / knowledge service linked to source records and lifecycle metadata.

CRM: shared lead, buyer profile, match, conversation, consent, appointment, and sales-activity store connected to AI agents.

## 13. Compliance Principles

- Rebuilt status must be prominent.
- Material facts must not be hidden behind marketing language.
- Warranty status must identify eligibility versus actual issued coverage.
- Financing is subject to lender approval.
- Seller type must be clearly shown.
- Buyer consent and communication preferences must be respected.
- AI-inferred buyer preferences must not silently become explicit buyer requirements.
- Platform trust indicators must not be represented as government, ICBC, mechanical, specialist, or insurance certification unless actually issued by that party.
- AI must not convert inference into verified fact.
- High-risk AI actions must support human review or takeover.
- Knowledge provenance must remain available where source data exists.

## 14. Success Metrics

### Supply
- approved dealers;
- active rebuilt inventory;
- percentage of listings with complete evidence;
- private seller inventory meeting trust requirements.

### Demand
- active Private Buyer profiles;
- percentage of complete Vehicle Buying Profiles;
- buyer match rate;
- matched inquiry rate;
- buyer alert response rate;
- qualified-opportunity rate.

### Conversion
- AI first-response time;
- lead capture rate;
- appointment rate;
- finance application rate;
- warranty attachment rate;
- match-to-sale conversion;
- listing-to-sale conversion;
- days-to-sale versus baseline;
- stale-lead reactivation rate.

### Trust & Operations
- AI response QA / correction rate;
- percentage of approved knowledge with valid provenance;
- dispute rate;
- repeat dealer usage;
- buyer trust / satisfaction score.

## 15. Product Principle

RebuiltTrustVehicle should win by making the transaction more transparent, not by trying to make rebuilt history disappear.

Its marketplace should organize both verified supply and structured buyer demand.

Its AI should not merely remember conversations. It should interpret the right context for the current task, execute within explicit boundaries, verify consequential outputs, explain material matches, and convert approved learning into durable institutional knowledge.
