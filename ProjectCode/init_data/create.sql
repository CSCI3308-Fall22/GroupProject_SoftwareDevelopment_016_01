DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users(
    username VARCHAR(50) PRIMARY KEY,
    password CHAR(60) NOT NULL
);

DROP TABLE IF EXISTS programs CASCADE;
CREATE TABLE programs(
    program_id VARCHAR(50) PRIMARY KEY,
    password CHAR(60),
    owner_name VARCHAR(75)
);

DROP TABLE IF EXISTS usersToPrograms CASCADE;
CREATE TABLE usersToPrograms(
    username VARCHAR(50),
    program_id CHAR(60)
);

CREATE TYPE day AS ENUM ('sunday', 'monday', 'tuesday', 'thursday', 'friday', 'saturday');

DROP TABLE IF EXISTS events CASCADE;
CREATE TABLE events(
    event_id VARCHAR(50) PRIMARY KEY,
    program_id CHAR(60),
    title VARCHAR(100),
    day day,
    time time,
    description VARCHAR(1000)
);



INSERT INTO users (username, password) VALUES ("TestUser1", "TestPassword1"),("TestUser2", "TestPassword2");