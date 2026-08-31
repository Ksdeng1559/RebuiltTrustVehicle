# Warranty Strategy

## Current Direction

Lubrico Warranty is the preferred warranty partner direction for RebuiltTrustVehicle, subject to actual product availability and written confirmation that the specific rebuilt-status vehicle and VIN are eligible.

## Platform Rule

The platform must separate four concepts:

1. **Provider supports the market/category**
2. **Vehicle appears eligible**
3. **Formal quote/approval has been issued**
4. **Coverage contract is active**

Only the fourth state represents actual coverage.

## Required Warranty Data

- VIN
- year / make / model / trim
- odometer
- rebuilt/branded status
- dealer/seller
- sale date
- purchase price where required
- plan
- term
- deductible
- covered components
- exclusions
- provider confirmation/reference

## Buyer UX

Vehicle pages should display a clear warranty status badge such as:
- Eligibility not checked
- Eligibility pending
- Eligible — quote available
- Not eligible
- Warranty selected
- Coverage issued

Do not use a generic "Warranty Included" badge unless an actual issued contract is tied to the vehicle transaction.

## Claims Experience

Long term, the platform should store warranty contract metadata and claims references so the vehicle trust record can show service continuity without exposing sensitive claims information publicly.

## Provider Redundancy

The architecture should support multiple warranty providers in future. Lubrico should be implemented through an abstraction layer rather than hard-coded throughout the product.
