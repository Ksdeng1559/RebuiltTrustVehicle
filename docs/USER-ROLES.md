# User Roles & Access Model

## Platform Administrator
Full operational access to approve sellers, review listings, manage trust evidence, oversee buyer-demand workflows, view audit logs, and administer platform policies.

## Authorized Dealer
Can manage dealership profile, staff, inventory, vehicle documentation, warranty workflow, financing workflow, matched buyer opportunities, leads, appointments, and transaction status.

## Dealer Staff
Scoped access delegated by the dealership. Permissions should be configurable by dealership administrators.

## Private Buyer
A consumer who joins the platform primarily to purchase a rebuilt-status vehicle for personal use.

Private Buyers can:
- search and save listings;
- create a structured Vehicle Buying Profile;
- specify make/model/year/price/payment preferences;
- state financing, warranty, EV, mileage, geography, feature, and timing preferences;
- receive AI-generated vehicle matches and alerts;
- request financing or warranty information;
- submit inquiries and schedule appointments;
- access documents shared for due diligence;
- update or pause their buyer profile and communication preferences.

Buyer preferences must distinguish explicitly supplied facts from AI-inferred signals.

## Private Seller
Can create a limited number of listings, upload ownership and vehicle evidence, communicate with qualified buyers, and complete required disclosures. Private sellers receive stricter listing, verification, volume, and transaction controls than authorized dealers.

Private Seller and Private Buyer are separate marketplace roles, although one individual may hold both roles where permitted.

## Finance Partner
Receives authorized finance applications and vehicle data required for underwriting. Access is limited to relevant transactions and consented applicant information.

## Warranty Partner
Receives VIN and vehicle information necessary to determine eligibility and issue coverage. Warranty partners do not receive unrelated buyer data.

## Inspector / Evidence Provider
May submit or validate inspection documents and related evidence where a verified provider workflow is implemented.

## Rebuild / EV Specialist
May provide specialist evidence, inspection findings, repair context, EV/battery/high-voltage assessments, or other technical records. Specialist statements remain attributable to the provider and are not converted into platform-certified facts unless independently verified under an approved process.

## AI Buyer Concierge
Customer-facing assistant that answers vehicle and marketplace questions from approved records, collects buyer intent, and routes consequential or uncertain matters to humans.

## AI Sales Agent
Internal sales agent that qualifies buyer demand, recommends inventory, triggers matching workflows, follows up leads, and updates CRM activity within governed permissions.

## AI DM Response Agent
Responds to inbound messages from approved channels, identifies vehicle context, collects buyer intent, qualifies the opportunity, and transfers structured lead data to the CRM or human team.

## Principle of Least Privilege
Every account and agent should have access only to the organizations, vehicles, buyer profiles, transactions, personal information, and tools necessary for its role.
