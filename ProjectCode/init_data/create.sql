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

CREATE TYPE day AS ENUM ('Sunday', 'Monday', 'Tuesday', 'Thursday', 'Friday', 'Saturday');

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
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non consectetur a erat nam. Quam lacus suspendisse faucibus interdum posuere. Blandit libero volutpat sed cras ornare arcu. Duis at consectetur lorem donec massa sapien. Leo urna molestie at elementum eu facilisis sed. Nulla porttitor massa id neque aliquam. Cursus eget nunc scelerisque viverra mauris in aliquam sem. Ultricies mi eget mauris pharetra et ultrices neque. Congue mauris rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar. Scelerisque fermentum dui faucibus in. Donec et odio pellentesque diam volutpat commodo sed egestas egestas. Non tellus orci ac auctor augue mauris. Id donec ultrices tincidunt arcu non. Lectus nulla at volutpat diam ut venenatis tellus in. Mollis nunc sed id semper risus in.'),
       (2, 'var soccer', 'pass2', 'owner2', 2022,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non consectetur a erat nam. Quam lacus suspendisse faucibus interdum posuere. Blandit libero volutpat sed cras ornare arcu. Duis at consectetur lorem donec massa sapien. Leo urna molestie at elementum eu facilisis sed. Nulla porttitor massa id neque aliquam. Cursus eget nunc scelerisque viverra mauris in aliquam sem. Ultricies mi eget mauris pharetra et ultrices neque. Congue mauris rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar. Scelerisque fermentum dui faucibus in. Donec et odio pellentesque diam volutpat commodo sed egestas egestas. Non tellus orci ac auctor augue mauris. Id donec ultrices tincidunt arcu non. Lectus nulla at volutpat diam ut venenatis tellus in. Mollis nunc sed id semper risus in.'),
       (3, 'football i guess', '', 'owner3', 2022,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non consectetur a erat nam. Quam lacus suspendisse faucibus interdum posuere. Blandit libero volutpat sed cras ornare arcu. Duis at consectetur lorem donec massa sapien. Leo urna molestie at elementum eu facilisis sed. Nulla porttitor massa id neque aliquam. Cursus eget nunc scelerisque viverra mauris in aliquam sem. Ultricies mi eget mauris pharetra et ultrices neque. Congue mauris rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar. Scelerisque fermentum dui faucibus in. Donec et odio pellentesque diam volutpat commodo sed egestas egestas. Non tellus orci ac auctor augue mauris. Id donec ultrices tincidunt arcu non. Lectus nulla at volutpat diam ut venenatis tellus in. Mollis nunc sed id semper risus in');

--usersToPrograms
INSERT INTO usersToPrograms (username, program_id)
VALUES ('TestUser1', 1),
       ('TestUser1', 2),
       ('TestUser2', 2),
       ('TestUser2', 3);

--events
INSERT INTO events (event_id, program_id, title, "day", "time", description)
VALUES (1, 1, 'Game', 'Tuesday', '04:50', 'Be there 15 minutes early. CU rec-center ice rink'),
       (2, 2, 'Game2', 'Tuesday', '02:50', 'Be there 15 minutes early. CU rec-center ice rink'),
    (3, 3, 'Game3', 'Friday', '03:50', 'Be there 15 minutes early. CU rec-center ice rink');