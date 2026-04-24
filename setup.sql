CREATE SCHEMA marketing_analytics;

CREATE TABLE marketing_analytics.campaigns (
    campaign_id     INT,
    campaign_date   DATE,
    campaign_year   INT,
    campaign_month  VARCHAR(20),
    channel         VARCHAR(50),
    campaign_name   VARCHAR(100),
    destination     VARCHAR(100),
    region          VARCHAR(50),
    device          VARCHAR(20),
    impressions     INT,
    clicks          INT,
    conversions     INT,
    spend           NUMERIC(10,2),
    revenue         NUMERIC(10,2)
);