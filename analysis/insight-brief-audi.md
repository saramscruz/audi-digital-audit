# Insight Brief — Audi Digital Funnel

**Data:** Google Merchandise Store GA4 sample dataset — not Audi. Patterns are directionally valid; specific rates do not transfer. One transparency statement, stated once.

---

## What We Know

Four queries run against Google's public GA4 dataset produced findings directly relevant to how Audi should think about its digital funnel.

**Conversion takes multiple sessions and days.** Converters took a median 3 sessions and an average of 129 hours from first visit to purchase. Non-converters averaged 1.3 sessions and did not return. The conversion window is a multi-day journey, not a single-visit decision.

**The funnel breaks at one step.** 80.3% of users who viewed a product did not take the next action. One transition accounts for the majority of funnel loss; everything downstream is secondary. For Audi, the equivalent is model page to configurator entry.

**The mobile gap is channel-specific.** Mobile CPC converts at 4.28% vs desktop 5.06%. Mobile referral outperforms desktop outright. The problem is not mobile devices — it is the paid mobile experience specifically.

**Return visits compound.** Conversion grows from 0.78% on the first session to 4.94% on the sixth — a 6.3x lift that does not plateau. The mechanism that enables return visits matters commercially.

Audi's 2024 numbers frame what this means. Global deliveries fell 11.8%. BEV deliveries fell 7.8%; BEV share dropped to 9.3%. The growth signal is not electric — it is the Q3, at +250% in Portuguese web search and BREAKOUT (+2,000%) on YouTube. That model is where digital demand is running ahead of everything else in the portfolio.

---

## What It Suggests

**Audi's highest-demand model has no digital conversion path beyond a dealer form.** The Q3 configurator on audi.pt is genuinely low-friction: 5 steps, price visible throughout, lead form requiring only name and contact preference — 3 fields, well below the drop-off threshold. The problem is not the form. It is what the form leads to: a dealer handoff. BMW offers online reservation on the i4. Audi offers nothing equivalent on the Q3. A buyer who completes the Q3 configurator at 11pm cannot do anything with that intent until a dealer opens in the morning.

**The re-engagement mechanism is outsourced to a third party.** Saving a configuration requires a carLOG account — a portal outside Audi's own ecosystem. The 6.3x return-visitor lift means high-intent buyers who save and return are the most valuable cohort in the funnel. Audi is depending on a third-party account creation to capture them.

**Some buyers are not reaching the funnel at all.** `importrust` at +140% in Audi's rising purchase-intent queries signals that a measurable share of high-intent buyers is routing to grey-market import channels before engaging with audi.pt. This leakage is invisible to GA4 — it only shows up in search signals.

---

## What We'd Test

Three analyses, in priority order:

1. **Configurator entry rate for the Q3 vs the rest of the model range.** The Q3 is generating the most search interest. Does that translate to configurator starts, or does the search intent dissipate before the configurator is opened? If the entry rate is lower for the Q3 than for other models, the model page — not the configurator — is where the fix lives.

2. **Return visit rate for carLOG users vs non-savers.** If users who create a carLOG account return at substantially higher rates, the account barrier is earning its friction. If not, a lightweight alternative — email address only, no account required — is the better mechanism and would take one sprint to test.

3. **Mobile CPC landing experience for Q3 paid traffic.** The paid mobile gap (4.28% vs 5.06%) may be concentrated on Q3 campaigns, which are likely running at higher volume given search growth. Identifying whether the gap is model-specific or sitewide changes the scope of the fix by an order of magnitude.

---

## What Changes With Real Data

Audi is already collecting the data to answer every question in this brief. The Q3's configurator entry rate by device and channel, the return visit rate for carLOG savers, the mobile CPC gap by model — all of it is in GA4. Running these queries takes hours. The one gap that GA4 cannot close is the `importrust` leakage: that signal only exists outside the funnel, in search data, which is where it was found.
