--
-- ЗАДАНИЕ 1
-- Спроектировать базу данных hh (основные таблицы: вакансии, резюме, отклики, специализации). По необходимым столбцам ориентироваться на сайт hh.ru

-----------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS response;

DROP TABLE IF EXISTS vacancy;

DROP TABLE IF EXISTS resume;

DROP TABLE IF EXISTS specialization;

DROP TABLE IF EXISTS employer;

DROP TABLE IF EXISTS employee;

DROP TABLE IF EXISTS area;

CREATE TABLE area
(
  id   SERIAL PRIMARY KEY,
  name VARCHAR(200) NOT NULL
);

CREATE TABLE employer
(
  id       SERIAL PRIMARY KEY,
  name     VARCHAR(200) NOT NULL,
  email    VARCHAR(200) NOT NULL UNIQUE CHECK (email LIKE '%_@__%.__%'),
  password VARCHAR(200) NOT NULL
);

CREATE TABLE employee
(
  id       SERIAL PRIMARY KEY,
  name     VARCHAR(200) NOT NULL,
  email    VARCHAR(200) NOT NULL UNIQUE CHECK (email LIKE '%_@__%.__%'),
  password VARCHAR(200) NOT NULL
);

CREATE TABLE specialization
(
  id   SERIAL PRIMARY KEY,
  name VARCHAR(200) NOT NULL
);

CREATE TABLE vacancy
(
  id                SERIAL PRIMARY KEY,
  title             VARCHAR(200),
  description       TEXT,
  publication_time  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  compensation_from INT       NOT NULL,
  compensation_to   INT       NOT NULL,
  employer_id       INTEGER   NOT NULL REFERENCES employer (id) ON DELETE CASCADE ON UPDATE CASCADE,
  specialization_id INTEGER   NOT NULL REFERENCES specialization (id) ON DELETE CASCADE ON UPDATE CASCADE,
  area_id           INTEGER   NOT NULL REFERENCES area (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE resume
(
  id                SERIAL PRIMARY KEY,
  title             VARCHAR(200) NOT NULL,
  description       TEXT,
  publication_time  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  compensation_from INT          NOT NULL,
  compensation_to   INT          NOT NULL,
  specialization_id INTEGER      NOT NULL REFERENCES specialization (id) ON DELETE CASCADE ON UPDATE CASCADE,
  employee_id       INTEGER      NOT NULL REFERENCES employee (id) ON DELETE CASCADE ON UPDATE CASCADE,
  area_id           INTEGER      NOT NULL REFERENCES area (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE response
(
  id            SERIAL PRIMARY KEY,
  response_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  description   TEXT,
  vacancy_id    INTEGER REFERENCES vacancy (id) ON DELETE CASCADE ON UPDATE CASCADE,
  resume_id     INTEGER REFERENCES resume (id) ON DELETE CASCADE ON UPDATE CASCADE
);
