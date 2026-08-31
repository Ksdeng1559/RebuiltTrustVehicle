# Marketplace Workflows

## Authorized Dealer Listing

Dealer verified → VIN entered → vehicle identity created → rebuilt status confirmed/disclosed → repair/inspection evidence uploaded → specialist evidence added where applicable → media and pricing added → warranty eligibility requested → financing flags configured → admin/trust checks → listing published → buyer-match engine evaluates demand.

## Private Seller Listing

Identity verified → ownership evidence → VIN entered → rebuilt status confirmed/disclosed → required repair and inspection evidence → listing/transaction limits checked → admin review → listing published → buyer-match engine evaluates eligible demand.

## Private Buyer Onboarding

Account created → consent/preferences captured → buyer creates Vehicle Buying Profile → make/model/year/price/payment requirements entered → financing/warranty/EV/mileage/geography/features/timeframe captured → profile activated → matching engine evaluates current inventory → buyer receives relevant alerts and recommendations.

## Buyer-to-Inventory Matching

Active BuyerVehiclePreference → evaluate current and incoming dealer/private-seller inventory → apply hard constraints → rank compatible vehicles → create VehicleMatch → explain matched and unmet criteria → notify buyer when appropriate → route high-intent match to dealer/AI Sales Agent → create/update CRM opportunity → appointment/financing/warranty workflow.

The system must distinguish:
- explicit buyer requirements;
- optional preferences;
- AI-inferred signals;
- hard mismatches;
- human overrides.

## Private Buyer Journey

Join network → define desired vehicle → receive matching vehicles → open vehicle trust record → review rebuilt disclosure and evidence → compare → ask AI/seller questions → request warranty details → begin financing if needed → schedule inspection/test drive → due diligence → purchase.

A buyer may also browse normally without creating a demand profile.

## AI Sales Qualification Workflow

Inbound inquiry/DM/match → identify buyer and vehicle context → collect missing intent → determine financing/warranty/trade-in/timeframe → classify lead → recommend matching inventory → log structured CRM activity → schedule appointment or hand off to authorized dealer staff.

Consequential claims about warranty, financing approval, vehicle condition, inspection, or verified history must come from authoritative records or be escalated.

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

The platform must not represent a buyer as approved until the participating finance partner has actually issued that status.

## Specialist Verification Workflow

Vehicle identified → specialist scope selected → evidence/vehicle supplied → assessment completed → provider findings stored with provenance → relevant findings attached to Vehicle Trust Record → buyer/dealer may review → unresolved or material concerns escalated.

For rebuilt EVs/Teslas, specialist scope may include battery, high-voltage systems, charging, sensors, cameras, structural repair, calibration, driver-assistance systems, and software functionality where supported by the provider.

## Material Change Workflow

Changes to VIN, rebuilt status, seller identity, buyer consent, buyer hard requirements, major repair disclosure, inspection evidence, specialist evidence, price, warranty status, financing representation, or match disposition are recorded in an audit log.
