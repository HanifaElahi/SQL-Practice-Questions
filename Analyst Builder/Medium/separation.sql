-- Question:

-- Data was input incorrectly into the database. The ID was combined with the First Name.
-- Write a query to separate the ID and First Name into two separate columns.
-- Each ID is 5 characters long.

SELECT
    SUBSTRING(id, 1, 5) AS ID, SUBSTRING(id, 6) AS First_Name
FROM bad_data;