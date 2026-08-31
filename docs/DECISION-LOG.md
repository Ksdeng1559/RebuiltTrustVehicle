# Decision Log

## 2026-08-30 — Primary Market
Initial launch market is British Columbia, Canada, focused on rebuilt-status vehicles.

## 2026-08-30 — Seller Model
Primary marketplace supply will come from authorized used-car dealers. A separate Private Seller Network will support limited small-volume participation under stricter verification and listing controls.

## 2026-08-30 — Warranty Direction
Lubrico Warranty is the preferred current warranty direction, subject to VIN-specific eligibility and contract confirmation.

## 2026-08-30 — Financing
Vehicle financing is a core transaction component rather than an optional future add-on.

## 2026-08-30 — Trust Strategy
The platform will use evidence completeness, provenance, and verification status rather than presenting an unsupported mechanical reliability score.

## 2026-08-30 — Risk Strategy
Third-party warranty coverage is preferred for MVP. Any self-funded repair reserve/protection program remains a later research initiative requiring legal, regulatory, actuarial, tax, and claims-administration validation.

## 2026-08-30 — Technical Direction
Vite + React is the frontend direction. The architecture should remain compatible with Railway and/or Vercel deployment, use a transactional system of record such as Supabase/Postgres, and support provider abstraction for warranty and financing integrations.

## 2026-08-31 — Private Buyer Network
Private buyers are now a distinct marketplace category, separate from the Private Seller Network. The intended buyer segment is consumers seeking rebuilt vehicles for personal use, including newer/late-model vehicles, premium vehicles, EVs, and rebuilt Teslas.

Buyer intent will be represented as structured Vehicle Buying Profiles rather than only as free-text leads.

## 2026-08-31 — Two-Sided Marketplace Model
RebuiltTrustVehicle will organize both verified vehicle supply and structured buyer demand. The strategic flow expands from `vehicle listed → wait for buyer` to `buyer joins → defines desired vehicle → inventory is matched → dealer receives qualified opportunity`.

## 2026-08-31 — Buyer-to-Inventory Matching
A buyer-to-inventory matching engine is now a core product module. Matching must distinguish explicit buyer requirements, optional preferences, AI-inferred signals, and hard mismatches. Match outcomes should be explainable and auditable.

## 2026-08-31 — Specialist Network
Rebuild, inspection, Tesla/EV and other technical specialists are treated as part of the trust partner network. Their findings remain attributable to the provider and must not be presented as platform-certified facts unless separately verified under an approved process.

## How to Use This Log

Add dated entries when a material product, commercial, compliance, architecture, or partner decision changes. Do not silently rewrite prior decisions; record the new decision and why it supersedes or extends the old one.
