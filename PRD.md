# Audi Digital Intelligence Audit
## Project Requirements Document
### Version 1.0 — In Progress

---

**Author:** Sara Cruz
**Status:** In Progress
**Date:** June 2026
**Repository:** [TODO: add GitHub URL when published]
**Intended audience:** Portfolio; Digital Analyst hiring managers in automotive digital platforms

---

## Version History

| Version | Status | What changed |
|---------|--------|-------------|
| v1.0 | In Progress | Initial setup — structure copied from BMW project; Audi-specific content pending |

---

## What This Project Is — And Is Not

This project is a **competitive digital intelligence audit** of Audi's publicly observable digital presence, benchmarked against verified industry data and demonstrated with executed SQL analysis.

It is **not** an analysis of Audi's internal analytics. No one outside Audi has access to their GA4 or Adobe Analytics backend. Any project claiming otherwise is fabricating data.

What this project does instead is more honest and more useful as a portfolio demonstration: it shows how a skilled analyst extracts signal from publicly available sources, constructs a rigorous measurement framework, executes real SQL queries, and produces actionable insight — without needing privileged access.

---

## What Will Be Built

### Repository structure — planned

```
audi-digital-audit/
├── README.md
├── PRD.md
├── data-sources.md
├── framework/
│   ├── kpi-framework.md              ← copied from BMW project (brand-agnostic)
│   ├── event-taxonomy.md             ← copied from BMW project (brand-agnostic)
│   └── funnel-model-audi.md          ← requires UI observation of audi.com
├── analysis/
│   ├── competitive-signals.md        ← requires SimilarWeb/Semrush pull
│   ├── benchmark-context.md          ← copied from BMW project (brand-agnostic)
│   └── insight-brief-audi.md         ← requires data collection above
├── sql/
│   ├── A-multi-session-path.sql      ← copied from BMW project (dataset-agnostic)
│   ├── B-funnel-dropoff.sql          ← copied from BMW project (dataset-agnostic)
│   ├── C-device-channel-interaction.sql  ← copied from BMW project (dataset-agnostic)
│   └── D-return-visitor-lift.sql     ← copied from BMW project (dataset-agnostic)
├── dashboard/
│   └── looker-studio-link.md         ← pending dashboard build
└── outputs/
    └── query-results/
        ├── A-results.csv             ← to be generated
        ├── B-results.csv             ← to be generated
        ├── C-results.csv             ← to be generated
        └── D-results.csv             ← to be generated
```

---

## Data Sources

Every data point in this project must come from a named, verifiable source.

| Source | What it provides | Reliability | Access |
|--------|-----------------|-------------|--------|
| Google BigQuery GA4 public dataset | Executed SQL analysis — methodology demonstration only | Real data, wrong domain | Free via BigQuery sandbox |
| Audi AG / Volkswagen Group Annual Report 2024 | Global deliveries, BEV share, digital strategy commitments | High — audited | [TODO: add URL] |
| Audi press statements | Digital sales strategy, configurator investment, online purchase rollout | Primary source; PR-framed | [TODO: add URL] |
| Cox Automotive 2024 Car Buyer Journey Study | 14+ hours online research before dealer contact; 1.4 dealer visits avg. | Published industry research | Publicly cited |
| Ruler Analytics 2026 | Automotive direct traffic conversion: 9.8% | Published benchmark | ruleranalytics.com |
| Demand Local / WordStream 2024 | Automotive website CVR: 2–5% avg; top performers 8–16% | Published benchmarks | demandlocal.com |
| SimilarWeb / Semrush free tier | audi.com / audiusa.com channel split, bounce rate, device split | Estimated ±20–30% | similarweb.com; semrush.com |

**Transparency rule:** every number must be labelled with its source and confidence level throughout all project files.

---

## Deliverable 1 — Measurement Framework

### Purpose
Define what a Digital Analyst would measure on audi.com with full GA4 access. Solution design thinking before any data is touched.

### KPI Framework
Copied from BMW project — Tier 1/2/3 structure is brand-agnostic. See `framework/kpi-framework.md`.

### Event Taxonomy
Copied from BMW project — standard GA4 events are brand-agnostic. See `framework/event-taxonomy.md`.

### Audi Customer Journey (to be mapped)

The funnel stages below are provisional — based on standard automotive digital architecture. Direct UI observation of audi.com required to confirm URLs, CTA labels, step count, and cross-domain behaviour.

```
Stage 0 — Entry
  URL: audi.com / audiusa.com homepage
  Business question: Which channels bring high-intent visitors?

Stage 1 — Model Discovery
  Pages: model overview / model range pages
  Business question: Which models attract the most research interest?

Stage 2 — Configurator
  Steps: [TODO: count from UI observation]
  Cross-domain: [TODO: confirm subdomain behaviour]
  Business question: At which step does the largest drop-off occur?

Stage 3 — Configurator Summary
  CTAs: [TODO: document from UI observation]
  Business question: What are the available lead paths?

Stage 4 — Lead Action
  Forms: [TODO: document mandatory fields]
  Business question: What is the form completion rate?
```

---

## Deliverable 2 — Competitive Signal Analysis

### Status: Pending

Requires:
- SimilarWeb data pull for audi.com and audiusa.com (~30 minutes)
- Semrush data pull for audiusa.com organic and channel data (~30 minutes)
- Audi AG / Volkswagen Group Annual Report 2024 review (~1 hour)

See `analysis/competitive-signals.md`.

---

## Deliverable 3 — SQL Analysis

### Dataset
**Source:** `bigquery-public-data.ga4_obfuscated_sample_ecommerce`  
**Proxy note:** Google Merchandise Store data — not Audi. Methodology demonstration only.

All four SQL queries copied from BMW project. Queries are dataset-agnostic. Execute in BigQuery sandbox and save results to `outputs/query-results/`.

| Query | File | Status |
|-------|------|--------|
| A — Multi-session path | `sql/A-multi-session-path.sql` | Pending execution |
| B — Funnel drop-off | `sql/B-funnel-dropoff.sql` | Pending execution |
| C — Device × channel | `sql/C-device-channel-interaction.sql` | Pending execution |
| D — Return visitor lift | `sql/D-return-visitor-lift.sql` | Pending execution |

---

## Deliverable 4 — Dashboard

**Tool:** Looker Studio  
**Status:** Pending — to be built after SQL queries executed  
**Design:** Same 4-panel structure as BMW dashboard; Audi red (#BB0A21) as accent colour

---

## Project Status

| Component | Status |
|-----------|--------|
| Repository structure | ✅ Complete |
| Measurement framework (KPI + taxonomy) | ✅ Complete (copied from BMW) |
| Audi funnel observation | ⏳ Pending |
| SimilarWeb/Semrush data pull | ⏳ Pending |
| Annual report review | ⏳ Pending |
| Competitive signals analysis | ⏳ Pending |
| SQL queries (all 4) | ⏳ Pending execution |
| Query results (all 4 CSVs) | ⏳ Pending |
| Insight brief | ⏳ Pending |
| Looker Studio dashboard | ⏳ Pending |
| GitHub repository | ⏳ Pending |

---

## Reproducibility — What Transferred From BMW

**Reused without changes:**
- KPI framework (Tier 1/2/3)
- Event taxonomy (standard GA4)
- All four SQL queries
- Insight brief structure (Know / Suggests / Test / Need)
- Dashboard panel structure (label and colour changes only)

**Audi-specific work remaining:**
- Funnel stage mapping from UI observation (~1 hour)
- SimilarWeb/Semrush data pull (~30 minutes)
- Annual report and press statement research (~1 hour)
- Insight brief and product hypotheses (~1 hour)

**Estimated remaining time:** 3–4 hours.

---

*Version 1.0 — In Progress. All SQL outputs to be sourced from Google's publicly available GA4 sample dataset. All competitive intelligence to be sourced from SimilarWeb, Semrush, and published industry reports, labelled as estimated. No proprietary Audi data was used or accessed.*
