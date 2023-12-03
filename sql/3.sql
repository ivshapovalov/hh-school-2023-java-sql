--
-- ЗАДАНИЕ 3
-- Написать запрос для получения средних значений по регионам (area_id) следующих величин:
-- compensation_from,
-- compensation_to,
-- среднее_арифметическое_from_и_to

-----------------------------------------------------------------------------------------------------------------------

-- Вариант 1
SELECT
  vacancy.area_id                                          AS area_id,
  area.name                                                AS area_name,
  ROUND(AVG(compensation_from), 0)                         AS avg_compensation_from,
  ROUND(AVG(compensation_to), 0)                           AS avg_compensation_to,
  ROUND(AVG((compensation_from + compensation_to) / 2), 0) AS avg_compensation
FROM vacancy
LEFT JOIN area ON vacancy.area_id = area.id
GROUP BY vacancy.area_id, area.name
ORDER BY vacancy.area_id;

-- Вариант 2
SELECT
  avg_by_area.area_id                AS area_id,
  area.name                          AS area_name,
  avg_by_area.avg_compensation_from  AS avg_compensation_from,
  avg_by_area.avg_compensation_to    AS avg_compensation_to,
  avg_by_area.avg_compensation       AS avg_compensation
FROM (
  SELECT
    area_id                                                       AS area_id,
    ROUND(AVG(compensation_from), 0)                              AS avg_compensation_from,
    ROUND(AVG(compensation_to), 0)                                AS avg_compensation_to,
    ROUND((AVG(compensation_from) + AVG(compensation_to)) / 2, 0) AS avg_compensation
  FROM vacancy
  GROUP BY vacancy.area_id) AS avg_by_area
LEFT JOIN area ON avg_by_area.area_id = area.id
ORDER BY avg_by_area.area_id;

-- Вариант 3
WITH avg_by_area(area_id, avg_compensation_from, avg_compensation_to, avg_compensation) AS (
  SELECT
    area_id                                                       AS area_id,
    ROUND(AVG(compensation_from), 0)                              AS avg_compensation_from,
    ROUND(AVG(compensation_to), 0)                                AS avg_compensation_to,
    ROUND((AVG(compensation_from) + AVG(compensation_to)) / 2, 0) AS avg_compensation
  FROM vacancy
  GROUP BY vacancy.area_id
)
SELECT
  avg_by_area.area_id                  AS area_id,
  area.name                            AS area_name,
  avg_by_area.avg_compensation_from    AS avg_compensation_from,
  avg_by_area.avg_compensation_to      AS avg_compensation_to,
  avg_by_area.avg_compensation         AS avg_compensation
FROM avg_by_area
LEFT JOIN area ON avg_by_area.area_id = area.id
ORDER BY avg_by_area.area_id;



