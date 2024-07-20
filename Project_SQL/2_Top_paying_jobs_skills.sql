/*
What skills are required for the top 10 paying jobs?
- Using top 10 higest paying roles
- Adding specific skills required for these roles along with companies
- This will give us more detail overview
*/;

WITH top_paying_jobs AS
(
    SELECT
        jp.job_id,
        jp.job_title_short,
        jp.salary_year_avg,
        jp.job_posted_date,
        companies.name AS Company_Name
    FROM
        job_postings_fact AS jp
    LEFT JOIN company_dim AS companies ON jp.company_id = companies.company_id
    WHERE
        salary_year_avg IS NOT NULL
    ORDER BY
        jp.salary_year_avg DESC

)
SELECT
        top_paying_jobs.*,
        skills_dim.skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC
Limit 10;