/*
What skills are required for the top paying jobs?
- Using top 10 higest paying roles
- Adding specific skills required for these roles
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
        job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'  --Anywhere represents Remote jobs in database
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT
        top_paying_jobs.*,
        skills_dim.skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC;

/*
Observations:

Top Skills:
sql (8 occurrences)
python (7 occurrences)
tableau (6 occurrences)
r (4 occurrences)
*/