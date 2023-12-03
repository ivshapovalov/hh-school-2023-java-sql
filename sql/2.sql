--
-- ЗАДАНИЕ 2
-- Заполнить базу данных тестовыми данными (порядка 10к вакансий и 100к резюме)

-----------------------------------------------------------------------------------------------------------------------

-- AREA
WITH area_series(area_id) AS (
  SELECT
    GENERATE_SERIES(1, 100) AS area_id
)
INSERT
INTO area(id, name)
  SELECT
    area_id                     AS id,
    CONCAT('Регион ', area_id)  AS name
  FROM area_series;

-- EMPLOYER
WITH employer_series(employer_id) AS (
  SELECT
    GENERATE_SERIES(1, 10000) AS employer_id
)
INSERT
INTO employer(id, name, email, password)
  SELECT
    employer_id                                    AS id,
    CONCAT('Работодатель ', employer_id)           AS name,
    CONCAT('employer_', employer_id, '@gmail.com') AS email,
    MD5(RANDOM()::TEXT)                            AS password
  FROM employer_series;

-- EMPLOYEE
WITH employee_series(employee_id) AS (
  SELECT
    GENERATE_SERIES(1, 100000) AS employee_id
)
INSERT
INTO employee(id, name, email, password)
  SELECT
    employee_id                                    AS id,
    CONCAT('Соискатель ', employee_id)             AS name,
    CONCAT('employee_', employee_id, '@gmail.com') AS email,
    MD5(RANDOM()::TEXT)                            AS password
  FROM employee_series;

-- SPECIALIZATION
WITH specialization_series(specialization_id) AS (
  SELECT
    GENERATE_SERIES(1, 100) AS specialization_id
)
INSERT
INTO specialization(id, name)
SELECT
    specialization_id                           AS id,
    CONCAT('Специализация ', specialization_id) AS name
FROM specialization_series;

-- VACANCY
WITH vacancy_series(vacancy_id, specialization_id, area_id, employer_id, publication_time, salary) AS (
  SELECT
    GENERATE_SERIES(1, 10000)            AS vacancy_id,
    ROUND((RANDOM() * 99)::INT, 0) + 1   AS specialization_id,
    ROUND((RANDOM() * 99)::INT, 0) + 1   AS area_id,
    ROUND((RANDOM() * 9999)::INT, 0) + 1 AS employer_id,
    DATE_TRUNC('year', NOW()) + (RANDOM() * (DATE_TRUNC('year', NOW()) + '365 days' - DATE_TRUNC('year', NOW()))) AS publication_time,
    ROUND((RANDOM() * 100000)::INT, -3)  AS salary
)
INSERT
INTO vacancy(id, title, description, publication_time, specialization_id, area_id, employer_id, compensation_from,
             compensation_to)
SELECT
    vacancy_id                               AS id,
    CONCAT('Вакансия ', vacancy_id)          AS title,
    CONCAT('Описание вакансии ', vacancy_id) AS description,
    publication_time                         AS publication_time,
    specialization_id                        AS specialization_id,
    area_id                                  AS area_id,
    employer_id                              AS employer_id,
    salary                                   AS compensation_from,
    salary + 20000                           AS compensation_to
FROM vacancy_series;

-- RESUME
WITH resume_series(resume_id, specialization_id, area_id, employee_id, publication_time, salary) AS (
  SELECT
    GENERATE_SERIES(1, 100000)            AS resume_id,
    ROUND((RANDOM() * 99)::INT, 0) + 1    AS specialization_id,
    ROUND((RANDOM() * 99)::INT, 0) + 1    AS area_id,
    ROUND((RANDOM() * 99999)::INT, 0) + 1 AS employee_id,
    DATE_TRUNC('year', NOW()) + (RANDOM() * (DATE_TRUNC('year', NOW()) + '365 days' - DATE_TRUNC('year', NOW()))) AS publication_time,
    ROUND((RANDOM() * 100000)::INT, -3)   AS salary
)
INSERT
INTO resume(id, title, description, publication_time, specialization_id, area_id, employee_id, compensation_from, compensation_to)
SELECT
    resume_id                             AS id,
    CONCAT('Резюме ', resume_id)          AS title,
    CONCAT('Описание резюме ', resume_id) AS description,
    publication_time                      AS publication_time,
    specialization_id                     AS specialization_id,
    area_id                               AS area_id,
    employee_id                           AS employee_id,
    salary                                AS compensation_from,
    salary + 20000                        AS compensation_to
FROM resume_series;

-- RESPONSE
WITH response_series(response_id, vacancy_id, lag_days, lag_hours) AS (
  SELECT
    GENERATE_SERIES(1, 100000)           AS response_id,
    ROUND((RANDOM() * 9999)::INT, 0) + 1 AS vacancy_id,
    ROUND((RANDOM() * 14)::INT, 0)       AS lag_days,
    ROUND((RANDOM() * 24)::INT, 0)       AS lag_hours
), response_series_with_resume(response_id, vacancy_id, resume_id, response_time) AS (
  SELECT DISTINCT ON (response_series.response_id,response_time,response_series.vacancy_id)
    response_series.response_id AS response_id,
    response_series.vacancy_id AS vacancy_id,
    resume.id AS resume_id,
    vacancy.publication_time + response_series.lag_days * INTERVAL '1 day' + response_series.lag_hours * INTERVAL '1 hour' AS response_time
  FROM response_series
  INNER JOIN vacancy ON response_series.vacancy_id = vacancy.id
  INNER JOIN (
    SELECT
      id AS id,
      specialization_id AS specialization_id
    FROM resume
    ORDER BY RANDOM()
  ) AS resume USING (specialization_id)
)
INSERT
INTO response(id, description, vacancy_id, resume_id, response_time)
SELECT
  response_series_with_resume.response_id,
  CONCAT('Отклик ', response_series_with_resume.resume_id) AS description,
  response_series_with_resume.vacancy_id AS vacancy_id,
  response_series_with_resume.resume_id AS resume_id,
  response_series_with_resume.response_time AS response_time
FROM response_series_with_resume
ORDER BY resume_id;
