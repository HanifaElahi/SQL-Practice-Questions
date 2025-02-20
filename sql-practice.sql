
-- WEBSITE : https://www.sql-practice.com/


---------------------------------------------------- EASY ---------------------------------------------------- 

-- Show first name, last name, and gender of patients whose gender is 'M'

SELECT 
	  first_name
    , last_name
    , gender 
FROM patients
WHERE gender = 'M'

-- Show first name and last name of patients who does not have allergies. (null)

SELECT 
	  first_name
    , last_name
FROM patients
WHERE allergies IS NULL

-- Show first name of patients that start with the letter 'C'

SELECT 
	  first_name
FROM patients
WHERE first_name LIKE ('C%')

-- Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)

SELECT 
	  first_name
	, last_name
FROM patients
WHERE weight BETWEEN 100 and 120

-- Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'

UPDATE patients
SET allergies = 'NKA' 
WHERE allergies IS NULL

-- Show first name and last name concatinated into one column to show their full name.

SELECT 
    CONCAT(first_name, ' ', last_name) full_name
FROM patients

-- Show first name, last name, and the full province name of each patient.

SELECT 
		first_name
   	,	last_name
    ,   province_name
FROM patients t1 
LEFT JOIN province_names t2 on t1.province_id = t2.province_id

-- Show how many patients have a birth_date with 2010 as the birth year.

SELECT count(*)
FROM patients 
WHERE YEAR(birth_date) = 2010

-- Show the first_name, last_name, and height of the patient with the greatest height.

SELECT 
	  first_name
  	, last_name
    , height
FROM patients 
WHERE height = (SELECT max(height) FROM patients)

-- Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000

SELECT 
	  *
FROM patients 
WHERE patient_id IN (1,45,534,879,1000)

-- Show the total number of admissions

SELECT 
	  count(*)
FROM admissions

-- Show all the columns from admissions where the patient was admitted and discharged on the same day.

SELECT 
	  *
FROM admissions 
WHERE admission_date = discharge_date

-- Show the patient id and the total number of admissions for patient_id 579.

SELECT 
	  patient_id, count(*) total_admissions
FROM admissions 
WHERE patient_id = 579
GROUP BY 1

-- Based on the cities that our patients live in, show unique cities that are in province_id 'NS'.

SELECT 
	  distinct city
FROM patients 
WHERE province_id = 'NS'

-- Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70

SELECT 
	    first_name
      , last_name 
      , birth_date
FROM patients 
WHERE (height > 160 and weight > 70)

-- Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'

SELECT 
	    first_name
      , last_name 
      , allergies
FROM patients 
WHERE (allergies IS NOT NULL and city = 'Hamilton')



---------------------------------------------------- MEDIUM ---------------------------------------------------- 

-- Show unique birth years from patients and order them by ascending.

SELECT 
	distinct YEAR(birth_date)
FROM patients 
ORDER BY YEAR(birth_date)


-- Show unique first names from the patients table which only occurs once in the list. For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.

SELECT 
	  distinct first_name
FROM patients 
GROUP BY 1 
HAVING COUNT(first_name) = 1

-- Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.

SELECT 
	  patient_id, first_name
FROM patients 
WHERE first_name LIKE ('s%s') and LEN(first_name) >= 6

-- Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'. Primary diagnosis is stored in the admissions table.

 SELECT 
	  t1.patient_id, t1.first_name, t1.last_name
FROM patients t1 
LEFT JOIN admissions t2 on t1.patient_id = t2.patient_id
WHERE diagnosis = 'Dementia'

-- Display every patient's first_name. Order the list by the length of each name and then by alphabetically.

SELECT 
	 first_name
FROM patients 
ORDER BY LEN(first_name), first_name

-- Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.

SELECT 
	 COUNT(CASE WHEN gender = 'M' THEN patient_id END) male_count, 
     COUNT(CASE WHEN gender = 'F' THEN patient_id END) female_count
FROM patients 

-- Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.

SELECT 
	   first_name
     , last_name
     , allergies
FROM patients 
WHERE allergies IN ('Penicillin', 'Morphine')
ORDER BY allergies, first_name, last_name


-- Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

SELECT 
DISTINCT
	  patient_id
    , diagnosis
FROM admissions
WHERE patient_id IN (
  SELECT patient_id
  FROM admissions
  GROUP BY 1
  HAVING COUNT(patient_id) > 1 AND  COUNT(DISTINCT diagnosis) = 1
)

-- Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.

SELECT 
DISTINCT
	  city
    , COUNT(patient_id) total_patients
FROM patients
GROUP BY 1
ORDER BY 2 DESC, 1 ASC

-- Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"

SELECT 
	  first_name
    , last_name
    , 'Patient' AS role
FROM patients 

UNION ALL 

SELECT 
	  first_name
    , last_name
    , 'Doctor' AS role
FROM doctors 

-- Show all allergies ordered by popularity. Remove NULL values from query.

SELECT 
	  allergies, count(*) total_diagnosis
 FROM patients
 WHERE allergies IS NOT NULL
 GROUP BY 1
 ORDER BY 2 DESC

-- Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.

SELECT 
	    first_name
      , last_name
      , birth_date
 FROM patients
 WHERE YEAR(birth_date) BETWEEN 1970 and 1979
 ORDER BY birth_date

-- We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order EX: SMITH,jane

SELECT 
	    CONCAT(UPPER(last_name), ',' , LOWER(first_name)) new_name
 FROM patients
ORDER BY first_name DESC

-- Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.

SELECT 
	    province_id, SUM(height) height
FROM patients
GROUP BY 1
HAVING SUM(height) >= 7000

-- Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'

SELECT 
	  (MAX(weight) - MIN(weight)) as diff
FROM patients
WHERE last_name = 'Maroni'

-- Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.

SELECT 
	  DAY(admission_date) day_number, COUNT(patient_id) admissions_occurred
FROM admissions
group by 1 
ORDER BY 2 DESC

-- Show all columns for patient_id 542's most recent admission_date.

SELECT 
	  *
FROM admissions
WHERE patient_id = 542 
and admission_date = (
  select max(admission_date) FROM admissions WHERE patient_id = 542
)

-- Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.

SELECT patient_id, attending_doctor_id, diagnosis
from admissions
WHERE ((patient_id % 2 != 0) AND attending_doctor_id IN (1,5,19)) OR (attending_doctor_id LIKE ('%2%') AND LEN(patient_id) = 3)

-- Show first_name, last_name, and the total number of admissions attended for each doctor. Every admission has been attended by a doctor.

SELECT first_name, last_name, COUNT(patient_id) admissions
FROM doctors t1
INNER JOIN admissions t2 on t2.attending_doctor_id = t1.doctor_id
GROUP BY 1, 2

-- For each doctor, display their id, full name, and the first and last admission date they attended.

SELECT doctor_id, CONCAT(first_name, ' ' , last_name) full_name, MIN(admission_date) first_admission, MAX(admission_date) last_admission
FROM doctors t1
INNER JOIN admissions t2 on t2.attending_doctor_id = t1.doctor_id
GROUP BY 1, 2

-- Display the total amount of patients for each province. Order by descending.

select province_name, COUNT(patient_id) total_patients
FROM patients t1
INNER JOIN province_names t2 on t2.province_id = t1.province_id
GROUP BY 1
ORDER BY 2 DESC

-- For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.

SELECT CONCAT(t2.first_name, ' ', t2.last_name) full_name, t1.diagnosis, CONCAT(t3.first_name, ' ', t3.last_name) doctor_name
FROM admissions t1
LEFT JOIN patients t2 on t1.patient_id = t2.patient_id
LEFT JOIN doctors t3 on t1.attending_doctor_id = t3.doctor_id

-- display the first name, last name and number of duplicate patients based on their first name and last name. Ex: A patient with an identical name can be considered a duplicate.

SELECT first_name, last_name, COUNT(*) records
FROM patients
GROUP BY 1, 2 
HAVING COUNT(*) > 1

-- Display a single row with max_visits, min_visits, average_visits where the maximum, minimum and average number of admissions per day is calculated. Average is rounded to 2 decimal places.

SELECT 
	  MAX(admissions) max_visits
    , MIN(admissions) min_visits
    , ROUND(AVG(admissions), 2) average_visits
FROM(  
  SELECT admission_date, count(patient_id) admissions
  FROM admissions 
  GROUP BY 1
 )

-- Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)

SELECT t1.patient_id, t1.first_name, t1.last_name
FROM patients t1 
LEFT JOIN admissions t2 on t1.patient_id = t2.patient_id
WHERE t2.patient_id IS NULL

-- Display patient's full name, height in the units feet rounded to 1 decimal, weight in the unit pounds rounded to 0 decimals, birth_date, gender non abbreviated.
-- Convert CM to feet by dividing by 30.48. Convert KG to pounds by multiplying by 2.205

SELECT 
	  CONCAT(first_name, ' ', last_name) full_name
    , birth_date
    , ROUND((height / 30.48), 1) height
    , ROUND((weight * 2.205), 0) weight
    , CASE 
    	WHEN gender = 'M' THEN 'MALE'
        WHEN gender = 'F' THEN 'FEMALE' 
      END as gender
FROM patients

---------------------------------------------------- HARD ---------------------------------------------------- 

-- Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. Order the list by the weight group decending.
-- For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.

SELECT 
    patient_id, 
    weight, 
    height, 
    CASE 
        WHEN weight / POWER(height / 100.0, 2) >= 30 THEN 1 
        ELSE 0 
    END AS isObese
FROM patients

-- For each day display the total amount of admissions on that day. Display the amount changed from the previous date.

SELECT
 admission_date,
 COUNT(admission_date) as admission_day,
 COUNT(admission_date) - LAG(COUNT(admission_date)) OVER(ORDER BY admission_date) AS admission_count_change 
FROM admissions
GROUP BY admission_date

-- Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. Order the list by the weight group decending.
-- For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.

-- with cte as(
-- SELECT 
-- 	patient_id, weight,
--     CASE 
--     	WHEN weight BETWEEN 1 and 9 THEN 0
--         WHEN weight BETWEEN 10 and 19 THEN 10
--         WHEN weight BETWEEN 20 and 29 THEN 20
--         WHEN weight BETWEEN 30 and 39 THEN 30
--         WHEN weight BETWEEN 40 and 49 THEN 40
--         WHEN weight BETWEEN 50 and 59 THEN 50
--         WHEN weight BETWEEN 60 and 69 THEN 60
--         WHEN weight BETWEEN 70 and 79 THEN 70
--         WHEN weight BETWEEN 80 and 89 THEN 80
--         WHEN weight BETWEEN 90 and 99 THEN 90
--         WHEN weight BETWEEN 100 and 109 THEN 100
--         WHEN weight BETWEEN 110 and 119 THEN 110
--         WHEN weight BETWEEN 120 and 129 THEN 120
--         WHEN weight BETWEEN 130 and 139 THEN 130
--         WHEN weight BETWEEN 140 and 149 THEN 140
--      END AS weight_group
-- FROM patients
-- )

-- SELECT COUNT(patient_id), weight_group
-- FROM cte 
-- GROUP BY 2 
-- ORDER BY 2 DESC

SELECT
  COUNT(*) AS patients_in_group,
  FLOOR(weight / 10) * 10 AS weight_group
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

-- Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
-- Check patients, admissions, and doctors tables for required information.

select p.patient_id, p.first_name, p.last_name, d.specialty
FROM patients p
INNER JOIN (SELECT * FROM admissions wHERE diagnosis = 'Epilepsy') a ON a.patient_id = p.patient_id
INNER JOIN (SELECT * FROM doctors wHERE first_name = 'Lisa') d on d.doctor_id = a.attending_doctor_id

-- All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
-- The password must be the following, in order:
-- 1. patient_id
-- 2. the numerical length of patient's last_name
-- 3. year of patient's birth_date

SELECT 
	DISTINCT 
		p.patient_id, 
        CONCAT(p.patient_id, LEN(last_name), (YEAR(p.birth_date))) temp_password
FROM patients p
INNER JOIN admissions a on a.patient_id = p.patient_id

-- Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance. Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.

SELECT 
CASE 
  WHEN patient_id % 2 = 0 Then 'Yes' ELSE 'No' 
END as has_insurance,
SUM(CASE WHEN patient_id % 2 = 0 Then 10 ELSE 50 END) as cost_after_insurance
FROM admissions 
GROUP BY has_insurance;

-- Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name

with cte as(
  SELECT pn.province_name, 
  COUNT(CASE WHEN gender = 'M' THEN p.patient_id END) male_patients,
  COUNT(CASE WHEN gender = 'F' THEN p.patient_id END) female_patients
  FROM patients p
  LEFT JOIN province_names pn on pn.province_id = p.province_id
  GROUP BY 1
)

SELECT province_name 
FROM cte 
WHERE male_patients > female_patients

-- We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
-- - First_name contains an 'r' after the first two letters.
-- - Identifies their gender as 'F'
-- - Born in February, May, or December
-- - Their weight would be between 60kg and 80kg
-- - Their patient_id is an odd number
-- - They are from the city 'Kingston'

SELECT * 
FROM patients
WHERE 
	first_name LIKE ('__r%') 
    AND gender = 'F' 
    AND MONTH(birth_date) IN (2, 5, 12)
    AND weight BETWEEN 60 and 80
    AND (patient_id % 2 = 1)
    AND city = 'Kingston'

-- Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.

SELECT 
	CONCAT(
	CAST((ROUND((CAST(COUNT(distinct CASE WHEN gender = 'M' THEN patient_id END) AS DOUBLE)/ 
    COUNT(patient_id)), 4) * 100) aS STR), '%') AS percent_of_male_patients
FROM patients

-- Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.

SELECT province_name
FROM province_names
ORDER BY
  (CASE WHEN province_name = 'Ontario' THEN 0 ELSE 1 END)

-- We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.

SELECT d.doctor_id, CONCAT(first_name, ' ', last_name) AS full_name, d.specialty, 
YEAR(admission_date) admission_year, COUNT(*) total_admissions
FROM admissions a 
INNER JOIN doctors d on d.doctor_id = a.attending_doctor_id
GROUP BY 1, 2, 3, 4
