-- ============================================================
-- AUDI Q3 GA4 QUERIES: Requires Audi GA4 BigQuery export
-- These queries cannot be executed without access to Audi's
-- GA4 BigQuery export. Schema follows standard GA4 event
-- structure. Event names marked [VERIFY] must be confirmed
-- against Audi's actual GA4 implementation before running.
-- For proxy funnel shape data, see bmw-digital-audit repo:
-- /sql/proxy-analysis.sql (same dataset, do not duplicate)
-- ============================================================


-- ============================================================
-- QUERY 1: Q3 configurator completion rate vs model range
-- Answers whether Q3 BREAKOUT search demand is completing
-- configuration or dropping before the end screen.
-- ============================================================

WITH configurator_starts AS (
  SELECT
    user_pseudo_id,
    (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'model') AS model,
    (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'device_category') AS device_category,
    event_date
  FROM `<project>.analytics_<property_id>.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20250101' AND '20251231'
    AND event_name = 'configurator_start' -- [VERIFY]
),
detail_views AS (
  SELECT DISTINCT
    user_pseudo_id,
    event_date
  FROM `<project>.analytics_<property_id>.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20250101' AND '20251231'
    AND event_name = 'page_view'
    AND (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_location')
        LIKE '%configurador.audi.pt/cc-pt/%/detail/%'
)
SELECT
  CASE
    WHEN LOWER(cs.model) LIKE '%q3%' THEN 'Q3'
    ELSE 'Other models'
  END AS model_group,
  cs.device_category,
  COUNT(DISTINCT cs.user_pseudo_id) AS configurator_starts,
  COUNT(DISTINCT dv.user_pseudo_id) AS reached_detail_screen,
  ROUND(
    COUNT(DISTINCT dv.user_pseudo_id) * 100.0
    / NULLIF(COUNT(DISTINCT cs.user_pseudo_id), 0),
    2
  ) AS completion_rate_pct
FROM configurator_starts cs
LEFT JOIN detail_views dv
  ON cs.user_pseudo_id = dv.user_pseudo_id
  AND cs.event_date <= dv.event_date
GROUP BY 1, 2
ORDER BY 1, 2;


-- ============================================================
-- QUERY 2: Lead submission rate at end screen by device
-- Primary conversion metric for a dealer-only funnel —
-- the only digital action available after configuration.
-- ============================================================

WITH detail_sessions AS (
  SELECT DISTINCT
    user_pseudo_id,
    ga_session_id,
    device_category
  FROM (
    SELECT
      user_pseudo_id,
      (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS ga_session_id,
      (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'device_category') AS device_category,
      (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_location') AS page_location
    FROM `<project>.analytics_<property_id>.events_*`
    WHERE _TABLE_SUFFIX BETWEEN '20250101' AND '20251231'
      AND event_name = 'page_view'
  )
  WHERE page_location LIKE '%/detail/%'
),
lead_submissions AS (
  SELECT DISTINCT
    user_pseudo_id,
    (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS ga_session_id
  FROM `<project>.analytics_<property_id>.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20250101' AND '20251231'
    AND event_name = 'solicitar_proposta' -- [VERIFY]: may also be 'generate_lead' or 'form_submit'
)
SELECT
  ds.device_category,
  COUNT(DISTINCT ds.user_pseudo_id) AS reached_detail_screen,
  COUNT(DISTINCT ls.user_pseudo_id) AS submitted_lead,
  ROUND(
    COUNT(DISTINCT ls.user_pseudo_id) * 100.0
    / NULLIF(COUNT(DISTINCT ds.user_pseudo_id), 0),
    2
  ) AS lead_submission_rate_pct
FROM detail_sessions ds
LEFT JOIN lead_submissions ls
  ON ds.user_pseudo_id = ls.user_pseudo_id
  AND ds.ga_session_id = ls.ga_session_id
GROUP BY 1
ORDER BY 1;


-- ============================================================
-- QUERY 3: carLOG save rate vs return visit rate (7/14/30d)
-- The 51.5x return visitor lift from proxy data makes the
-- save mechanism the highest-value lever in the funnel —
-- this query measures whether carLOG is capturing that value
-- or losing it to account creation friction.
-- ============================================================

WITH save_events AS (
  SELECT
    user_pseudo_id,
    MIN(event_date) AS first_save_date
  FROM `<project>.analytics_<property_id>.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20250101' AND '20251231'
    AND event_name = 'carlog_save' -- [VERIFY]: may be 'save_configuration' or 'add_to_wishlist'
  GROUP BY 1
),
configurator_completers AS (
  SELECT
    user_pseudo_id,
    MIN(event_date) AS first_detail_date
  FROM (
    SELECT
      user_pseudo_id,
      event_date,
      (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_location') AS page_location
    FROM `<project>.analytics_<property_id>.events_*`
    WHERE _TABLE_SUFFIX BETWEEN '20250101' AND '20251231'
      AND event_name = 'page_view'
  )
  WHERE page_location LIKE '%/detail/%'
  GROUP BY 1
),
return_visits AS (
  SELECT
    user_pseudo_id,
    event_date
  FROM (
    SELECT
      user_pseudo_id,
      event_date,
      ROW_NUMBER() OVER (PARTITION BY user_pseudo_id ORDER BY event_date) AS visit_rank
    FROM (
      SELECT DISTINCT user_pseudo_id, event_date
      FROM `<project>.analytics_<property_id>.events_*`
      WHERE _TABLE_SUFFIX BETWEEN '20250101' AND '20251231'
    )
  )
  WHERE visit_rank > 1
)
SELECT
  'carLOG savers' AS segment,
  COUNT(DISTINCT se.user_pseudo_id) AS base_users,
  COUNT(DISTINCT CASE
    WHEN PARSE_DATE('%Y%m%d', rv.event_date)
         BETWEEN PARSE_DATE('%Y%m%d', se.first_save_date)
             AND DATE_ADD(PARSE_DATE('%Y%m%d', se.first_save_date), INTERVAL 7 DAY)
    THEN rv.user_pseudo_id END) AS returned_7d,
  COUNT(DISTINCT CASE
    WHEN PARSE_DATE('%Y%m%d', rv.event_date)
         BETWEEN PARSE_DATE('%Y%m%d', se.first_save_date)
             AND DATE_ADD(PARSE_DATE('%Y%m%d', se.first_save_date), INTERVAL 14 DAY)
    THEN rv.user_pseudo_id END) AS returned_14d,
  COUNT(DISTINCT CASE
    WHEN PARSE_DATE('%Y%m%d', rv.event_date)
         BETWEEN PARSE_DATE('%Y%m%d', se.first_save_date)
             AND DATE_ADD(PARSE_DATE('%Y%m%d', se.first_save_date), INTERVAL 30 DAY)
    THEN rv.user_pseudo_id END) AS returned_30d
FROM save_events se
LEFT JOIN return_visits rv ON se.user_pseudo_id = rv.user_pseudo_id

UNION ALL

SELECT
  'Completers without save' AS segment,
  COUNT(DISTINCT cc.user_pseudo_id) AS base_users,
  COUNT(DISTINCT CASE
    WHEN PARSE_DATE('%Y%m%d', rv.event_date)
         BETWEEN PARSE_DATE('%Y%m%d', cc.first_detail_date)
             AND DATE_ADD(PARSE_DATE('%Y%m%d', cc.first_detail_date), INTERVAL 7 DAY)
    THEN rv.user_pseudo_id END) AS returned_7d,
  COUNT(DISTINCT CASE
    WHEN PARSE_DATE('%Y%m%d', rv.event_date)
         BETWEEN PARSE_DATE('%Y%m%d', cc.first_detail_date)
             AND DATE_ADD(PARSE_DATE('%Y%m%d', cc.first_detail_date), INTERVAL 14 DAY)
    THEN rv.user_pseudo_id END) AS returned_14d,
  COUNT(DISTINCT CASE
    WHEN PARSE_DATE('%Y%m%d', rv.event_date)
         BETWEEN PARSE_DATE('%Y%m%d', cc.first_detail_date)
             AND DATE_ADD(PARSE_DATE('%Y%m%d', cc.first_detail_date), INTERVAL 30 DAY)
    THEN rv.user_pseudo_id END) AS returned_30d
FROM configurator_completers cc
LEFT JOIN save_events se ON cc.user_pseudo_id = se.user_pseudo_id
LEFT JOIN return_visits rv ON cc.user_pseudo_id = rv.user_pseudo_id
WHERE se.user_pseudo_id IS NULL;


-- ============================================================
-- QUERY 4: importrust search overlap in paid traffic
-- This query cannot directly measure importrust leakage —
-- that signal is only visible in Google Trends. This query
-- measures the inverse: of users who do reach audi.pt via
-- paid search, how many return directly (suggesting they
-- were already in the consideration funnel).
-- ============================================================

WITH cpc_sessions AS (
  SELECT DISTINCT
    user_pseudo_id,
    (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS ga_session_id,
    MIN(event_date) AS cpc_session_date
  FROM `<project>.analytics_<property_id>.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20250101' AND '20251231'
    AND (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'medium') = 'cpc'
    AND (
      (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_location')
        LIKE '%audi.pt%q3%'
      OR
      (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_location')
        LIKE '%configurador.audi.pt%'
    )
  GROUP BY 1, 2
),
direct_returns AS (
  SELECT DISTINCT
    user_pseudo_id,
    event_date AS return_date
  FROM `<project>.analytics_<property_id>.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20250101' AND '20251231'
    AND (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'medium') = '(none)'
    AND (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'source') = '(direct)'
    AND (
      (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_location')
        LIKE '%configurador.audi.pt%'
    )
)
SELECT
  COUNT(DISTINCT cs.user_pseudo_id) AS cpc_q3_users,
  COUNT(DISTINCT dr.user_pseudo_id) AS returned_direct_within_30d,
  ROUND(
    COUNT(DISTINCT dr.user_pseudo_id) * 100.0
    / NULLIF(COUNT(DISTINCT cs.user_pseudo_id), 0),
    2
  ) AS direct_return_rate_pct
FROM cpc_sessions cs
LEFT JOIN direct_returns dr
  ON cs.user_pseudo_id = dr.user_pseudo_id
  AND PARSE_DATE('%Y%m%d', dr.return_date)
      BETWEEN PARSE_DATE('%Y%m%d', cs.cpc_session_date)
          AND DATE_ADD(PARSE_DATE('%Y%m%d', cs.cpc_session_date), INTERVAL 30 DAY);