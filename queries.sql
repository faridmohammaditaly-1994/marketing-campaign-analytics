-- ============================================================
-- Project:     Marketing Campaign Analytics
-- Author:      Farid Mohammadi
-- GitHub:      faridmohammaditaly-1994
-- Dataset:     marketing_analytics.campaigns (50,000 rows)
-- Tool:        PostgreSQL + DBeaver
-- Description: Analysis of digital marketing campaign performance
--              across channels, destinations, and devices (2022-2023)
-- ============================================================

-- TASK 1: DATA AUDIT
-- ============================================================
-- Business question: What does this dataset contain?
-- Are there nulls, unexpected values, or data quality issues?

SELECT
    COUNT(*)                                                            AS total_records,
    MIN(campaign_date)                                                  AS earliest_date,
    MAX(campaign_date)                                                  AS latest_date,
    (MAX(campaign_date)::date - MIN(campaign_date)::date) || ' days'   AS date_range,
    COUNT(DISTINCT channel)                                             AS distinct_channels,
    COUNT(DISTINCT destination)                                         AS distinct_destinations,
    COUNT(*) FILTER (WHERE spend = 0 OR spend IS NULL)                  AS spend_zero_null,
    COUNT(*) FILTER (WHERE revenue < 0 OR revenue IS NULL)              AS revenue_negative_null,
    COUNT(*) FILTER (WHERE impressions <= 0 OR impressions IS NULL)     AS impressions_zero_null,
    COUNT(*) FILTER (WHERE clicks > impressions)                        AS clicks_exceed_impressions
FROM marketing_analytics.campaigns;





-- ============================================================
-- TASK 2: CHANNEL PERFORMANCE OVERVIEW
-- ============================================================
-- Business question: Which marketing channels deliver the best
-- return on ad spend? Leadership wants a ranked summary.

SELECT
    channel,
    SUM(spend)                                                              AS total_spend,
    SUM(revenue)                                                            AS total_revenue,
    SUM(impressions)                                                        AS total_impressions,
    SUM(clicks)                                                             AS total_clicks,
    SUM(conversions)                                                        AS total_conversions,
    ROUND(SUM(clicks)::NUMERIC      / NULLIF(SUM(impressions), 0), 4)      AS ctr,
    ROUND(SUM(conversions)::NUMERIC / NULLIF(SUM(clicks), 0), 4)           AS cvr,
    ROUND(SUM(spend)::NUMERIC       / NULLIF(SUM(conversions), 0), 2)      AS cpa,
    ROUND(SUM(revenue)::NUMERIC     / NULLIF(SUM(spend)::NUMERIC, 0), 2)            AS roas,
    RANK() OVER (ORDER BY SUM(revenue)::NUMERIC / NULLIF(SUM(spend), 0) DESC) AS rank_by_roas
FROM marketing_analytics.campaigns
GROUP BY channel
ORDER BY rank_by_roas;


-- ============================================================
-- TASK 3: ROAS BY DEVICE AND CHANNEL
-- ============================================================
-- Business question: Does device type affect campaign performance?
-- The media team wants to know where to shift budget across
-- device and channel combinations.

SELECT
    channel,
    device,
    SUM(spend)                                                                  AS total_spend,
    SUM(revenue)                                                                AS total_revenue,
    ROUND(SUM(revenue)::NUMERIC / NULLIF(SUM(spend)::NUMERIC, 0), 2)           AS roas,
    RANK() OVER (
        PARTITION BY channel
        ORDER BY SUM(revenue)::NUMERIC / NULLIF(SUM(spend), 0) DESC
    )                                                                           AS rank_by_roas_within_channel
FROM marketing_analytics.campaigns
GROUP BY channel, device
ORDER BY channel, rank_by_roas_within_channel;




















