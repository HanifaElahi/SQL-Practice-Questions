
-- WEBSITE : https://www.codechef.com/practice/sql-case-studies-topic-wise

-- SQL Practice Queries

-- Retrieve all columns from the Products table.
SELECT 
    *
FROM Products;

-- Find all product_name and category where price is greater than 100.00.
SELECT 
    product_name,
    category 
FROM Products
WHERE price > 100.00;

-- Calculate the average salary across all companies combined.
SELECT 
    AVG(salary) AS avg_salary 
FROM Works;

-- Retrieve department_name and location for people who live in locations starting with 'S'.
SELECT 
    department_name,
    location
FROM departments 
WHERE location LIKE 'S%';

-- Select all distinct companies (company_name) from the Works table.
SELECT 
    DISTINCT company_name 
FROM Works;

-- Find the total count of books whose genre is Fiction.
SELECT 
    COUNT(id) AS fiction_count
FROM Books
WHERE genre = 'Fiction';

-- Select movie names where ratings are between 7 and 9.
SELECT 
    movie_name 
FROM Cinema 
WHERE Rating BETWEEN 7.1 AND 8.9;

-- Retrieve book_id, title, author, and published_year of books with NULL ratings.
SELECT 
    book_id,
    title,
    author,
    published_year 
FROM Library 
WHERE rating IS NULL;

-- Retrieve employee_name, company, and salary for full-time employees, ordered by salary descending.
SELECT 
    employee_name,
    company,
    salary 
FROM Employees 
WHERE category = 'Full-Time'
ORDER BY salary DESC;

-- Group employees by department and display the total number of employees.
SELECT 
    department,
    COUNT(employee_id) AS total_employees 
FROM Employees 
GROUP BY department;

-- Retrieve author_id, author_name, and publication_name for authors whose articles got zero views.
SELECT 
    author_id,
    author_name,
    publication_name
FROM Views 
WHERE view_count = 0
ORDER BY author_id;

-- Find names of the top 3 distinct players by highest score who have won matches, including their scores.
SELECT 
    DISTINCT player_name,
    score 
FROM Players t1 
INNER JOIN Matches t2 ON t1.player_name = t2.winner 
ORDER BY score DESC 
LIMIT 3;

-- Retrieve details of the last five matches played, including match ID, player names, winner, match date, and final score.
SELECT 
    match_id,
    player_1,
    player_2,
    winner,
    match_date,
    score
FROM Players t1 
LEFT JOIN Matches t2 ON t1.player_name = t2.winner
ORDER BY match_date DESC 
LIMIT 5;