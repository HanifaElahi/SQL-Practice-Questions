-- Question:

-- Write a query to identify products that have undergone shrink-flation over the last year. 
-- Shrink-flation is defined as a reduction in product size while maintaining or increasing the price.
-- Include a flag for Shrinkflation. 
-- This should be a boolean value (True or False) indicating whether the product has undergone shrink-flation
-- The output should have the columns Product_Name, Size_Change_Percentage, Price_Change_Percentage, and Shrinkflation_Flag.
-- Round percentages to the nearest whole number and order the output on the product names alphabetically.

SELECT product_name,
       ROUND(((new_size::numeric - original_size::numeric) / original_size::numeric) * 100, 0) AS size_change_percentage,
       ROUND(((new_price::numeric - original_price::numeric) / original_price::numeric) * 100, 0) AS price_change_percentage,
       CASE
         WHEN new_size < original_size AND new_price >= original_price THEN 'True'
         ELSE 'False'
       END AS shrinkflation_flag
FROM products
ORDER BY product_name;