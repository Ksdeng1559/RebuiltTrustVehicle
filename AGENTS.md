# AGENTS.md — RebuiltTrustVehicle

This repository is designed to be worked on by coding agents such as Claude Code, Codex, and similar tools.

## Source of Truth
Read `CLAUDE.md` first. It contains the implementation order, architecture constraints, domain rules, RLS requirements, testing priorities and definition of done.

Then consult:
- `docs/PRD.md`
- `docs/IMPLEMENTATION-BLUEPRINT.md`
- `docs/DATABASE-SCHEMA.md`
- `docs/API-ROADMAP.md`
- `docs/BUILD-ROADMAP.md`
- `docs/DECISION-LOG.md`

If documentation conflicts, the newest dated entry in `docs/DECISION-LOG.md` wins.

## Agent Goal
Implement the smallest complete slice of the north-star workflow:

`Dealer inventory -> VIN trust record -> Private Buyer demand -> explainable match -> inquiry/opportunity -> financing/warranty -> appointment -> transaction`

## Guardrails
- Keep Supabase/Postgres as the transactional source of truth.
- Keep Private Buyer and Private Seller as separate roles/domains.
- Keep matching deterministic and explainable until outcome data supports ML.
- Preserve provenance: verified facts, seller claims, partner assessments, platform status and AI interpretation are distinct.
- Enforce server-side authorization and RLS.
- Never expose secrets or Supabase service-role credentials to the browser.
- Do not claim warranty coverage or financing approval unless confirmed by the provider workflow.
- Keep the architecture as a modular monolith unless there is evidence a service must be separated.

## Completion Contract
Every implementation should include appropriate code, validation, authorization, migrations, RLS consideration, tests, error states and documentation updates.