-- Question:

-- In the United States, fast food is the cornerstone of it's very society. 
-- Without it, it would cease to exist.
-- But which region spends the most money on fast food?
-- Write a query to determine which region spends the most amount of money on fast food.

SELECT 
    region
FROM food_regions
GROUP BY region
ORDER BY SUM(fast_food_millions) DESC
LIMIT 1;