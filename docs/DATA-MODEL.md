# Core Data Model

## Primary Entities

### User
Identity, role memberships, contact details, verification status.

### Organization
Dealer, warranty partner, finance partner, inspection partner, or platform organization.

### SellerProfile
Seller type, verification status, licensing/identity evidence, transaction limits where applicable.

### Vehicle
VIN, year, make, model, trim, odometer, status, normalized identifiers.

### VehicleEvidence
Document/photo/evidence record with type, source, provenance, issue date, uploader, verification status, and storage reference.

### Listing
Vehicle, seller, price, description, publication state, trust status, warranty state, financing state.

### Disclosure
Material seller or platform disclosure, source, acknowledgement requirements, timestamps.

### Inspection
Inspection type, provider, date, outcome/summary, evidence references.

### WarrantyCase
Vehicle, provider, eligibility status, quote status, plan, term, deductible, issued contract reference.

### FinanceApplication
Buyer, vehicle, seller, partner, consent, application status, partner reference, funding state.

### Inquiry
Buyer-to-seller lead and communication state.

### Transaction
Vehicle, buyer, seller, agreed price, warranty reference, finance reference, key dates.

### AuditEvent
Actor, event type, entity, timestamp, prior/new state metadata, source.

## Data Principles

- VIN is a core normalized key but not the only database key.
- Verified facts and seller assertions are stored separately or clearly tagged.
- Documents are immutable where practical; newer evidence supersedes rather than silently overwrites historical evidence.
- Sensitive applicant information is separated from public marketplace data.
- Provider decisions remain attributable to the provider.
