# Data Sources

Every data point in this project comes from a named, verifiable source. This document is the authoritative citation list for the Audi Digital Intelligence Audit.

---

## Source Registry

| # | Source | What it provides | URL | Confidence | Access notes |
|---|--------|-----------------|-----|------------|-------------|
| 1 | SimilarWeb (free tier) | audi.pt monthly visits, channel mix, bounce rate, device split, pages/visit | similarweb.com | Estimated | Free account required; [TODO: record data access date] |
| 2 | Semrush (free tier) | audi.pt organic keywords, top landing pages, estimated traffic by page, competitor comparison | semrush.com | Estimated | Free account; 10 queries/day limit on free tier |
| 3 | Audi AG / Volkswagen Group Annual Report 2024 | Global deliveries by market, BEV share, revenue — official, audited figures | [TODO: add URL — typically media.audiusa.com or annualreport.volkswagenag.com] | High | Publicly available PDF; no login required |
| 4 | Audi Press Releases | Digital strategy commitments, online sales rollout, configurator investment statements | [TODO: add URL — typically media.audiusa.com/newsroom or audi-mediacenter.com] | High (stated intent) | Searchable press archive; no login required |
| 5 | Cox Automotive 2024 Car Buyer Journey Study | 14+ hours average online research before dealer visit; 1.4 average dealer visits | coxautoinc.com (published summary) | High | Widely cited; published research methodology |
| 6 | Ruler Analytics 2026 Conversion Benchmarks | Automotive direct traffic conversion rate: 9.8% | ruleranalytics.com/blog | Benchmark | Publicly available blog post with stated methodology |
| 7 | Demand Local / WordStream 2024 | Automotive website conversion rate: 2–5% average; top performers 8–16% | demandlocal.com; wordstream.com/blog | Benchmark | Publicly available industry reports |
| 8 | Demand Local 2025 | Mobile conversion rate vs. desktop — confirmed "mobile paradox" in automotive | demandlocal.com | Benchmark | Published research; specific rates vary by brand |
| 9 | Google / Invoca research | Mobile device share of automotive research: >70% | invoca.com/blog | Benchmark | Industry-cited statistic; confirmed by multiple sources |
| 10 | Google BigQuery GA4 Public Dataset | Real GA4 event schema; used for SQL technique demonstration only | console.cloud.google.com/bigquery → bigquery-public-data.ga4_obfuscated_sample_ecommerce | High for schema | Free ≤10 GB/month; no billing required |

---

## Key Numbers and Their Provenance

| Number | Source | Confidence | Where used |
|--------|--------|------------|-----------|
| ~2.7M monthly visits, audiusa.com (Aug 2024) | SimilarWeb public competitor data (sourced via BMW project) | Estimated | competitive-signals.md |
| [TODO: audi.pt channel split — Direct %] | Semrush | Estimated | competitive-signals.md |
| [TODO: audi.pt channel split — Organic %] | Semrush | Estimated | competitive-signals.md |
| [TODO: audi.pt bounce rate] | Semrush competitor data | Estimated | competitive-signals.md |
| [TODO: Audi total 2024 global deliveries] | Audi AG / VW Group Annual Report 2024 | High | competitive-signals.md |
| [TODO: Audi BEV deliveries 2024 and YoY growth] | Audi AG / VW Group Annual Report 2024 | High | competitive-signals.md |
| [TODO: Audi BEV share of total deliveries] | Audi AG / VW Group Annual Report 2024 | High | competitive-signals.md |
| 2–5% automotive CVR average | Demand Local / WordStream 2024 | Benchmark | benchmark-context.md |
| 8–16% automotive CVR top performers | Demand Local 2026 | Benchmark | benchmark-context.md |
| 9.8% automotive direct traffic CVR | Ruler Analytics 2026 | Benchmark | benchmark-context.md |
| 1.57% organic search CVR, automotive | WordStream benchmarks | Benchmark | benchmark-context.md |
| >70% mobile share of automotive research | Google via Invoca | Benchmark | benchmark-context.md |
| 14+ hours online research before dealer | Cox Automotive 2024 | High | benchmark-context.md, insight-brief-audi.md |
| 1.4 average dealer visits before purchase | Cox Automotive / industry data | High | benchmark-context.md, insight-brief-audi.md |

---

## On Accuracy and Confidence

### SimilarWeb and Semrush

Both tools model traffic from ISP data, browser extensions, and panel data. A peer-reviewed comparison found SimilarWeb overestimates bounce rate by approximately 6.8% on average relative to actual Google Analytics data. For directional benchmarking and competitor comparison, these estimates are fit for purpose. They should never be quoted as exact figures.

### Audi-specific numbers

No number in this project is derived from Audi's internal analytics. All Audi-specific traffic and engagement figures are SimilarWeb/Semrush estimates, labelled explicitly throughout.

### Industry benchmarks

Conversion benchmarks from Ruler Analytics, Demand Local, and WordStream represent ranges across many automotive brands. They are used as context for what is plausible, not as Audi-specific targets.

---

## Confidence Level Definitions

| Level | Meaning |
|-------|---------|
| **High** | Primary source: official reports, press releases, published research with stated methodology |
| **Estimated** | Modelled third-party data (SimilarWeb, Semrush) — directionally useful, not precise; ±20–30% vs. real analytics |
| **Benchmark** | Published industry averages — useful for framing performance expectations; not brand-specific |

This labelling is not a disclaimer. It is the analysis. Knowing the provenance of a number is knowing how much weight to put on it.
