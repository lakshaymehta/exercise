USE schm;

CREATE TABLE tastes 
(
  name VARCHAR(15) NOT NULL,
  filling VARCHAR(15) NOT NULL
);
INSERT INTO tastes(name, filling) VALUES ('Brown', 'Turkey'),
('Brown', 'Beef'),
('Brown', 'Ham'),
('Jones', 'Cheese'),
('Green', 'Beef'),
('Green', 'Turkey'),
('Green', 'Cheese');

CREATE TABLE locations 
(
  lname VARCHAR(15) NOT NULL PRIMARY KEY,
  phone INT NOT NULL ,
  address VARCHAR(45) NOT NULL
);
INSERT INTO locations (lname, phone, address) VALUES ('Lincoln', '6834523', 'Lincoln Place'),
('O\'Neill\'s', '6742134', 'Pearse St'),
('Old Nag', '7678132', 'Dame St'),
('Buttery', '7023421', 'College St');

CREATE TABLE sandwiches 
(
  location VARCHAR(15) NOT NULL,
  bread VARCHAR(15) NOT NULL,
  filling VARCHAR(45) NOT NULL,
  price INT NOT NULL,
  FOREIGN KEY (location) REFERENCES locations(lname)
);
INSERT INTO sandwiches (location, bread, filling, price) VALUES ('Lincoln', 'Rye', 'Ham', '1.25'),
('O\'Neill\'s', 'White', 'Cheese', 1.20),
('O\'Neill\'s', 'Whole', 'Ham', 1.25),
('Old Nag', 'Rye', 'Beef', 1.35),
('Buttery', 'White', 'Cheese', 1.00),
('O\'Neill\'s', 'White', 'Turkey', 1.35),
('Buttery', 'White', 'Ham', 1.10),
('Lincoln', 'Rye', 'Beef', 1.35),
('Lincoln', 'White', 'Ham', 1.3),
('Old Nag', 'Rye', 'Ham', 1.4);

	-- places where Jones can eat (using a nested subquery) --
SELECT DISTINCT location FROM sandwiches 
WHERE location IN 
(
SELECT location FROM sandwiches AS s, tastes AS t
WHERE s.filling=t.filling AND name='Jones'
);

	-- places where Jones can eat (without using a nested subquery) --
SELECT location FROM sandwiches AS s, tastes AS t
WHERE t.filling=s.filling AND t.name='jones';

	-- for each location the number of people who can eat there --
SELECT location, COUNT(distinct name) AS Total_no_of_People
FROM sandwiches AS s JOIN tastes AS t
WHERE s.filling=t.filling
GROUP BY location;
