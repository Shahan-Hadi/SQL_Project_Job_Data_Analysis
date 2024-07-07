--Creating database
CREATE TABLE job_aaplied(
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name varchar(255),
    cover_letter_sent BOOLEAN,
    cover_letter_name varchar(255),
    status varchar(255)
);

INSERT INTO job_aaplied(
    job_id,
    application_sent_date,
    custom_resume,
    resume_file_name,
    cover_letter_sent,
    cover_letter_name,
    status
)
Values 
    (01,
    '2024-07-03',
    True,
    'Nihal Resume.pdf',
    False,
    'Nihal cover letter.pdf',
    'Pending'),
    (02,
    '2024-07-04',
    True,
    'Azan Resume.pdf',
    True,
    'Azan cover letter.pdf',
    'Submitted'),
    (03,
    '2024-07-05',
    True,
    'Sam Resume.pdf',
    False,
    'Sam cover letter.pdf',
    'Submitted'),
    (04,
    '2024-07-06',
    False,
    'Babar Resume.pdf',
    False,
    'Babar cover letter.pdf',
    'Pending'),
    (05,
    '2024-07-07',
    True,
    'Ripha Resume.pdf',
    True,
    'Ripha cover letter.pdf',
    'NULL'
);

--SQL Window Functions
--Alter to ADD, Rename, Alter Type and Drop Column
ALTER TABLE job_aaplied
ADD Contact varchar(25);


--Update to update and use where to specify column
Update job_aaplied
set Contact = 'Ramo Drapper'
where job_id = 1;

Update job_aaplied
set Contact = 'Big Head'
where job_id = 3;


--Rename Column
ALTER TABLE job_aaplied
Rename Contact to Contact_Name;


--ALTER DATA TYPE  (ALTER column column name Type datatype)
ALTER TABLE job_aaplied
ALTER column Contact_name Type TEXT;


--DROP Column
ALTER TABLE job_aaplied
DROP Column Contact_Name;

--DROP TABLE
