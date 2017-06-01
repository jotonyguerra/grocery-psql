
DROP TABLE IF EXISTS groceries;
DROP TABLE IF EXISTS comments;
-- Define your schema here:

CREATE TABLE groceries (
  id SERIAL PRIMARY KEY,
  name VARCHAR(250) NOT NULL,
  comment_id INTEGER,
  UNIQUE(name)
);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  body VARCHAR(400),
  grocery_id INTEGER

);

-- The form should submit to POST /groceries, which will save the new item to the database.
-- Modify your Sinatra application so grocery items have comments. Modify your schema.sql file to create a new table for comments. Feel free to add a DROP TABLES line, so you can re-run your schema repeatedly.
-- Create a data.sql file. Write SQL statements to insert a grocery item, as well as insert two or more comments for that grocery item in the data.sql file. Add these records to the database by running the following command: psql grocery_list_development < data.sql
-- Clicking on a grocery item takes you to GET /groceries/:id.
-- Visiting GET /groceries/:id should display the name of the grocery, a list of comments on the grocery.
-- The list of comments must be retrieved using a SQL JOIN statement.
-- All acceptance tests passing.
