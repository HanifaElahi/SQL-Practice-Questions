-- Question: 

-- Assume you're given a table Twitter tweet data.
-- Write a query to obtain a histogram of tweets posted per user in 2022. 
-- Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.
-- In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group.

SELECT 
    tweet_bucket, COUNT(DISTINCT user_id) AS users_num 
FROM(
    SELECT 
        user_id, COUNT(tweet_id) AS tweet_bucket
    FROM tweets
    WHERE date_trunc('year', tweet_date) = date('2022-01-01')
    GROUP BY user_id
) t
GROUP BY tweet_bucket;