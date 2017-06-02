
DROP TABLE IF EXISTS groceries CASCADE;
DROP TABLE IF EXISTS comments CASCADE;
-- Define your schema here:

CREATE TABLE groceries (
  id SERIAL PRIMARY KEY,
  name VARCHAR(250) NOT NULL
);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  body VARCHAR(400),
  grocery_id INTEGER REFERENCES groceries(id)
);
