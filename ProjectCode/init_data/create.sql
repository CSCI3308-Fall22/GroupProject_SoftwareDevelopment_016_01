DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users
(
    username VARCHAR(50) PRIMARY KEY,
    password CHAR(60) NOT NULL
);

DROP TABLE IF EXISTS programs CASCADE;
CREATE TABLE programs
(
    program_id   SERIAL PRIMARY KEY NOT NULL,
    program_name VARCHAR(100),
    password     CHAR(60),
    owner_name   VARCHAR(75)
);

DROP TABLE IF EXISTS usersToPrograms CASCADE;
CREATE TABLE usersToPrograms
(
    username VARCHAR(50) NOT NULL,
    program_id   INT NOT NULL,
    FOREIGN KEY (username) REFERENCES users (username),
    FOREIGN KEY (program_id) REFERENCES programs (program_id)
);

CREATE TYPE day AS ENUM ('sunday', 'monday', 'tuesday', 'thursday', 'friday', 'saturday');

DROP TABLE IF EXISTS events CASCADE;
CREATE TABLE events
(
    event_id     SERIAL PRIMARY KEY NOT NULL,
    program_id   INT,
    title        VARCHAR(100),
    day          day,
    time         time,
    duration_min int,
    description  VARCHAR(1000),
    FOREIGN KEY (program_id) REFERENCES programs (program_id)
);


-- Test Data --
--Users
INSERT INTO users (username, password)
VALUES ('TestUser1', '$2b$10$2FPeavnxF81f5pnDUkdq7OID7ANcWzC2VugYSECWvcCNaf184rWgW'),
       ('TestUser2', '$2b$10$hulGymXvM6oz8x7HWzW9Oe1tsE16rGn4yXXA6DkWdKGjDjeRIOTjO');
-- TestPassword1, TestPassword2

--programs
INSERT INTO programs (program_id, program_name, password, owner_name)
VALUES (1, 'Fall Broomball 2022', '', 'owner1'),
       (2, 'var soccer 2022', 'pass2', 'owner2'),
       (3, 'football i guess', '', 'owner3');

--usersToPrograms
INSERT INTO usersToPrograms (username, program_id)
VALUES ('TestUser1', 1),
       ('TestUser1', 2),
       ('TestUser2', 2),
       ('TestUser2', 3);

--events
INSERT INTO events (event_id, program_id, title, "day", "time", description)
VALUES (1, 1, 'Game', 'tuesday', '01:50', 'Be there 15 minutes early. CU rec-center ice rink');