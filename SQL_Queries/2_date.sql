select job_posted_date
from job_postings_fact
limit 10;


--AN Example
SELECT 
    '2024-07-04'::DATE,
    '123'::INT,
    'True'::Boolean,
    '3.14'::float;


--DATE Problem
SELECT
    job_title_short AS Title,
    job_location AS Location,
    job_posted_date::DATE AS Date
FROM
    job_postings_fact
limit 200;


--AT TIME ZONE (select (column_name at time zone 'est') from table_name)
SELECT
    job_title_short AS Title,
    job_location AS Location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS Date
FROM
    job_postings_fact
limit 200;


--EXTRACT Example
SELECT
    job_title_short AS Title,
    job_location AS Location,
    job_posted_date AS Date,
    Extract(Month FROM job_posted_date) AS Month,
    EXTRACT(Year FROM job_posted_date) AS Year
FROM
    job_postings_fact
limit 200;


--Problem: How job postings are trending from month to month
SELECT
    count(job_id) as Jobs,
    EXTRACT(Month from job_posted_date) AS Month
From
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
Group BY
    Month
Order By 
    jobs DESC;



--Problem: find avg salary yearly and hourly
SELECT
    Round(AVG(salary_year_avg), 0) AS AVG_Yearly_Salary,
    job_schedule_type AS Job_Type,
    any_value(job_posted_date) AS Date,
    any_value(EXTRACT(Year from job_posted_date)) AS Year,
    any_value(EXTRACT(hour from job_posted_date)) AS hourly
FROM
    job_postings_fact
WHERE
    salary_year_avg is NOT NULL
    AND job_posted_date > '2023-06-01'
Group BY
    Job_Type;


--Problem Cont no of jobs adjusting timezone to America/Newyork. Group By Month
SELECT
    count(job_id) AS Jobs,
    any_value(job_posted_date AT TIME ZONE 'UTC') AS Date,
    EXTRACT(Month from job_posted_date) AS Month

FROM
    job_postings_fact
Group By
    Month
Order By
    Jobs DESC;


--Problem Create Tables from other tables
--Create three tables
--Jan 2023 jobs
--Feb 2023 jobs
--Mar 2023 jobs

-- January jobs
CREATE TABLE January_Jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- February jobs
CREATE TABLE February_Jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March jobs
CREATE TABLE March_Jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


SELECT * from February_Jobs;
    

