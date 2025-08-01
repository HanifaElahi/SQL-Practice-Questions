-- Question: 

-- Assume you have an events table on Facebook app analytics. 
-- Write a query to calculate the click-through rate (CTR) for the app in 2022 and round the results to 2 decimal places.
-- Definition and note:
    -- Percentage of click-through rate (CTR) = 100.0 * Number of clicks / Number of impressions
    -- To avoid integer division, multiply the CTR by 100.0, not 100.

SELECT 
    app_id, ROUND((CAST(SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) AS DECIMAL) / SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END)) * 100.0, 2) AS ctr
FROM events
WHERE EXTRACT(YEAR FROM timestamp) = '2022'
GROUP BY app_id;