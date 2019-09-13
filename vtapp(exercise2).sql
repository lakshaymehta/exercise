CREATE DATABASE vtapp;
USE vtapp;

CREATE USER 'vtapp_user'
IDENTIFIED BY 'password';

GRANT ALL ON vtapp TO 'vtapp_user';