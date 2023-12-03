--
-- ЗАДАНИЕ 4
-- Написать запрос для получения месяца с наибольшим количеством вакансий и месяца с наибольшим количеством резюме

-----------------------------------------------------------------------------------------------------------------------

-- ВАКАНСИИ

WITH amount_by_month (first_month_day, amount)AS (
  SELECT
    CAST(DATE_TRUNC('month', vacancy.publication_time) AS DATE) AS first_month_day,
    COUNT(vacancy.id)                                           AS amount
  FROM vacancy
  GROUP BY first_month_day
)
SELECT
  first_month_day as result_date,
  CONCAT(TRIM(TO_CHAR(first_month_day,'Month')),' ', date_part('year', first_month_day)) as result_text
FROM amount_by_month
WHERE amount = (
  SELECT
    MAX(amount)
  FROM amount_by_month
);

------------------------------------------------------------------------------------------------------------------------

-- РЕЗЮМЕ

WITH amount_by_month (first_month_day, amount)AS (
    SELECT
        CAST(DATE_TRUNC('month', resume.publication_time) AS DATE) AS first_month_day,
        COUNT(resume.id)                                           AS amount
    FROM resume
    GROUP BY first_month_day
)
SELECT
    first_month_day as result_date,
    CONCAT(TRIM(TO_CHAR(first_month_day,'Month')),' ', date_part('year', first_month_day)) as result_text
FROM amount_by_month
WHERE amount = (
    SELECT
        MAX(amount)
    FROM amount_by_month
);
