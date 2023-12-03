--
-- ЗАДАНИЕ 5
-- Написать запрос для получения id и title вакансий, которые собрали больше 5 откликов в первую неделю после публикации

-----------------------------------------------------------------------------------------------------------------------

SELECT
  response.vacancy_id AS vacancy_id,
  vacancy.title       AS vacancy_title,
  COUNT(response.id)  AS response_amount
FROM response
INNER JOIN vacancy ON response.vacancy_id = vacancy.id
WHERE response.response_time <= vacancy.publication_time + INTERVAL '1 week'
GROUP BY response.vacancy_id, vacancy.title
HAVING COUNT(response.id) > 5
ORDER BY vacancy_id;

-- Проверочный запрос (подставить любой полученный id вакансии из результата выше)
SELECT
  response.id                                                             AS response_id,
  response.vacancy_id                                                     AS vacancy_id,
  vacancy.publication_time                                                AS publication_date,
  response.response_time                                                  AS response_date,
  response.response_time::TIMESTAMP - vacancy.publication_time::TIMESTAMP AS response_lag
FROM response
INNER JOIN vacancy ON response.vacancy_id = vacancy.id
WHERE response.vacancy_id = 7
ORDER BY response_time;