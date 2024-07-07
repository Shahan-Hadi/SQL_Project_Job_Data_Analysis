/*
    CASE
    WHEN
    THEN
    ELSE
    END
*/;

--Problem
SELECT
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' Then 'Remote'
        WHEN job_location = 'New York' Then 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact;


--Problem
SELECT
    count(job_id) AS Total_Jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END location_category
FROM
    job_postings_fact
GROUP BY
    location_category;


--Problem
SELECT
    count(job_id) AS Total,
    CASE
        WHEN job_location = 'Anywhere' Then 'Remote'
        WHEN job_location = 'New York, NY' Then 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
Group BY
    location_category;


/*Prblem: Categorize salries from each job posting to see it its desired salary range
Put saalries into buckets
Define whats low, standard, high ranges
Wnat to look for data analyst roles only
*/

SELECT
    job_title_short AS Title,
    count(salary_year_avg) AS Total,
    CASE
        WHEN salary_year_avg < 70000 THEN 'LOW RANGE'
        WHEN salary_year_avg BETWEEN 50000 AND 100000 THEN 'Standard Range'
        Else 'High Range'
    END AS salary_range
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    salary_range,
    Title;

