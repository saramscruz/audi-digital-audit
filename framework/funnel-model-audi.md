# Audi Digital Funnel Model

**Source:** Direct UI observation of audi.com / audiusa.com — to be completed  
**Method:** Navigating the site and mapping each stage transition, CTA, URL, and form field as observed  
**Market:** [TODO: specify market — e.g., US (audiusa.com) or global (audi.com)]  
**Device:** Desktop (mobile observation to follow)  
**Date observed:** [TODO: date]

---

## Status

This file is a placeholder. Funnel mapping requires direct UI observation of the Audi website.

Estimated time to complete: ~1 hour.

---

## What to map

When observing the Audi funnel, document the following for each stage:

1. **Stage name and URL** — exact URL pattern at each transition
2. **CTAs available** — label text, placement, and destination
3. **Configurator structure** — number of steps, step names, cross-domain behaviour
4. **Lead forms** — mandatory field count, form URL, confirmation behaviour
5. **Mobile differences** — any structural differences from desktop
6. **Friction points** — login walls, price reveals, mandatory fields above 4

---

## Expected Funnel Stages

Based on standard automotive digital funnel architecture, Audi's funnel is expected to follow a similar pattern to BMW's:

```
[Traffic Sources]
    Organic Search  →
    Direct          →     Stage 0: Entry (audi.com or audiusa.com homepage)
    Paid Search     →         │
    Paid Social     →         ▼
    Referral        →     Stage 1: Model Range / Model Overview
                              │
                              ▼
                          Stage 2: Configurator (N steps — to be counted)
                              │
                              ▼
                          Stage 3: Configurator Summary
                              │
                    ┌─────────┴─────────┐
                    ▼                   ▼
                Stage 4a            Stage 4b
                Lead Form           Test Drive / Reserve
                (N fields — TBC)    (TBC)
```

---

## Key Observations to Record

### Cross-domain behaviour
Does the Audi configurator run on a subdomain (e.g., `configurator.audi.com`) separate from the main site? If yes, cross-domain tracking in GA4 must be explicitly configured or session attribution breaks.

### Price reveal point
At which configurator step does the base price first appear? This is typically the primary drop-off point (as observed in the BMW i4 at Step 2).

### Login wall
Is a login / account creation required to save a configuration or place a reservation? If yes, this gates the re-engagement mechanism and should be noted.

### Lead form field count
How many mandatory fields does the primary lead form require? Industry benchmark for conversion drop-off: 3–4 fields.

---

## Mobile Observation

To be completed after desktop observation.

Key question: Does the configurator navigation structure differ on mobile (e.g., horizontal menu on desktop vs. vertical scroll on mobile, as observed on BMW)?

---

*See [kpi-framework.md](kpi-framework.md) for the KPI definitions this funnel feeds.*  
*See [event-taxonomy.md](event-taxonomy.md) for the GA4 event specification at each stage.*
