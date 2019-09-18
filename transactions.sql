CREATE SCHEMA bank;
USE bank;

CREATE TABLE accounts
(
acc_id INT NOT NULL,
acc_no VARCHAR(45) NOT NULL,
balance INT NULL,
PRIMARY KEY (acc_no)
);
INSERT INTO accounts (acc_id, acc_no, balance) VALUES ('1', '101', '123'),
('2', '102', '5572'),
('3', '103', '654'),
('4', '104','1'),
('5', '105', '65');

CREATE TABLE users 
(
user_id INT NOT NULL,
name VARCHAR(15) NULL,
email VARCHAR(45) NULL,
account_no VARCHAR(45) NOT NULL,
FOREIGN KEY (account_no) REFERENCES accounts(acc_no),
PRIMARY KEY (user_id)
);
INSERT INTO users (user_id, name, email, account_no) VALUES ('1', 'userA', 'abc@gmail.com', '101'),
('2', 'userB', 'def@gmail.com', '102'),
('3', 'userC', 'ghi@gmail.com', '103'),
('4', 'userD', 'jkl@gmail.com', '104'),
('5', 'userE', 'mno@gmail.com', '105');

SELECT * FROM users AS U JOIN accounts AS A
WHERE U.account_no=A.acc_no;

	-- userA is depositing 1000 Rs. his account --
SET SQL_SAFE_UPDATES = 0;
START TRANSACTION;
UPDATE accounts
SET balance = balance + 1000
WHERE acc_no=101;
COMMIT; 

	-- userA is withdrawing 500 Rs --
START TRANSACTION;
UPDATE accounts
SET balance = balance - 500
WHERE acc_no=101;
COMMIT;

	-- userA is transferring 200 Rs to userB's account --
START TRANSACTION;
UPDATE accounts
SET balance = balance - 200
WHERE acc_no=101;
UPDATE accounts
SET balance = balance + 200
WHERE acc_no=102;
COMMIT;
