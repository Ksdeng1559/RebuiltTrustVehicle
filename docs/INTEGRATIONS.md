# Integrations

## Warranty

Primary current direction: Lubrico Warranty.

Integration should support eligibility requests, quotes, plan metadata, contract references, and status updates through a provider adapter.

## Financing

Support one or more lenders/brokers through a finance-provider adapter. The platform should transmit only authorized applicant and vehicle data.

## Vehicle Data

Future vehicle-data integrations may support VIN decoding, history lookups, valuation, recalls, or other authoritative/third-party data.

## Inspection / Repair Evidence

Where APIs are unavailable, evidence can enter through structured uploads with source, provider identity, and verification status.

## Notifications

Email/SMS notifications for seller approval, listing review, buyer leads, finance status, warranty status, and transaction milestones.

## Analytics

Operational data remains in the system of record. MotherDuck/DuckDB can support reporting, cohort analysis, risk modelling, and enrichment workflows.

## Integration Principle

External providers are systems of authority for their own decisions. RebuiltTrustVehicle stores the decision, reference, timestamp, and evidence but does not silently reinterpret a provider decline into an approval.
