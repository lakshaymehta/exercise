SELECT 'lakshay';
SELECT "I'm asleep", 'He said, "Boo!"';
	
    -- Comparison function (GEATEST & LEAST) --
SELECT GREATEST(4, 83, 0, 9, -3);
SELECT LEAST(4, 83, 0, 9, -3);
SELECT COALESCE(NULL, 10, NULL, 3);
SELECT ISNULL(1*NULL);
SELECT INTERVAL(6,-2,0,4,9,10,12);
SELECT STRCMP('big', 'bigger');
SELECT IF(10>20, 'expression correct', 'expression incorrect');
SELECT IFNULL(10*NULL, 'expression incorrect');
SELECT NULLIF(10*20, 20*10);
SELECT CASE WHEN 10*2=30 THEN '30 correct'
WHEN 10*2=40 THEN '40 correct'
ELSE 'Should be 10*2=20'
END;
SELECT CASE 10*2
WHEN 20 THEN '20 correct'
WHEN 30 THEN '30 correct'
WHEN 40 THEN '40 correct'
END;
SELECT CAST(20041031 AS DATE);

	-- String function --
SELECT ASCII('book');
SELECT ORD(37);
SELECT CHAR_LENGTH('cats and dogs');
SELECT CHARSET('cats and dogs');
SELECT COLLATION('cats and dogs');
SELECT CONCAT('cats', ' ', 'and', ' ', 'dogs');
SELECT CONCAT_WS(' ', 'cats', 'and', 'dogs');
SELECT INSTR('cats and dogs', 'dogs');
SELECT LOCATE('dogs', 'cats and dogs');

	-- Summarizing data --
CREATE TABLE Classes
(
ClassID SMALLINT NOT NULL PRIMARY KEY,
Dept CHAR(4) NOT NULL,
lvl ENUM('Upper', 'Lower') NOT NULL,
TotalStudents TINYINT UNSIGNED NOT NULL
);
INSERT INTO Classes
VALUES (1001, 'ANTH', 'Upper', 25),
(1002, 'ANTH', 'Upper', 25),
(1003, 'MATH', 'Upper', 18),
(1004, 'ANTH', 'Lower', 19),
(1005, 'ENGL', 'Upper', 28),
(1006, 'MATH', 'Lower', 23),
(1007, 'ENGL', 'Upper', 25),
(1008, 'MATH', 'Lower', 29),
(1009, 'ANTH', 'Upper', 25),
(1010, 'ANTH', 'Lower', 30),
(1011, 'ENGL', 'Lower', 26),
(1012, 'MATH', 'Lower', 22),
(1013, 'ANTH', 'Upper', 27),
(1014, 'ANTH', 'Upper', 21),
(1015, 'ENGL', 'Lower', 25),
(1016, 'ENGL', 'Upper', 32);

SELECT Dept, Lvl, ROUND(AVG(TotalStudents)) AS Average FROM Classes
GROUP BY Dept, Lvl WITH ROLLUP;

SELECT Dept, Lvl, SUM(TotalStudents) AS Total FROM Classes
GROUP BY Dept, Lvl WITH ROLLUP;

SELECT Dept, Lvl, MIN(TotalStudents) AS Minimum FROM Classes
GROUP BY Dept, Lvl WITH ROLLUP;

SELECT Dept, Lvl, COUNT(*) AS NumberClasses FROM Classes
GROUP BY Dept, Lvl WITH ROLLUP;

SELECT Dept, Lvl, BIT_AND(TotalStudents) AS BitwiseAND FROM Classes
GROUP BY Dept, Lvl WITH ROLLUP;

	-- Performing system function --
CREATE TABLE UserAccounts
(
UserID SMALLINT NOT NULL PRIMARY KEY,
Password VARCHAR(20) NOT NULL
);
INSERT INTO UserAccounts VALUES (101, ENCODE('pw101', 'key101'));
SELECT UserID, DEC(Password, 'key101') AS Passwords FROM UserAccounts;

SELECT aes_encrypt('pw101', 'key101');
SELECT SHA('MyPassword');
SELECT MD5('MyPassword');

	-- System related function --
SELECT USER();
SELECT CONNECTION_ID();
SELECT DATABASE();
SELECT INET_ATON('127.0.0.1');
SELECT INET_NTOA(2130706433);

	-- Query and insert function --
SELECT FOUND_ROWS();
SELECT LAST_INSERT_ID();



