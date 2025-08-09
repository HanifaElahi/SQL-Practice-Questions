-- Question:

-- Write a query to determine how many direct reports each Manager has.
-- Note: Managers will have "Manager" in their title.
-- Report the Manager ID, Manager Title, and the number of direct reports in your output.

SELECT 
    m.employee_id AS manager_id, m.position AS manager_position, COUNT(*) AS direct_reports
FROM direct_reports e
JOIN direct_reports m ON e.managers_id = m.employee_id
WHERE m.position LIKE '%Manager%'
GROUP BY m.employee_id, m.position;