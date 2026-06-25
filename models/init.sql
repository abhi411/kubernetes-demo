CREATE TABLE demo_table (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  value VARCHAR(50)
);

INSERT INTO demo_table (name, value) VALUES
('Alpha','One'),
('Beta','Two'),
('Gamma','Three'),
('Delta','Four'),
('Epsilon','Five');
