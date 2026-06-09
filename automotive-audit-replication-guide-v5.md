# Automotive Digital Intelligence Audit — Replication Guide

**Version:** 5.0  
**Date:** June 2026  
**Based on:** BMW project (pilot) + Audi project (first replication, completed June 2026)  
**Purpose:** Step-by-step guide to replicating this audit for any premium automotive brand

---

## What Transfers Unchanged

The following files copy directly from the BMW project to any new brand without modification. Do not edit them — they are intentionally brand-agnostic.

| File | Why it transfers unchanged |
|------|---------------------------|
| `sql/A-multi-session-path.sql` | Targets Google's public GA4 dataset, not a brand domain |
| `sql/B-funnel-dropoff.sql` | Same — dataset-agnostic |
| `sql/C-device-channel-interaction.sql` | Same |
| `sql/D-return-visitor-lift.sql` | Same |
| `outputs/query-results/A-results.csv` | Results are from the public dataset — identical across brands |
| `outputs/query-results/B-results.csv` | Same |
| `outputs/query-results/C-results.csv` | Same |
| `outputs/query-results/D-results.csv` | Same |
| `framework/kpi-framework.md` | Tier 1/2/3 structure is universal across automotive brands |
| `framework/event-taxonomy.md` | Standard GA4 events — brand-agnostic |
| `analysis/benchmark-context.md` | Industry benchmarks (Cox Automotive, Ruler Analytics, Demand Local, WordStream) — not brand-specific |

**Confirmed in Audi replication:** All eleven files transferred correctly with no errors or brand-specific conflicts.

---

## What Requires Brand-Specific Work

These tasks must be completed fresh for each new brand. Times below reflect actual duration from the Audi replication, not estimates.

| Task | Time | Output file |
|------|------|-------------|
| 1. Google Trends — identify highest-demand model | ~45 min | feeds into competitive-signals.md |
| 2. Google Trends — full analysis (all 4 search types + 3-way comparison) | ~30 min | analysis/competitive-signals.md |
| 3. Funnel observation — brand configurator (desktop + mobile) | ~60 min | framework/funnel-model-[brand].md |
| 4. Annual Report extraction | ~30 min | analysis/competitive-signals.md |
| 5. Competitive signals file | ~30 min (in Claude Code) | analysis/competitive-signals.md |
| 6. Insight brief | ~45 min (in Claude Code) | analysis/insight-brief-[brand].md |
| 7. Dashboard | ~30 min (in Claude Code) | dashboard/[brand]-dashboard.html |
| 8. GitHub push + Pages | ~15 min | live URL |

**Total: approximately 5 hours active work per brand.**

> Note: Earlier versions of this guide estimated 3–4 hours. The Audi replication confirmed 5 hours is the more accurate figure when the Google Trends work is done thoroughly (all four search types, screenshots, 3-way comparison) and the insight brief takes positions rather than just summarising data.

---

## Step-by-Step Replication Instructions

### Step 1 — Google Trends (do this BEFORE funnel observation)

**Go to trends.google.pt, not trends.google.com.** Results differ by region and you want Portuguese market data.

**Select the car make entity, not the plain search term.** When you type the brand name, a dropdown appears. Select the result with the brand icon and label "Car make" — not the plain text match. Results differ significantly between the two.

**Cycle through all four search types for the brand:**
1. Web Search — top queries + rising queries + interest over time
2. YouTube Search — top queries + rising queries (this is where breakout model signals appear)
3. Google Shopping — interest over time (will likely be near zero for premium automotive — note it and move on)
4. News Search — interest over time + top/rising queries

**Screenshot interest over time AND top/rising queries for each search type.** You will need these for competitive-signals.md.

**Add the 3-way comparison:** brand + BMW + Mercedes-Benz, all as car make entities, Web Search. The average interest scores from this comparison are your key competitive benchmark numbers.

**The highest-demand model is identified from YouTube rising queries.** BREAKOUT tags are the strongest signal — they indicate >5,000% growth from a near-zero baseline, meaning a genuinely new behaviour rather than growth from an established base. In the Audi project, the Q3 appeared as BREAKOUT on YouTube and at +2,000% — this became the lead finding for the entire audit.

**News Search spikes require verification before interpreting.** A spike could be a product launch (positive commercial signal), a recall, or unrelated coverage. Check the queries below the graph and cross-reference with Portuguese automotive news from that week. Do not write an interpretation until the cause is confirmed.

**Google Shopping near zero is expected and not a finding.** Note it briefly in competitive-signals.md and move on.

---

### Step 2 — Funnel observation (desktop first, then mobile)

Navigate the brand's configurator as a buyer would. Map each stage: URL, CTA labels, step names, mandatory form fields, cross-domain behaviour. Take notes as you go — do not rely on memory.

**Confirmed observations from the Audi replication:**

**Configurator domain:** The configurator may open in a new window on a separate subdomain. Audi: `configurador.audi.pt` (new window, separate domain). BMW: `configure.bmw.pt`. Note the domain exactly — it matters for the cross-domain tracking finding in the insight brief.

**Trim level step:** Check the Linha de equipamento / trim selection step carefully. Audi Q3 had only one trim (Advanced only, €48,251). A single trim level significantly changes the framing — there is no trim decision friction, which shifts the analytical focus. Do not assume multiple trims exist.

**Account type for save:** Note whether saving a configuration requires a first-party account (BMW: BMW ID) or a third-party portal (Audi: carLOG). Third-party is a stronger friction finding — it means Audi's re-engagement mechanism is outside their own ecosystem. Document the exact platform name.

**Mobile step navigation:** Check whether step count is visible on mobile. BMW shows step name + position indicator (e.g., 2/14). Audi shows step name only by default, with the full sequence accessible via a dropdown tap. Document the difference precisely — it affects the mobile UX finding.

**Price at first exposure:** Note when and how price first appears. BMW i4: price appears at Step 2 (gated behind drivetrain selection). Audi Q3: price visible in a persistent bottom bar from the moment the configurator opens. The persistent bar is lower friction. Document it.

**Lead form mandatory fields:** Count only the fields marked with an asterisk (*) or equivalent required indicator. Audi Q3: 3 mandatory fields (Nome*, Apelido*, contact preference*). BMW: 7 mandatory fields. The field count directly determines whether the form is a friction finding or not — Audi's 3-field form is below the conversion drop-off threshold.

---

### Step 3 — Annual Report

Download the brand's most recent annual report (usually a publicly available PDF). Extract:
- Total global deliveries and YoY change
- BEV deliveries and YoY change
- BEV share of total
- Best-selling model globally
- Any mention of digital sales strategy, configurator investment, or online purchase rollout

**Note what is absent as well as what is present.** The Audi Group Annual Report 2024 made no mention of online purchase rollout or direct digital sales channel — a material difference from BMW's stated triple-digit million annual digital investment. Absence of a statement is an analytical finding.

---

### Steps 4–8 — File production in Claude Code

With the data collected in Steps 1–3, the remaining files are produced in Claude Code:

- **competitive-signals.md:** Paste the Google Trends data and Annual Report figures as structured input. Every number must have a source and confidence level. Flag any unverified signals (e.g., news spikes) explicitly.
- **insight-brief-[brand].md:** See the "What Makes a Strong Insight Brief" section below.
- **[brand]-dashboard.html:** Copy the BMW dashboard, swap accent colour, replace SVG logo, update all content. Audi red confirmed: `#BB0A14`.
- **GitHub + Pages:** Init repo, commit, push, enable Pages on `main` from root.

---

## What the Project Should Find — Confirmed vs Anticipated

The following hypotheses from the original guide were tested against the Audi replication:

**Hypothesis 1 — Configurator steps:** Audi Q3 has 5 steps. The deep customisation hypothesis was **not confirmed** for the Q3 — single trim, streamlined flow. Do not assume complex configurators. Step count must be observed directly.

**Hypothesis 2 — Online purchase path:** **Confirmed absent** for Audi Q3. Dealer lead form only. carLOG third-party save is an additional friction point not anticipated in the original guide — it surfaced only from direct UI observation.

**Hypothesis 3 — BEV as highest-demand segment:** **Partially confirmed.** Q4 e-tron appeared at +60% in rising queries but was not the lead signal. The Q3 (ICE/hybrid) was the breakout model in Portugal — +2,000% YouTube BREAKOUT. **Do not assume BEV equals highest demand.** Let the Google Trends data answer this for each brand and market.

**Hypothesis 4 — Three-way comparison gap:** **Confirmed.** Audi 46 vs BMW 86 vs Mercedes-Benz 78 (Google Trends, Portugal, Web Search, car make entities, past year). Audi trails both significantly.

---

## Key Differences — BMW vs Audi (Confirmed)

| Element | BMW.pt | Audi.pt |
|---------|--------|---------|
| Configurator domain | configure.bmw.pt (separate subdomain) | configurador.audi.pt (separate subdomain, new window) |
| Number of configurator steps | i4: 12 · iX3: 14 | Q3 SUV: 5 |
| Trim levels at step 2 | Multiple | 1 (Advanced only) |
| Reserve / online purchase | Available on i4 · absent on iX3 | Absent entirely |
| Lead form mandatory fields | 7 | 3 (Nome*, Apelido*, contact preference*) |
| Account required to save | BMW ID (first-party) | carLOG (third-party portal) |
| Price at first exposure | Step 2 (gated) | Persistent bottom bar from entry |
| Mobile step navigation | Step name + position indicator (e.g. 2/14) | Step name only · full sequence via dropdown tap |
| Entry price (base model) | i4: €57,950 · iX3: €64,500 | Q3 SUV TFSI: €48,251 |
| Annual Report digital strategy | Triple-digit million investment stated · online purchase rollout active | No online purchase or digital sales channel mentioned |

---

## What Makes a Strong Insight Brief

Based on the Audi insight brief built in this replication, these structural decisions produced the strongest output:

**1. Name a specific model and a specific gap — not a generic funnel observation.**
"The Q3 has the demand — the funnel only has a dealer form" is a finding. "The configurator could be improved" is not. The lead finding must be falsifiable and brand-specific.

**2. Reframe UX findings as product decisions.**
"The problem is not the form — it is what the form leads to" is more useful than "the lead form has friction." The first points to a product decision (add a reservation path). The second points to a design task (simplify the form). Product decisions have larger commercial consequences.

**3. Name third-party dependencies explicitly.**
carLOG and BMW ID are not interchangeable. carLOG means Audi's re-engagement mechanism runs on infrastructure outside their own analytics, CRM, and data layer. That is a structural finding, not a UX note.

**4. Out-of-funnel leakage visible in search data is the most original finding available with free tools.**
`importrust` at +140% in Audi's rising purchase-intent queries is invisible to GA4. It only appears in Google Trends. Look for this pattern in every brand's rising queries — third-party platforms, grey-market importers, used-car aggregators. If buyers are routing around the official funnel, that signal exists in search data before it shows up anywhere internal.

**5. Every finding should have a corresponding hypothesis that is falsifiable and has a cost estimate.**
A finding without a testable hypothesis is analysis. A finding with a sprint-sized test attached to it is a recommendation. Hiring managers and product managers need the second form.

**6. Acknowledge what GA4 cannot see — it demonstrates analytical maturity, not weakness.**
The closing paragraph of the Audi brief names the one gap that real GA4 access cannot close (the importrust leakage). Naming limits is a signal of reliability, not incompleteness.

---

## Dashboard — Confirmed Notes

- **Audi accent colour:** `#BB0A14` (red)
- **Audi configurator subdomain:** `configurador.audi.pt`
- **The "What amplifies the gap" subordinated findings pattern** — used in the Audi dashboard to fold SQL-derived context under the Q3 gap finding — produces a cleaner hierarchy than five flat numbered findings. Use this pattern in all future dashboards when two or more findings contextualise a single lead position.
- **Hero title pattern that works:** "[Model] is breaking out. Its conversion path isn't." Use this as the template. It names the specific model, implies demand without stating a number, and creates tension that the body resolves.
- **Chart data is identical across all brand dashboards** — the three charts (funnel drop-off, return visitor lift, device × channel) always use the Google Merchandise Store dataset results. Only text content, accent colour, and SVG logo change.

---

## Project Status Template

For each new brand replication, track:

| Component | Status |
|-----------|--------|
| Repository structure | ⬜ |
| KPI framework + event taxonomy (copied) | ⬜ |
| Benchmark context (copied) | ⬜ |
| SQL queries + CSVs (copied) | ⬜ |
| Google Trends data collected | ⬜ |
| Funnel observation (desktop) | ⬜ |
| Funnel observation (mobile) | ⬜ |
| Annual Report reviewed | ⬜ |
| competitive-signals.md | ⬜ |
| funnel-model-[brand].md | ⬜ |
| insight-brief-[brand].md | ⬜ |
| [brand]-dashboard.html | ⬜ |
| GitHub repository public | ⬜ |
| GitHub Pages live | ⬜ |

**Estimated total active work: 5 hours per brand.**

---

*Version 5.0 — June 2026. Based on BMW Digital Intelligence Audit (pilot) and Audi Digital Intelligence Audit (first replication). All time estimates reflect actual duration from the Audi project.*
