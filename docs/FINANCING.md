# Financing Strategy

## Objective

Reduce one of the largest points of friction in rebuilt-vehicle transactions: lender uncertainty and buyer difficulty obtaining financing.

## Model

RebuiltTrustVehicle acts as the structured intake and referral layer. Participating finance partners decide eligibility, pricing, approval, and funding.

## Vehicle Data Package

The financing workflow should be able to send, with appropriate authorization:
- VIN;
- year / make / model;
- rebuilt status;
- odometer;
- purchase price;
- dealer/seller identity;
- warranty status;
- down payment;
- relevant trust/evidence documents where accepted by the lender.

## Applicant Workflow

Vehicle selected → financing requested → consent → applicant data → vehicle data attached automatically → partner routing → status updates → approval conditions → funding.

## Status Model

- Not requested
- Application started
- Submitted
- Additional information required
- Conditionally approved
- Approved
- Declined
- Funded

## Product Principle

The platform should never imply that a rebuilt vehicle is financeable solely because it appears on RebuiltTrustVehicle. All financing remains subject to participating lender or broker underwriting.

## Long-Term Opportunity

As transaction data accumulates, the platform may create a lender-ready rebuilt vehicle data package that reduces manual underwriting friction and increases the number of lenders willing to assess the category.
