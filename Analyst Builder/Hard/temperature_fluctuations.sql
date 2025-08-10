-- Question:

-- Write a query to find all dates with higher temperatures compared to the previous dates (yesterday).
-- Order dates in ascending order.

SELECT 
  date 
FROM (
  SELECT 
    *, LAG(temperature) OVER(ORDER BY date) AS previous
  FROM temperatures
)
WHERE temperature > previous
ORDER BY date;