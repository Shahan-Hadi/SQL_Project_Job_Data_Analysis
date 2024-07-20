/*
What are the most optimal skills to learn(aka its high_in_demand and also high_paying_skill)?
- Combining both top_demanded_skills and top_paying_skills_based_on_salary for more optimal findings
*/;

WITH demand_skill AS
(
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills) AS skills_demand_count
    FROM
        job_postings_fact AS jp
    INNER JOIN skills_job_dim ON jp.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
         salary_hour_avg IS NOT NULL
    Group BY
        skills_dim.skill_id
), top_payable_avg_skills AS
(
    SELECT
        skills_job_dim.skill_id,
        Round(avg(salary_year_avg), 0) AS Average_Salary
    FROM
        job_postings_fact AS jp
    INNER JOIN skills_job_dim ON jp.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
         salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id
)
SELECT
    demand_skill.skill_id,
    demand_skill.skills,
    demand_skill.skills_demand_count,
    top_payable_avg_skills.Average_Salary
FROM
    demand_skill
INNER JOIN top_payable_avg_skills ON demand_skill.skill_id = top_payable_avg_skills.skill_id
ORDER BY
    demand_skill.skills_demand_count DESC,
    top_payable_avg_skills.Average_Salary DESC