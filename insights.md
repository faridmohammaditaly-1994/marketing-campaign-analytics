## Task 1: Data Audit
- **Dataset:** 50,000 records spanning 2022-01-01 to 2023-12-31 (729 days)
- **Coverage:** 6 distinct channels, 10 destinations
- **Data quality:** No nulls, no invalid values, no clicks exceeding impressions
- **Analytical note:** Perfect cleanliness confirms synthetic data — real campaign data always contains anomalies

## Task 2: Channel Performance Overview
- **Email leads ROAS** (9.35) — highest revenue efficiency despite lowest CVR (0.18%)
- **Display Ads lowest ROAS** (2.54) — awareness channel, not conversion-focused
- **Key insight:** ROAS and CVR measure different things — high ROAS with low CVR means high booking value per conversion, not high click efficiency
- **CPA range:** $139 (Email) to $513 (Display Ads) — Email is 3.7x more cost-efficient per booking

## Task 3: ROAS by Device and Channel
- **Desktop ranks 1st in every channel** — consistent with higher purchase intent on desktop
- **ROAS differences across devices are minimal** — suggests synthetic data; real data would show Mobile underperforming on CVR
- **Real-world expectation:** Mobile drives clicks but Desktop closes bookings — budget should favor Desktop for conversion campaigns and Mobile for awareness

## Task 4: Monthly Spend and Revenue Trend
- **ROAS peaks in summer** (Jul/Aug ~5.88) and dips in Jan/Feb (~3.82) — seasonal efficiency pattern
- **January 2023 spend spike (+53.47% MoM)** — caused by December budget pullback, not January surge
- **Revenue growth does not match spend growth** — January revenue grew only +1.24% despite +53% spend jump, indicating poor efficiency at budget reset
- **December anomaly:** Normal campaign volume but lower avg spend per campaign — advertisers reduce daily budgets in December despite peak season

## Task 5: Campaign Efficiency Ranking
- **Email Abandoned Cart leads all campaigns** (ROAS 9.41, CPA $139) — highest return, lowest cost per booking
- **Display Ads Native Ad and Retargeting tie at rank 1** (ROAS 2.56) — lowest performing channel, both campaigns equally weak
- **Paid Search Summer Deals** best in channel (ROAS 5.51) — strong seasonal campaign to scale
- **Key SQL pattern:** Window function results cannot be filtered in the same query — second CTE required to reference rank in WHERE clause

## Task 6: Multi-level Aggregation with GROUPING SETS
- **Grand total ROAS: 4.89** across $90.5M spend and $442M revenue
- **Email dominates** — $86.7M revenue at 9.35 ROAS, highest of all channels
- **Display Ads weakest** — $35.8M revenue at 2.54 ROAS despite similar spend to other channels
- **No regional variation** — ROAS is consistent across all regions within each channel
- **Key pattern:** GROUPING SETS replaces multiple UNION ALL queries — one query, three aggregation levels
- **Ordering lesson:** COALESCE aliases require CASE WHEN in ORDER BY to push subtotals to bottom