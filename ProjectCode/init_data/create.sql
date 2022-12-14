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

CREATE TYPE day AS ENUM ('sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday');

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

DROP TABLE IF EXISTS PRtable CASCADE;
CREATE TABLE PRtable
(
    username VARCHAR(50) NOT NULL,
    weightRecord INT,
    runRecord INT,
    FOREIGN KEY (username) REFERENCES users (username)
);

-- Test Data --
--Users
INSERT INTO users (username, password)
VALUES ('TestUser1', '$2b$10$2FPeavnxF81f5pnDUkdq7OID7ANcWzC2VugYSECWvcCNaf184rWgW'),
       ('TestUser2', '$2b$10$hulGymXvM6oz8x7HWzW9Oe1tsE16rGn4yXXA6DkWdKGjDjeRIOTjO');
-- TestPassword1, TestPassword2

--programs
INSERT INTO programs (program_name, password, owner_name, year, description)
VALUES ('Fall Broomball', '', 'YB', 2022,
        'This Fall, join the CU Rec Center on the ice for a competitive but fun season of Broomball! Grab your broom and your skates, we will provide the ice! Bring your BuffOne and a registered team every Thursday night otside the Ice Arena and follow this program for the scheduled workouts. See the Associates at the front desk for details and any questions. See you soon!'),
       ('Varsity Soccer', 'pass2', 'Zak', 2022,
        'Grab your cleats and jerseys because this fall, CU Rec Center is offering a varsity soccer training program through WeFit! Click the link to join the program and recieve uptates on the calendar with workout plans and meeting times. See you soon!'),
       ('Philadelphia Eagles Football', '', 'Joey', 2022,
        'Join the Philadelphia Eagles as they tear through this season! There are limited spots for this high caliber team so come find out if you have the grit to be on our team!'),
        ('Indoor Soccer', '', 'Arnav', 2022,
        'Looking to condition before the next season? Joing the Fall Indoor Soccer program to stay fit with WeFit! Programs are posted here for workouts and meting times. These are intense but fun and sponsored by the CU Personal Trainers office!'),
        ('Personal Trainer', '', 'Matt', 2022,
        'Matt is actually a personal trainer, ask him about it! he just might train you. This is a real plug, you should actually ask him!'),
        ('CU Boulder Wrestling', '', 'Nikita', 2022,
        'Nikitas Famous intense wrestling camp, come and find out how tough you are. She will put you through the gauntlet and really test how tough you are!!! She is not responsible for any injuries.');

--usersToPrograms
INSERT INTO usersToPrograms (username, program_id)
VALUES ('TestUser1', 1),
       ('TestUser1', 2),
       ('TestUser2', 2),
       ('TestUser2', 3);

--events
INSERT INTO events (program_id, title, "day", "time", description)
VALUES (1, 'Game', 'tuesday', '01:50', 'Be there 15 minutes early. CU rec-center ice rink'),
       (2, 'Practice2', 'thursday', '12:30', 'tle for the sprint workshop. Meet by the indoor arena. '),
       (3, '3 V 3 Tournament', 'tuesday', '3:00',
        'Bring cleats and a water bottle. Form teams of three outside the indoor arena while warming up'),
       (1, 'Practice', 'monday', '12:30', 'Bring cleats and a water bottle for the sprint workr arena. ');