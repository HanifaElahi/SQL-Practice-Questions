-- Question:

-- Marcie's Bakery is having a contest at her store. 
-- Whichever dessert sells more each day will be on discount tomorrow. 
-- She needs to identify which dessert is selling more.
-- Write a query to report the difference between the number of Cakes and Pies sold each day.
-- Output should include the date sold, the difference between cakes and pies, and which one sold more (cake or pie). 
-- The difference should be a positive number.
-- Return the result table ordered by Date_Sold.
-- Columns in output should be date_sold, difference, and sold_more.

SELECT 
  date_sold, ABS(difference) AS difference,
  CASE 
    WHEN cakes_sold > pie_sold THEN 'Cake'
    WHEN pie_sold > cakes_sold THEN 'Pie'
  END AS sold_more
FROM(
  SELECT 
    date_sold,
    COALESCE(SUM(CASE WHEN product = 'Cake' THEN amount_sold END), 0) AS cakes_sold,
    COALESCE(SUM(CASE WHEN product = 'Pie' THEN amount_sold END), 0) AS pie_sold , 
    COALESCE(SUM(CASE WHEN product = 'Cake' THEN amount_sold END), 0) -   COALESCE(SUM(CASE WHEN product = 'Pie' THEN amount_sold END), 0) AS difference 
  FROM desserts
  GROUP BY 1
)
ORDER BY date_sold;