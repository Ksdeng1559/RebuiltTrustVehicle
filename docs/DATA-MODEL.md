# Core Data Model

## Primary Entities

### User
Identity, role memberships, contact details, verification status, consent state, and communication preferences.

### Organization
Dealer, warranty partner, finance partner, inspection partner, rebuild/EV specialist, or platform organization.

### SellerProfile
Seller type, verification status, licensing/identity evidence, ownership evidence, and transaction limits where applicable.

### BuyerProfile
Buyer account, location, verification state where required, purchase timeframe, financing preference, warranty preference, trade-in indicator, communication consent, and profile status.

### BuyerVehiclePreference
Structured demand record linked to a BuyerProfile, including preferred make, model, year range, price ceiling, target payment, down payment, financing requirement, warranty requirement, EV preference, mileage, geography, features, and other explicitly supplied constraints.

### Vehicle
VIN, year, make, model, trim, odometer, status, normalized identifiers.

### VehicleEvidence
Document/photo/evidence record with type, source, provenance, issue date, uploader, verification status, and storage reference.

### Listing
Vehicle, seller, price, description, publication state, trust status, warranty state, financing state.

### VehicleMatch
BuyerVehiclePreference, vehicle/listing, match score/status, matched criteria, unmet criteria, source of match, created timestamp, notification state, dealer routing state, and human/AI disposition.

Match records must preserve the distinction between explicitly stated buyer requirements and AI-inferred preferences.

### Disclosure
Material seller or platform disclosure, source, acknowledgement requirements, timestamps.

### Inspection
Inspection type, provider, date, outcome/summary, evidence references.

### SpecialistAssessment
Vehicle, specialist/provider, assessment type, date, scope, findings, evidence references, verification/provenance state. May include EV, battery, high-voltage, structural, calibration, mechanical, or rebuild-specific assessments.

### WarrantyCase
Vehicle, provider, eligibility status, quote status, plan, term, deductible, issued contract reference.

### FinanceApplication
Buyer, vehicle, seller, partner, consent, application status, partner reference, funding state.

### Inquiry
Buyer-to-seller lead and communication state, source channel, related vehicle or buyer demand profile, qualification status, and assigned dealer/operator.

### Conversation
Channel, participants, linked buyer, linked vehicle/listing, AI/human ownership state, consent, summary, and CRM reference.

### Appointment
Buyer, dealer, vehicle, appointment type, date/time, location, status, source, and assigned staff.

### Transaction
Vehicle, buyer, seller, agreed price, warranty reference, finance reference, key dates.

### AuditEvent
Actor, event type, entity, timestamp, prior/new state metadata, source.

## Data Relationships

BuyerProfile → one or more BuyerVehiclePreferences → zero or more VehicleMatches → Listing/Vehicle → Inquiry/Appointment → FinanceApplication/WarrantyCase → Transaction.

SellerProfile → Listing → Vehicle → VehicleEvidence/Inspection/SpecialistAssessment → Transaction.

## Data Principles

- VIN is a core normalized key but not the only database key.
- Buyer demand is first-class platform data, not merely free-text lead notes.
- Explicit buyer requirements and AI-inferred preferences must remain distinguishable.
- Verified facts and seller assertions are stored separately or clearly tagged.
- Documents are immutable where practical; newer evidence supersedes rather than silently overwrites historical evidence.
- Sensitive applicant information is separated from public marketplace data.
- Provider decisions remain attributable to the provider.
- Matching logic should be auditable enough to explain why a buyer and vehicle were matched.
- Consent and communication preferences must travel with buyer engagement workflows.
