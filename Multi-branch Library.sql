USE schm;

CREATE TABLE branches 
( 
bcode VARCHAR(4) NOT NULL PRIMARY KEY,
librarian VARCHAR(45) NULL,
address VARCHAR(45) NULL
);

INSERT INTO branches VALUE ('B1', 'John Smith', '2 Anglesea Rd'),
('B2', 'Mary Jones', '34 Pearse St'),
('B3', 'Francis Owens', 'Grange X');

CREATE TABLE titles 
(
title VARCHAR(45) NOT NULL PRIMARY KEY,
author VARCHAR(45) NULL,
publisher VARCHAR(45) NULL
);

INSERT INTO titles VALUE ('Susannah', 'Ann Brown', 'Macmillan'),
('How to Fish', 'Amy Fly', 'Stop Press'), 
('A History of Dublin', 'David Little', 'Wiley'),
('Computers', 'Blaise Pascal', 'Applewoods'),
('the Wife', 'Ann Brown', 'Macmillan');

CREATE TABLE holdings 
(
branch VARCHAR(4) NOT NULL,
title VARCHAR(45) NULL,
copies VARCHAR(45) NULL,
FOREIGN KEY (branch) REFERENCES branches (bcode),
FOREIGN KEY (title) REFERENCES titles (title)
);

INSERT INTO holdings VALUE ('B1', 'Susannah', 3),
('B1', 'How to Fish', 2),
('B1', 'A History of Dublin', 1),
('B2', 'How to Fish', 4),
('B2', 'Computers', 2),
('B2', 'the Wife', 3),
('B3', 'A History of Dublin', 1),
('B3', 'Computers', 4),
('B3', 'Susannah', 3),
('B3', 'the Wife', 1);

	-- the names of all library books published by Macmillan --
SELECT title from titles
WHERE publisher='Macmillan';

	-- branches that hold any books by Ann Brown (using a nested subquery) --
SELECT DISTINCT branch from holdings
WHERE branch IN
(
SELECT branch FROM titles, holdings
WHERE titles.title=holdings.title AND author='Ann Brown'
);

	-- branches that hold any books by Ann Brown (without using a nested subquery) --
SELECT branch, t.title FROM holdings AS h JOIN titles AS t
ON h.title=t.title 
WHERE t.author='Ann Brown'
ORDER BY branch;

	-- the total number of books held at each branch --
SELECT branch, SUM(copies) FROM holdings GROUP BY branch;
