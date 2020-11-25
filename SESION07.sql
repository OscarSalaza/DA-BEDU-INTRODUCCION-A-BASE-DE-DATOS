-- RETO 1

CREATE DATABASE bedu_test;
USE bedu_test;

CREATE TABLE IF NOT EXISTS users(
	id_user INT PRIMARY KEY,
    genero CHAR(1),
    edad INT,
    ocupacion INT,
    cp VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS movies(
	id_movie INT PRIMARY KEY,
    titulo VARCHAR(80),
    generos VARCHAR(80)
);

CREATE TABLE IF NOT EXISTS ratings(
   userid INT, 
   movieid INT, 
   rating INT, 
   time_stamp BIGINT
);