# System Architecture

## Design Goals

- Multi-tenant dealer support
- Strong role-based access
- VIN-centric data model
- Secure document storage
- Clear separation of source data, derived trust status, and partner decisions
- Replaceable warranty and financing providers
- Auditability
- Railway/Vercel deployment compatibility

## Proposed Stack

### Frontend
Vite + React.

### Authentication
Clerk or equivalent multi-tenant identity provider.

### Application/API Layer
Node/TypeScript service layer deployed to Railway or compatible runtime.

### System of Record
Supabase/Postgres.

### Document Storage
Supabase Storage or compatible object storage.

### Analytics / Enrichment
DuckDB/MotherDuck may be used for analytical workloads, enrichment staging, and reporting. It should not replace the transactional system of record.

### AI Layer
OpenRouter or another model abstraction can support document extraction, classification, listing assistance, and internal operations. AI output must be provenance-aware and should not overwrite verified facts without review.

## Logical Architecture

User → Web App → Auth → API/Application Services → Postgres/System of Record

Application services connect to:
- document storage;
- warranty adapter;
- financing adapter;
- VIN/data providers;
- notification services;
- analytics/enrichment layer;
- admin/audit services.

## Multi-Tenancy

Organizations represent dealers or partner entities. Every dealer-owned record must carry an organization identifier and authorization must be enforced server-side.

## Integration Pattern

Use provider adapters:
- WarrantyProvider
- FinanceProvider
- VehicleDataProvider
- InspectionProvider
- NotificationProvider

This avoids hard-coding Lubrico or any single finance partner into core product logic.

## Auditability

Material changes should create immutable audit events containing actor, timestamp, entity, prior state where appropriate, new state, and source.
