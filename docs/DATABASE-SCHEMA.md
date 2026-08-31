# Application Database Schema

## Purpose

This document defines the initial Postgres/Supabase schema required to implement the current RebuiltTrustVehicle PRD. It is a logical schema; exact SQL types, indexes and Row Level Security policies should be implemented in migrations.

## Identity and Organizations

### `users`
- `id`
- `clerk_user_id` unique
- `email`
- `phone`
- `display_name`
- `status`
- `created_at`
- `updated_at`

### `organizations`
- `id`
- `type` — platform, dealer, finance_partner, warranty_partner, specialist_partner
- `legal_name`
- `display_name`
- `status`
- `created_at`
- `updated_at`

### `organization_memberships`
- `id`
- `organization_id`
- `user_id`
- `role`
- `status`
- `created_at`

### `consents`
- `id`
- `user_id`
- `consent_type`
- `version`
- `granted_at`
- `revoked_at`
- `source`

## Dealer Network

### `dealer_profiles`
- `id`
- `organization_id` unique
- `licence_number`
- `verification_status`
- `approval_status`
- `approved_at`
- `approved_by`
- `policy_version`
- `created_at`
- `updated_at`

### `dealer_verification_evidence`
- `id`
- `dealer_profile_id`
- `evidence_type`
- `storage_object_id`
- `verification_status`
- `reviewed_by`
- `reviewed_at`

## Private Buyer Network

### `buyer_profiles`
- `id`
- `user_id` unique
- `verification_status`
- `home_region`
- `preferred_contact_channel`
- `marketing_opt_in`
- `created_at`
- `updated_at`

### `vehicle_buying_profiles`
A buyer may have multiple active demands.

- `id`
- `buyer_profile_id`
- `name`
- `status` — draft, active, paused, fulfilled, expired
- `make`
- `model`
- `year_min`
- `year_max`
- `price_max`
- `target_monthly_payment`
- `down_payment_amount`
- `financing_required`
- `warranty_required`
- `rebuilt_accepted`
- `ev_preference`
- `mileage_max`
- `drivetrain`
- `required_features` jsonb
- `preferred_features` jsonb
- `preferred_regions` jsonb
- `purchase_timeframe`
- `trade_in_intent`
- `notes`
- `created_at`
- `updated_at`

### `saved_searches`
- `id`
- `buyer_profile_id`
- `name`
- `query_json`
- `alerts_enabled`
- `created_at`

## Private Seller Network

### `private_seller_profiles`
- `id`
- `user_id` unique
- `identity_verification_status`
- `annual_listing_count`
- `review_status`
- `created_at`
- `updated_at`

### `ownership_evidence`
- `id`
- `private_seller_profile_id`
- `vehicle_id`
- `storage_object_id`
- `verification_status`
- `reviewed_at`

## Vehicle Registry and Trust Record

### `vehicles`
- `id`
- `vin` unique normalized
- `year`
- `make`
- `model`
- `trim`
- `odometer_km`
- `fuel_type`
- `drivetrain`
- `rebuilt_status`
- `province`
- `lifecycle_status`
- `created_at`
- `updated_at`

### `vehicle_evidence`
- `id`
- `vehicle_id`
- `evidence_type`
- `source_type` — seller, dealer, inspector, specialist, provider, platform
- `source_organization_id`
- `submitted_by_user_id`
- `storage_object_id`
- `visibility` — public, qualified_buyer, partner, admin
- `verification_status`
- `issue_date`
- `verified_at`
- `verified_by`
- `supersedes_evidence_id`
- `created_at`

### `vehicle_disclosures`
- `id`
- `vehicle_id`
- `disclosure_type`
- `statement`
- `source_type`
- `source_user_id`
- `source_organization_id`
- `verification_status`
- `created_at`

### `inspections`
- `id`
- `vehicle_id`
- `provider_organization_id`
- `inspection_type`
- `inspection_date`
- `status`
- `summary`
- `report_evidence_id`
- `created_at`

### `specialist_assessments`
- `id`
- `vehicle_id`
- `specialist_organization_id`
- `assessment_type`
- `status`
- `summary`
- `evidence_id`
- `created_at`

### `vehicle_trust_status`
- `vehicle_id` primary key
- `vin_verified`
- `rebuilt_status_disclosed`
- `inspection_present`
- `repair_evidence_present`
- `specialist_evidence_present`
- `seller_verified`
- `warranty_status`
- `financing_status`
- `evidence_completeness_score`
- `updated_at`

This table is a derived status/cache and must not overwrite source evidence.

## Listings

### `listings`
- `id`
- `vehicle_id`
- `seller_type` — dealer, private_seller
- `dealer_organization_id` nullable
- `private_seller_profile_id` nullable
- `price`
- `currency`
- `description`
- `region`
- `publication_status`
- `published_at`
- `sold_at`
- `warranty_display_status`
- `financing_display_status`
- `created_at`
- `updated_at`

### `listing_media`
- `id`
- `listing_id`
- `storage_object_id`
- `media_type`
- `sort_order`
- `created_at`

## Matching and Demand

### `vehicle_matches`
- `id`
- `vehicle_buying_profile_id`
- `listing_id`
- `score`
- `hard_filters_passed`
- `matched_criteria` jsonb
- `unmet_preferences` jsonb
- `reason_summary`
- `status` — generated, notified, viewed, interested, rejected, converted, expired
- `generated_at`
- `notified_at`
- `buyer_response_at`

Unique constraint should prevent duplicate active matches for the same demand/listing pair.

### `match_feedback`
- `id`
- `vehicle_match_id`
- `buyer_profile_id`
- `feedback_type`
- `feedback_text`
- `created_at`

## CRM and Conversations

### `inquiries`
- `id`
- `buyer_profile_id`
- `listing_id`
- `vehicle_match_id` nullable
- `source_channel`
- `status`
- `assigned_dealer_organization_id`
- `created_at`

### `opportunities`
- `id`
- `inquiry_id`
- `buyer_profile_id`
- `listing_id`
- `dealer_organization_id`
- `stage`
- `qualification_status`
- `financing_interest`
- `warranty_interest`
- `trade_in_intent`
- `next_action_at`
- `created_at`
- `updated_at`

### `conversations`
- `id`
- `buyer_profile_id`
- `listing_id` nullable
- `opportunity_id` nullable
- `channel`
- `external_thread_id`
- `status`
- `created_at`

### `messages`
- `id`
- `conversation_id`
- `sender_type` — buyer, human_agent, ai_agent, dealer, system
- `sender_id`
- `body`
- `source_message_id`
- `created_at`

### `appointments`
- `id`
- `opportunity_id`
- `appointment_type`
- `scheduled_at`
- `location`
- `status`
- `created_at`

## Financing

### `finance_applications`
- `id`
- `buyer_profile_id`
- `listing_id`
- `dealer_organization_id`
- `finance_partner_organization_id`
- `consent_id`
- `status`
- `external_reference`
- `submitted_at`
- `updated_at`

Sensitive applicant financial fields should live in restricted tables or partner systems rather than public-domain tables.

### `finance_status_events`
- `id`
- `finance_application_id`
- `status`
- `provider_message`
- `occurred_at`

## Warranty

### `warranty_cases`
- `id`
- `vehicle_id`
- `listing_id`
- `buyer_profile_id` nullable
- `warranty_partner_organization_id`
- `provider_name`
- `eligibility_status`
- `quote_status`
- `plan_name`
- `term_months`
- `deductible`
- `contract_reference`
- `issued_at`
- `updated_at`

### `warranty_status_events`
- `id`
- `warranty_case_id`
- `status`
- `provider_message`
- `occurred_at`

## Transactions

### `transactions`
- `id`
- `listing_id`
- `vehicle_id`
- `buyer_profile_id`
- `seller_type`
- `seller_organization_id` nullable
- `private_seller_profile_id` nullable
- `agreed_price`
- `finance_application_id` nullable
- `warranty_case_id` nullable
- `status`
- `reserved_at`
- `completed_at`
- `created_at`

## AI, Context and Audit

### `agent_runs`
- `id`
- `agent_type`
- `user_id` nullable
- `buyer_profile_id` nullable
- `listing_id` nullable
- `opportunity_id` nullable
- `context_contract_version`
- `model_provider`
- `model_name`
- `status`
- `confidence`
- `human_handoff_required`
- `created_at`
- `completed_at`

### `agent_artifacts`
- `id`
- `agent_run_id`
- `artifact_type`
- `payload` jsonb
- `created_at`

### `audit_events`
- `id`
- `actor_type`
- `actor_id`
- `event_type`
- `entity_type`
- `entity_id`
- `before_state` jsonb
- `after_state` jsonb
- `source`
- `occurred_at`

## Notification Layer

### `notifications`
- `id`
- `user_id`
- `notification_type`
- `channel`
- `entity_type`
- `entity_id`
- `status`
- `scheduled_at`
- `sent_at`
- `created_at`

## Storage Metadata

### `storage_objects`
- `id`
- `bucket`
- `object_path`
- `mime_type`
- `size_bytes`
- `checksum`
- `visibility`
- `uploaded_by`
- `created_at`

## Initial Index Priorities

- unique normalized `vehicles.vin`
- listings by `publication_status`, `region`, `price`, `vehicle_id`
- buying profiles by `status`, `make`, `model`, `price_max`, `year_min`, `year_max`
- matches by buyer demand, listing and status
- opportunities by dealer, stage and next action
- conversations by external thread ID
- audit events by entity type/entity ID/time

## Row Level Security Strategy

RLS policies should be designed around these access scopes:

- public marketplace;
- authenticated buyer-owned data;
- private seller-owned data;
- dealer organization data;
- partner case-scoped data;
- platform admin/compliance data.

Do not rely on frontend role checks for data security.