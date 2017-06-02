INSERT INTO groceries (name) VALUES ('taco');
INSERT INTO comments (body, grocery_id) VALUES  ('Are the best',  (SELECT id from groceries WHERE name = 'taco'));
