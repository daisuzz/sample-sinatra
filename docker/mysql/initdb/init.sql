DROP SCHEMA IF EXISTS sample;
CREATE SCHEMA sample;
USE sample;

DROP TABLE IF EXISTS todo;
CREATE TABLE todo
(
    id      VARCHAR(255) primary key,
    title   VARCHAR(255),
    dueDate TIMESTAMP,
    isDone  BIT DEFAULT false
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO todo (id, title, dueDate) VALUES ('01fefcbf-248b-427a-a370-d77f77744772', '食べる', '2021-01-01T00:00:00');
INSERT INTO todo (id, title, dueDate) VALUES ('94f570f9-65c1-4cdc-a900-03970149b391', '走る', '2021-01-02T00:00:00');
INSERT INTO todo (id, title, dueDate) VALUES ('6b568cd2-ca7b-463f-8f18-72568305ecbe', '寝る', '2021-01-03T00:00:00');
