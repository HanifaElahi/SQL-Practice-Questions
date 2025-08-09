-- Question:

-- If a customer is 55 or above they qualify for the senior citizen discount. 
-- Check which customers qualify.
-- Assume the current date 1/1/2023.
-- Return all of the Customer IDs who qualify for the senior citizen discount in ascending order.

WITH age_calcs AS(
  SELECT 
    *, EXTRACT(YEAR FROM AGE('2023-01-01', birth_date)) AS age
  FROM customers
)

SELECT 
    customer_id
FROM age_calcs
WHERE age >= 55
ORDER BY customer_id;