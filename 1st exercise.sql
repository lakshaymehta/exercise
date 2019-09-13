CREATE SCHEMA schm ;
USE schm;

CREATE TABLE testing_table
(
  name VARCHAR(15) NOT NULL PRIMARY KEY,
  contact_name VARCHAR(15) NULL,
  roll_no VARCHAR(45) NULL
  );
  
ALTER TABLE testing_table
DROP COLUMN name,
ADD COLUMN first_name VARCHAR(45) NULL AFTER `roll_no`,
ADD COLUMN last_name VARCHAR(45) NULL AFTER `first_name`,
CHANGE COLUMN contact_name username VARCHAR(15) NULL ,
CHANGE COLUMN roll_no roll_no INT NULL ,
DROP PRIMARY KEY;
; 