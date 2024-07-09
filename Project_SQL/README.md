# Introduction
Dive into the data job market! Focusing mostly on data analyst roles, this project explores and showcases top paying jobs, top paying skills based on job and salary and when high demand meets high salary

SQL queries? Check them out here: [Project_SQL folder](/Project_SQL/)

# Background
This project emerged from the need to better navigate the data analyst job market. It aims to identify top-paying and in-demand skills, making it easier for others to find optimal job opportunities. By analyzing job postings, we seek to streamline the job search process and highlight key skills that can enhance career prospects in the data analytics field.

### THe questions I wanted to answer through my SQL queries were:
1. What are the top-paying Data Analyst jobs?
2. What skills are required for the top paying jobs?
3. What skills are required for the top paying jobs
4. What are top skills based on salary?
5. What are the most optimal skills to learn(aka its high_in_demand and high_paying_skill)?

# Tools I Used
For my deepdiveinto the data analyst jpb market, I harnesses the power of several key tools:

- **SQL**: The backbone of my analysis, allowing me to query the database and unwarth critical insights.
- **PostgreSQL**: The database management system, ideak for handking the job posting data.
- **Visual studio code**: My go-to for database management and executing SQL queries.
- **Git and GitHub**: Essentil for version control and sharing my SQL scripts and analysis,  ensuring collaborarion amnd project tracking.


# Analysis
Each query in this project was crafted to dig into the many facets of the data analyst job market. Here’s the breakdown of my approach:

### 1. Identifying Top-Paying Data Analyst Jobs:
**Objective**: Find out which job postings are offering the fattest paychecks for data analysts.

**Approach**: Zero in on average salary figures and spotlight the highest-paying gigs while focusing on Remote Jobs.
```sql
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
```


### 2. Top paying skills on bases of jobs
**Objective**: Objective: Determine the specific skills demanded by the top 10 highest-paying data analyst positions, providing a detailed overview of essential expertise for these lucrative roles.

**Approach**: Filtered the job postings to isolate the top 10 highest-paying data analyst roles.
Linked these high-paying roles with their required skills using joins between job postings and skills tables.

```sql
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
```


### 3. In-Demand Skills:
**Objective**: Identify which skills are most frequently required in job postings for data analysts.

**Approach**: Count the occurrences of each skill across job postings and rank them to find the most sought-after skills.


```sql
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
```


### 4. Financial Impact of Top Skills
**Objective**: Uncover the average salary associated with each skill in data analyst roles to identify which skills are the most financially rewarding.

**Approach**: Analyzed the average salary tied to each skill across all data analyst positions with specified salaries.
Focused on roles with specified salaries to gauge how different skills influence earning potential.


```sql
SELECT
    skills,
    Round(avg(salary_year_avg), 0) AS Average_Salary

FROM
    job_postings_fact AS jp
INNER JOIN skills_job_dim ON jp.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    Average_Salary DESC
LIMIT 20;
```


### 5. Skills and Salary Correlation:
**Objective**: Explore how different skills stack up against salary levels for data analysts.

**Approach**: Merge salary data with skill sets to analyze which skills are driving the highest pay.


```sql
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
        job_title_short = 'Data Analyst'
        AND salary_hour_avg IS NOT NULL
        AND job_work_from_home = TRUE
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
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
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
    top_payable_avg_skills.Average_Salary DESC;
```


# Conclusions
### Insights
From the analysis, several general insghts emerged:

1. **Identifying Top-Paying Jobs**:
High-paying job postings for data analysts are dominated by roles that offer competitive salaries and premium compensation packages.

2. **Top Paying Skills Based on Jobs**:
The top 10 highest-paying data analyst roles require a combination of advanced technical and analytical skills, with SQL, Python, and Tableau being particularly prevalent.

3. **In-Demand Skills**:
Certain skills, like data manipulation, visualization, and programming languages, appear repeatedly in job postings, highlighting their necessity in the data analyst job market.

4. **Financial Impact of Top Skills**:
Skills that command the highest salaries include advanced data analysis and programming capabilities, significantly boosting earning potential.

5. **Skills and Salary Correlation**:
There is a strong correlation between specific skills and higher salary levels, with certain technical proficiencies leading to better compensation.

### Closing Thoughts
This project has enhanced my sql skills and provided a comprehensive overview of the data analyst job market, highlighting critical insights into top-paying roles and in-demand skills. By analyzing various aspects such as salary levels, skill requirements, and job locations, we have identified key trends that can guide job seekers and employers alike. The findings underscore the importance of possessing advanced technical skills and staying updated with industry demands to secure lucrative positions. Overall, this analysis not only sheds light on the current job landscape but also equips individuals with valuable information to navigate their career paths more effectively.
