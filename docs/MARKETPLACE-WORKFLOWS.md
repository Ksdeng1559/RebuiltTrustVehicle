# Marketplace Workflows

## Dealer Listing

Dealer verified → VIN entered → vehicle identity created → rebuilt status confirmed/disclosed → repair/inspection evidence uploaded → media and pricing added → warranty eligibility requested → financing flags configured → admin/trust checks → listing published.

## Private Seller Listing

Identity verified → ownership evidence → VIN entered → rebuilt status confirmed/disclosed → required repair and inspection evidence → listing limits checked → admin review → listing published.

## Buyer Journey

Search → filter → open vehicle trust record → review rebuilt disclosure and evidence → compare vehicles → ask seller questions → request warranty details → begin financing if needed → arrange inspection/test drive → transaction documentation → purchase.

## Warranty Workflow

VIN + mileage + year/make/model + rebuilt status + seller information → eligibility request → provider response → eligible plan(s) displayed → buyer selects → coverage contract issued → contract reference stored on transaction.

Eligibility is not coverage. The UI must distinguish:
- not checked;
- checking;
- eligible;
- ineligible;
- quoted;
- purchased/issued;
- expired/cancelled.

## Financing Workflow

Buyer consent → applicant information → vehicle and seller data → lender/broker handoff → pending → conditional approval / decline / additional information → final approval → funding status.

## Material Change Workflow

Changes to VIN, rebuilt status, seller identity, major repair disclosure, inspection evidence, price, warranty status, or financing representation are recorded in an audit log.
