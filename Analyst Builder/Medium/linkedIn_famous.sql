-- Question:

-- Write a query to determine the popularity of a post on LinkedIn
-- Popularity is defined by number of actions (likes, comments, shares, etc.) divided by the number impressions the post received * 100.
-- If the post receives a score higher than 1 it was very popular.
-- Return all the post IDs and their popularity where the score is 1 or greater.
-- Order popularity from highest to lowest.

SELECT 
    post_id, score 
FROM(
  SELECT 
    *, (actions::NUMERIC/impressions)*100 AS score
  FROM linkedin_posts
) AS sub_query
WHERE score > 1
ORDER BY score DESC;