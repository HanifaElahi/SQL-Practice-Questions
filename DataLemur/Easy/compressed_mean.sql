-- Question: 

-- You're trying to find the mean number of items per order on Alibaba, rounded to 1 decimal place using tables which includes information on the count of items in each order (item_count table) and the corresponding number of orders for each item count (order_occurrences table).

SELECT 
  ROUND(CAST(SUM(item_count*order_occurrences) AS DECIMAL) / SUM(order_occurrences), 1) AS mean
FROM items_per_order;