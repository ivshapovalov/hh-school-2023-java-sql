--
-- ЗАДАНИЕ 6
-- Создать необходимые индексы (обосновать выбор столбцов)

-----------------------------------------------------------------------------------------------------------------------

--Решение
-- Для решения текущих задач я не вижу необходимых индексов

-----------------------------------------------------------------------------------------------------------------------

-- Для решения возможных задач индексы могут быть

-- Поиск/сортировка/фильтр региона по имени
CREATE INDEX area_name_idx ON area (name);

-- Поиск специализации по имени
CREATE INDEX specialization_name_idx ON specialization (name);

-- Поиск/сортировка/фильтр работодателя по имени/email
CREATE INDEX employer_name_idx ON employer (name);
CREATE INDEX employer_email_idx ON employer (email);

-- Поиск/сортировка/фильтр сотрудника по имени/email
CREATE INDEX employee_name_idx ON employee (name);
CREATE INDEX employee_email_idx ON employee (email);

-- Поиск/сортировка/фильтр вакансси по дате публикации/заголовку/компенсации
CREATE INDEX vacancy_publication_time_idx ON vacancy (publication_time);
CREATE INDEX vacancy_title_idx ON vacancy (title);
CREATE INDEX vacancy_compensation_idx ON vacancy (compensation_from, compensation_to);
CREATE INDEX vacancy_compensation_from_idx ON vacancy (compensation_from);
CREATE INDEX vacancy_compensation_to_idx ON vacancy (compensation_to);

-- Поиск/сортировка/фильтр резюме по дате публикации/заголовку/компенсации
CREATE INDEX resume_publication_time_idx ON resume (publication_time);
CREATE INDEX resume_title_idx ON resume (title);
CREATE INDEX resume_compensation_idx ON resume (compensation_from, compensation_to);
CREATE INDEX resume_compensation_from_idx ON resume (compensation_from);
CREATE INDEX resume_compensation_to_idx ON resume (compensation_to);

-- Поиск/сортировка/фильтр откликам по дате отклика
CREATE INDEX response_time_idx ON response (response_time);

-----------------------------------------------------------------------------------------------------------------------
