-- Question: 

-- Assume you're given the tables containing completed trade orders and user details in a Robinhood trading system.
-- Write a query to retrieve the top three cities that have the highest number of completed trade orders listed in descending order. 
-- Output the city name and the corresponding number of completed trade orders.

SELECT 
    u.city, COUNT(t.order_id) AS total_orders
FROM trades t 
LEFT JOIN users u ON t.user_id = u.user_id
WHERE t.status = 'Completed'
GROUP BY u.city
ORDER BY total_orders DESC 
LIMIT 3;