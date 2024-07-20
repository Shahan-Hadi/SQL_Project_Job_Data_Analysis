/*
What are the top paying jobs?
- Identigy top 10 highest paying Data Analyst roles that are avaliable remotely
- Focuses on job with postings with specified salaries (remove nulls)
- why? Highlight the top paying opportunities for Data Analysts
*/;

SELECT
    jp.job_id,
    jp.job_location,
    jp.job_title_short,
    jp.salary_year_avg,
    jp.job_posted_date,
    jp.job_schedule_type,
    companies.name AS Company_Name
FROM
    job_postings_fact jp
LEFT JOIN company_dim AS companies
ON jp.company_id = companies.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'  --Anywhere represents Remote jobs in database
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
limit 10;