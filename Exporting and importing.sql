USE mydb;
CREATE TABLE CDs
(
CDID SMALLINT NOT NULL PRIMARY KEY,
CDName VARCHAR(50) NOT NULL,
InStock SMALLINT UNSIGNED NOT NULL,
Category VARCHAR(20)
);
INSERT INTO CDs
VALUES (101, 'Bloodshot', 10, 'Rock'),
(102, 'New Orleans Jazz', 17, 'Jazz'),
(103, 'Music for Ballet Class', 9, 'Classical'),
(104, 'Music for Solo Violin', 24, NULL),
(105, 'Mississippi Blues', 2, 'Blues'),
(106, 'Mud on the Tires', 12, 'Country'),
(107, 'The Essence', 5, 'New Age'),
(108, 'The Magic of Satie', 42, 'Classical'),
(109, 'La Boheme', 20, 'Opera'),
(110, 'Ain\’t Ever Satisfied', 23, 'Country'),
(111, 'Live in Paris', 18, 'Jazz'),
(112, 'Richland Woman Blues', 22, 'Blues'),
(113, 'Stages', 42, 'Blues');

	-- Exporting data --
SELECT @@GLOBAL.secure_file_priv;

SELECT CDName, InStock, Category INTO OUTFILE 'CDsOut.txt' FROM CDs;
SELECT CDName, InStock, Category INTO OUTFILE 'CDsOut.txt'
FIELDS
	TERMINATED BY ','
	ENCLOSED BY '“'
FROM CDs;

SELECT CDName, InStock, Category INTO OUTFILE 'CDsOut.txt'
LINES
	STARTING BY '*'
	TERMINATED BY '**'
FROM CDs

	-- Copying data into a table --
CREATE TABLE CDs2
(
CDID SMALLINT NOT NULL PRIMARY KEY,
CDName VARCHAR(50) NOT NULL,
InStock SMALLINT UNSIGNED NOT NULL
)
SELECT CDID, CDName, InStock FROM CDs
WHERE Category='Blues' OR Category='Jazz';

	-- Copying data into an existing table --
INSERT INTO CDs2 SELECT CDID, CDName, InStock FROM CDs
WHERE Category='Country' OR Category='Rock';
SELECT * FROM CDs2;

	-- Importing data into Table --
CREATE TABLE CDs3
(
CDName VARCHAR(50) NOT NULL,
InStock SMALLINT UNSIGNED NOT NULL,
Category VARCHAR(20)
);

SELECT CDName, InStock, Category INTO OUTFILE 'CDsBlues.sql'
FROM CDs WHERE Category='Blues';
LOAD DATA INFILE 'CDsBlues.sql'
INTO TABLE CDs3;
SELECT * FROM CDs3;
