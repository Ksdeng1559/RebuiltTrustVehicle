# Product Requirements Document — RebuiltTrustVehicle

## 1. Executive Summary

RebuiltTrustVehicle is a BC-focused marketplace and transaction platform for rebuilt-status vehicles. The platform addresses the central market failure in rebuilt vehicles: buyers often face incomplete history, inconsistent disclosure, limited warranty availability, financing friction, and uncertainty about the quality of repairs.

The platform increases trust by standardizing evidence, restricting seller access, integrating warranty and financing pathways, and creating a persistent vehicle trust record tied to the VIN.

## 2. Problem

Rebuilt vehicles can represent strong value, but the market is fragmented and trust-deficient.

Key buyer concerns include:
- unclear prior damage and repair history;
- inconsistent disclosure;
- uncertainty regarding inspections;
- limited warranty options;
- financing difficulty;
- uncertainty about resale value;
- concern that future mechanical failure may be related to prior damage.

Key seller concerns include:
- lower buyer confidence;
- longer days-to-sale;
- financing objections;
- difficulty differentiating professionally rebuilt inventory from poor-quality inventory;
- lack of a standardized trust framework.

## 3. Product Vision

Create the most trusted marketplace for rebuilt-status vehicles by converting rebuilt history from an information disadvantage into a transparent, evidence-backed vehicle record.

## 4. Target Market

### Initial geography
British Columbia, Canada.

### Primary supply
Authorized used-car dealers approved by the platform.

### Private Seller Network
Private sellers and small-volume participants may participate under stricter controls. The intended segment includes buyers or sellers handling no more than approximately five vehicles for personal use or later resale, subject to applicable law and licensing rules.

## 5. User Roles

- Platform Administrator
- Authorized Dealer
- Dealer Staff
- Private Seller
- Buyer
- Finance Partner
- Warranty Partner
- Inspection / Repair Evidence Provider
- Compliance / Review Operator

## 6. Core Product Modules

### 6.1 Dealer Verification
Dealers complete business identity, licensing, contact, banking/payment, and platform-policy verification before listing inventory.

### 6.2 VIN-Centric Vehicle Record
Each listing is anchored to a VIN and stores:
- vehicle identity;
- rebuilt status;
- seller;
- inspection evidence;
- repair disclosures;
- images and supporting documents;
- warranty eligibility/status;
- financing eligibility/status;
- listing history;
- transaction history where appropriate.

### 6.3 Listing Workflow
Sellers create a listing by entering the VIN first. The platform then guides them through required evidence, disclosures, condition information, pricing, and media.

A vehicle cannot receive a high-trust designation until required evidence is complete.

### 6.4 Trust Score / Trust Status
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
- disclosure completeness.

### 6.5 Warranty
Lubrico Warranty is the current preferred warranty direction, subject to written confirmation of eligibility for the specific rebuilt-status vehicle and VIN.

The platform must never imply warranty coverage until eligibility and contract terms are confirmed.

### 6.6 Vehicle Financing
The marketplace includes a financing workflow allowing a buyer to request financing from participating lenders or brokers.

The vehicle record should transmit relevant data to finance partners, including VIN, price, rebuilt status, seller, down payment, and applicant-authorized information.

### 6.7 Private Seller Network
The private channel is separated from the authorized-dealer channel in the UI and trust model.

Controls may include:
- identity verification;
- lower listing limits;
- additional documentation requirements;
- ownership verification;
- transaction-volume monitoring;
- explicit seller-type labeling.

### 6.8 Buyer Journey
Search → vehicle trust record → compare → warranty information → financing option → inquiry / reservation → due diligence → purchase documentation.

## 7. Trust Framework

The platform should distinguish between:

**Verified fact** — supported by a document or authoritative source.

**Seller disclosure** — supplied by seller and identified as such.

**Third-party assessment** — supplied by mechanic, inspector, warranty provider, lender, or other third party.

**Platform-derived status** — indicates evidence completeness or workflow status; it must not be represented as a guarantee of vehicle quality.

## 8. Business Model

Potential revenue streams:
- dealer subscriptions;
- listing fees;
- transaction fees;
- warranty referral/revenue share where permitted;
- financing referral/revenue share where permitted;
- inspection services;
- promoted listings;
- trust certification/document package fees;
- dealer software tools.

## 9. Warranty Reserve / Self-Funded Protection Research

A separate actuarial/risk workstream evaluates whether the platform could support a reserve-backed repair protection product or dealer-funded protection program.

This must remain separate from the MVP until legal, actuarial, insurance, tax, claims-administration, and regulatory requirements have been validated.

## 10. MVP Requirements

MVP must include:
- account authentication;
- role-based access;
- dealer approval workflow;
- private seller workflow;
- VIN-based listings;
- rebuilt-status disclosure;
- document uploads;
- vehicle photo gallery;
- search and filters;
- buyer inquiry;
- warranty eligibility workflow/status;
- financing lead/application handoff;
- admin review dashboard;
- audit log for material listing changes.

## 11. Non-Functional Requirements

- Mobile-first responsive UI
- Canadian privacy-conscious data handling
- Secure document storage
- Role-based authorization
- Auditability
- VIN uniqueness and normalization
- Clear disclosure provenance
- Scalable multi-tenant dealer structure
- API-ready architecture

## 12. Proposed Technical Direction

Frontend: Vite + React.

Hosting: Vercel for frontend or Railway where a unified deployment is preferred.

Application/backend services: Railway-compatible service layer.

Authentication / multi-tenant identity: Clerk is a candidate.

System of record: Supabase/Postgres.

Object/document storage: Supabase Storage or compatible object storage.

Analytics/enrichment: DuckDB/MotherDuck where useful.

AI/model routing, if introduced: OpenRouter or equivalent abstraction.

## 13. Compliance Principles

- Rebuilt status must be prominent.
- Material facts must not be hidden behind marketing language.
- Warranty status must identify eligibility versus actual issued coverage.
- Financing is subject to lender approval.
- Seller type must be clearly shown.
- Platform trust indicators must not be represented as government, ICBC, mechanical, or insurance certification unless actually issued by that party.

## 14. Success Metrics

- approved dealers;
- active rebuilt inventory;
- percentage of listings with complete evidence;
- buyer inquiry rate;
- finance application rate;
- warranty attachment rate;
- listing-to-sale conversion;
- days-to-sale versus baseline;
- dispute rate;
- repeat dealer usage;
- buyer trust / satisfaction score.

## 15. Product Principle

RebuiltTrustVehicle should win by making the transaction more transparent, not by trying to make the rebuilt history disappear.
