DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users(
    username VARCHAR(50) PRIMARY KEY,
    password CHAR(60) NOT NULL
);

DROP TABLE IF EXISTS programs CASCADE;
CREATE TABLE programs(
    program_id VARCHAR(50) PRIMARY KEY,
    password CHAR(60) NOT NULL

);

DROP TABLE IF EXISTS usersToPrograms CASCADE;
CREATE TABLE usersToPrograms(
    username VARCHAR(50),
    program_id CHAR(60)
);