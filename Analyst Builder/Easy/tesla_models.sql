-- Question:

-- Tesla just provided their quarterly sales for their major vehicles.
-- Determine which Tesla Model has made the most profit.
-- Include all columns with the "profit" column at the end.

SELECT 
    *, (car_price - production_cost) * cars_sold AS profit 
FROM tesla_models
ORDER BY profit DESC
LIMIT 1;