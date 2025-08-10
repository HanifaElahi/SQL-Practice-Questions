-- Question:

-- John created a new Social Media App and has just started advertising it to the world! 
-- He collected some data, but wants to see which marketing campaigns performed the best.
-- Write a query to calculate the Return on Investment (ROI) for each campaign and identify the top 25% of campaigns that have the highest ROI. 
-- The ROI is calculated as ((Revenue Generated - Investment) / Investment * 100). 
-- Round ROI to the nearest whole number.
-- The output should have the columns Campaign_ID, Campaign_Name, and ROI, and should be ordered by ROI in descending order and Campaign_ID in descending order. 
-- Only include the top 25% of campaigns with the highest ROI.

SELECT 
  campaign_id, campaign_name, 
  ROUND(((((revenue_generated - investment)::NUMERIC) / investment) * 100)::NUMERIC) AS ROI
FROM marketing_spend
ORDER BY ROI DESC, campaign_id DESC
LIMIT (SELECT COUNT(*) / 4 FROM marketing_spend);