/*
Top demanded skills based on skills count
Including all job postings
*/;

SELECT
    skills,
    count(skills) AS skills_count
FROM
    job_postings_fact AS jp
INNER JOIN skills_job_dim ON jp.job_id = skills_job_dim.job_id
INNER JOIN skills_dim AS skills ON skills_job_dim.skill_id = skills.skill_id
Group BY
    skills
ORDER BY
    skills_count DESC;
