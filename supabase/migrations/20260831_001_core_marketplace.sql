create extension if not exists pgcrypto;

create type public.organization_type as enum ('platform', 'dealer', 'finance_partner', 'warranty_partner', 'inspection_partner');
create type public.seller_type as enum ('authorized_dealer', 'private_seller');
create type public.listing_status as enum ('draft', 'review', 'published', 'reserved', 'sold', 'withdrawn');
create type public.match_status as enum ('new', 'notified', 'engaged', 'qualified', 'dismissed', 'converted');

create table public.users (
  id uuid primary key default gen_random_uuid(),
  clerk_user_id text not null unique,
  email text,
  display_name text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.organizations (
  id uuid primary key default gen_random_uuid(),
  type public.organization_type not null,
  name text not null,
  slug text not null unique,
  verification_status text not null default 'pending',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.organization_members (
  organization_id uuid not null references public.organizations(id) on delete cascade,
  user_id uuid not null references public.users(id) on delete cascade,
  role text not null,
  created_at timestamptz not null default now(),
  primary key (organization_id, user_id)
);

create table public.seller_profiles (
  id uuid primary key default gen_random_uuid(),
  seller_type public.seller_type not null,
  organization_id uuid references public.organizations(id) on delete cascade,
  user_id uuid references public.users(id) on delete cascade,
  verification_status text not null default 'pending',
  listing_limit integer,
  created_at timestamptz not null default now(),
  constraint seller_owner check (organization_id is not null or user_id is not null)
);

create table public.vehicles (
  id uuid primary key default gen_random_uuid(),
  vin text not null unique,
  year integer not null,
  make text not null,
  model text not null,
  trim text,
  odometer_km integer,
  rebuilt_status text not null default 'rebuilt',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.listings (
  id uuid primary key default gen_random_uuid(),
  vehicle_id uuid not null references public.vehicles(id) on delete cascade,
  seller_profile_id uuid not null references public.seller_profiles(id),
  status public.listing_status not null default 'draft',
  price_cad numeric(12,2) not null,
  title text,
  description text,
  trust_status text not null default 'incomplete',
  warranty_status text not null default 'not_checked',
  financing_status text not null default 'available_to_request',
  published_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.vehicle_evidence (
  id uuid primary key default gen_random_uuid(),
  vehicle_id uuid not null references public.vehicles(id) on delete cascade,
  evidence_type text not null,
  source_type text not null,
  source_name text,
  storage_path text,
  verification_status text not null default 'unverified',
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create table public.buyer_profiles (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  name text not null default 'My vehicle search',
  active boolean not null default true,
  makes text[] not null default '{}',
  models text[] not null default '{}',
  year_min integer,
  year_max integer,
  max_price_cad numeric(12,2),
  target_payment_cad numeric(10,2),
  down_payment_cad numeric(12,2),
  max_odometer_km integer,
  financing_required boolean not null default false,
  warranty_required boolean not null default false,
  ev_preference boolean,
  geographic_area text,
  purchase_timeframe text,
  required_features text[] not null default '{}',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.matches (
  id uuid primary key default gen_random_uuid(),
  buyer_profile_id uuid not null references public.buyer_profiles(id) on delete cascade,
  listing_id uuid not null references public.listings(id) on delete cascade,
  score numeric(5,2) not null default 0,
  reasons jsonb not null default '[]'::jsonb,
  status public.match_status not null default 'new',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (buyer_profile_id, listing_id)
);

create table public.inquiries (
  id uuid primary key default gen_random_uuid(),
  buyer_user_id uuid not null references public.users(id),
  listing_id uuid not null references public.listings(id),
  match_id uuid references public.matches(id),
  status text not null default 'new',
  source text not null default 'marketplace',
  assigned_organization_id uuid references public.organizations(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index listings_status_idx on public.listings(status);
create index listings_vehicle_idx on public.listings(vehicle_id);
create index buyer_profiles_user_idx on public.buyer_profiles(user_id);
create index matches_buyer_idx on public.matches(buyer_profile_id, status);
create index matches_listing_idx on public.matches(listing_id, status);
create index inquiries_assigned_org_idx on public.inquiries(assigned_organization_id, status);

alter table public.users enable row level security;
alter table public.organizations enable row level security;
alter table public.organization_members enable row level security;
alter table public.seller_profiles enable row level security;
alter table public.vehicles enable row level security;
alter table public.listings enable row level security;
alter table public.vehicle_evidence enable row level security;
alter table public.buyer_profiles enable row level security;
alter table public.matches enable row level security;
alter table public.inquiries enable row level security;

comment on table public.buyer_profiles is 'Structured Private Buyer Network demand used for explainable inventory matching.';
comment on table public.matches is 'Auditable buyer-to-listing matches; reasons must remain explainable rather than opaque.';
