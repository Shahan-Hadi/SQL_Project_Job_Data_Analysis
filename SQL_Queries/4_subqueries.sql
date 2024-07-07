--01 SubQueries
SELECT *
FROM (
    SELECT
        *
    FROM
        job_postings_fact
    WHERE
        EXTRACT(Month from job_posted_date) = 1) AS Jan_Jobs;


--02 SubQueries
--Take out companies on basis of no_degrees_mention
SELECT
    name AS Company_Name
FROM
    company_dim
WHERE company_id IN(
SELECT
    company_id
FROM
    job_postings_fact
WHERE job_no_degree_mention is TRUE);




--01 CTE's
with Janry_Jobs AS(
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(Month from job_posted_date) = 1 )

select * from Janry_Jobs;

--02 CTE's
/*
Find companies that have the most jb openings
Get the total no. of job postings per company_id
Return total no. of jobs with companies names
*/
WITH company_jobs_count AS (
    SELECT
        company_id,
        count(*) AS Total_Jobs
    From 
        job_postings_fact
    Group BY
        company_id
    ORDER BY
        company_id
)
SELECT
    company_dim.name AS Company_Name,
    company_jobs_count.Total_Jobs
FROM
    company_dim
LEFT JOIN company_jobs_count
ON company_jobs_count.company_id = company_dim.company_id
ORDER BY
    Total_Jobs DESC;


--Problem
/*
Find the count of Remote job postings per skill
*/
WITH remote_jobs AS (
    SELECT 
        skills.skill_id,
        jp.job_location
    FROM
        skills_job_dim AS skills
    INNER JOIN job_postings_fact AS jp
    ON skills.job_id = jp.job_id
)

SELECT 
    skills_dim.skills AS SKill,
    count(remote_jobs.job_location) AS count_Remote_jobs
FROM
    skills_dim
INNER JOIN remote_jobs 
ON skills_dim.skill_id = remote_jobs.skill_id
WHERE
    remote_jobs.job_location = 'Anywhere'
GROUP BY
    skill
ORDER BY
    count_Remote_jobs DESC;



----------------------
----------------------
--Same as above just a different approach
WITH remote_jobs AS (
    SELECT 
        skills.skill_id,
        jp.job_work_from_home
    FROM
        skills_job_dim AS skills
    INNER JOIN job_postings_fact AS jp
    ON skills.job_id = jp.job_id
)

SELECT 
    skills_dim.skills AS Skill,
    count(remote_jobs.job_work_from_home) AS Count_Remote_jobs
FROM
    skills_dim
INNER JOIN remote_jobs 
ON skills_dim.skill_id = remote_jobs.skill_id
WHERE
    remote_jobs.job_work_from_home = 'True'
GROUP BY
    skill
ORDER BY
    Count_Remote_jobs DESC
limit 5;
