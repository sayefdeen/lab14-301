-- This will Create a new data base called lab14
CREATE DATABASE lab14;

-- Connect your schema.sql to your database using the following command
-- psql -f /data/schema.sql -d lab14
-- psql -f /data/seed.sql -d lab14

-- Make sure that our table has a data

SELECT COUNT(*)
FROM books;

-- Create a new database template from the previous database

CREATE DATABASE lab14_normal WITH TEMPLATE
lab14;

-- Make sure that out new data base has data/after switching for the new database

SELECT COUNT(*) FORM
books;

-- Datebase Migration

-- This will create a table named authors with an id as primary key and a name column
CREATE TABLE authors
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

-- This query will insert into authors table (name) column the selected author names from the books table

INSERT INTO authors
    (name)
SELECT DISTINCT author
FROM books;

-- This will add a new column to the books table called author_id type interger

ALTER TABLE books ADD COLUMN author_id INT;

-- This query will prepare a connection between the two tables, it will set author_id in the users author_id that was selected from the authors table itself. 

UPDATE books SET author_id=author.id FROM (SELECT *
    FROM authors) AS author WHERE books.author = author.name;

-- This will drop the author column from the books table

ALTER TABLE books DROP COLUMN author;

-- This will change the books table authors id column and make it as foregin key to the authors table for the authors_id itself

ALTER TABLE books ADD CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors(id);


