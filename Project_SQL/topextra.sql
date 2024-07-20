/*
What are top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst Role
- Focuses on roles with specified salaries, regardless of location
- This willl reveal how different skills impact job salary levels and will help to identify most financially rewarding skills
*/;

SELECT
    job_title_short,
    skills,
    Round(avg(salary_year_avg), 0) AS Average_Salary

FROM
    job_postings_fact AS jp
INNER JOIN skills_job_dim ON jp.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    (job_title_short = 'Data Analyst'
    OR job_title_short = 'Data Scientist')
    ANDsalary_year_avg IS NOT NULL
GROUP BY
    job_title_short,
    skills
    
ORDER BY
    Average_Salary DESC
