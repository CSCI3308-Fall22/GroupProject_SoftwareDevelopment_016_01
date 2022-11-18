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
    owner_name   VARCHAR(75),
    description  VARCHAR(1000),
    year         smallint
);

DROP TABLE IF EXISTS usersToPrograms CASCADE;
CREATE TABLE usersToPrograms
(
    username   VARCHAR(50) NOT NULL,
    program_id INT         NOT NULL,
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
    day day,
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
INSERT INTO programs (program_id, program_name, password, owner_name, year, description)
VALUES (1, 'Fall Broomball', '', 'owner1', 2022,
        'This Fall, join the CU Rec Center on the ice for a competitive but fun season of Broomball! Grab your broom and your skates, we will provide the ice! Bring your BuffOne and a registered team every Thursday night otside the Ice Arena and follow this program for the scheduled workouts. See the Associates at the front desk for details and any questions. See you soon!'),
       (2, 'Varsity Soccer', 'pass2', 'owner2', 2022,
        'Grab your cleats and jerseys because this fall, CU Rec Center is offering a varsity soccer training program through WeFit! Click the link to join the program and recieve uptates on the calendar with workout plans and meeting times. See you soon!'),
       (3, 'Indoor Soccer', '', 'owner3', 2022,
        'Looking to condition before the next season? Joing the Fall Indoor Soccer program to stay fit with WeFit! Programs are posted here for workouts and meting times. These are intense but fun and sponsored by the CU Personal Trainers office!');

--usersToPrograms
INSERT INTO usersToPrograms (username, program_id)
VALUES ('TestUser1', 1),
       ('TestUser1', 2),
       ('TestUser2', 2),
       ('TestUser2', 3);

--events
INSERT INTO events (event_id, program_id, title, "day", "time", description)
VALUES (1, 1, 'Game', 'tuesday', '01:50', 'Be there 15 minutes early. CU rec-center ice rink'),
(2, 2, 'Practice', 'monday', '12:30', 'Bring cleats and a water bottle for the sprint workshop. Meet by the indoor arena. '),
(3, 3, '3 V 3 Tournament', 'tuesday', '3:00', 'Bring cleats and a water bottle. Form teams of three outside the indoor arena while warming up');