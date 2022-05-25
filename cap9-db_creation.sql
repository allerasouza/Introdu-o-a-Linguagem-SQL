-- CREATING TABLES
CREATE TABLE COMPANY (
    COMPANY_ID                  INTEGER      PRIMARY KEY AUTOINCREMENT,
    NAME                        VARCHAR (30) NOT NULL,
    DESCRIPTION                 VARCHAR (60),
    PRIMARY_CONTACT_ATTENDEE_ID INTEGER      NOT NULL
);

CREATE TABLE ROOM (
    ROOM_ID       INTEGER PRIMARY KEY AUTOINCREMENT,
    FLOOR_NUMBER  INTEGER NOT NULL,
    SEAT_CAPACITY INTEGER NOT NULL
);

CREATE TABLE PRESENTATION (
    PRESENTATION_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    BOOKED_COMPANY_ID INTEGER NOT NULL,
    BOOKED_ROOM_ID INTEGER NOT NULL,
    START_TIME TIME,
    END_TIME TIME
);

CREATE TABLE ATTENDEE (
   ATTENDEE_ID INTEGER PRIMARY KEY AUTOINCREMENT,
   FIRST_NAME VARCHAR (30) NOT NULL,
   LAST_NAME VARCHAR (30) NOT NULL,
   PHONE INTEGER,
   EMAIL VARCHAR (30),
   VIP BOOLEAN DEFAULT (0)
);

CREATE TABLE PRESENTATION_ATTENDANCE (
    TICKET_ID       INTEGER PRIMARY KEY AUTOINCREMENT,
    PRESENTATION_ID INTEGER,
    ATTENDEE_ID     INTEGER
);

-- CREATING FOREIGN KEY: PRESENTATION.BOOKED_COMPANY_ID
PRAGMA foreign_keys = 0;
CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM PRESENTATION;
DROP TABLE PRESENTATION;
CREATE TABLE PRESENTATION (
    PRESENTATION_ID   INTEGER PRIMARY KEY AUTOINCREMENT,
    BOOKED_COMPANY_ID INTEGER NOT NULL
                              REFERENCES COMPANY (COMPANY_ID),
    BOOKED_ROOM_ID    INTEGER NOT NULL,
    START_TIME        TIME,
    END_TIME          TIME
);
INSERT INTO PRESENTATION (
                             PRESENTATION_ID,
                             BOOKED_COMPANY_ID,
                             BOOKED_ROOM_ID,
                             START_TIME,
                             END_TIME
                         )
                         SELECT PRESENTATION_ID,
                                BOOKED_COMPANY_ID,
                                BOOKED_ROOM_ID,
                                START_TIME,
                                END_TIME
                           FROM sqlitestudio_temp_table;
DROP TABLE sqlitestudio_temp_table;
PRAGMA foreign_keys = 1;

-- CREATING FOREIGN KEY: PRESENTATION.BOOKED_ROOM_ID
PRAGMA foreign_keys = 0;
CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM PRESENTATION;
DROP TABLE PRESENTATION;
CREATE TABLE PRESENTATION (
    PRESENTATION_ID   INTEGER PRIMARY KEY AUTOINCREMENT,
    BOOKED_COMPANY_ID INTEGER NOT NULL
                              REFERENCES COMPANY (COMPANY_ID),
    BOOKED_ROOM_ID    INTEGER NOT NULL
                              REFERENCES ROOM (ROOM_ID),
    START_TIME        TIME,
    END_TIME          TIME
);
INSERT INTO PRESENTATION (
                             PRESENTATION_ID,
                             BOOKED_COMPANY_ID,
                             BOOKED_ROOM_ID,
                             START_TIME,
                             END_TIME
                         )
                         SELECT PRESENTATION_ID,
                                BOOKED_COMPANY_ID,
                                BOOKED_ROOM_ID,
                                START_TIME,
                                END_TIME
                           FROM sqlitestudio_temp_table;
DROP TABLE sqlitestudio_temp_table;
PRAGMA foreign_keys = 1;

-- CREATING FOREIGN KEY: PRESENTATION_ATTENDANCE.PRESENTATION_ID, PRESENTATION_ATTENDANCE.ATTENDEE_ID
PRAGMA foreign_keys = 0;
CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM PRESENTATION_ATTENDANCE;
DROP TABLE PRESENTATION_ATTENDANCE;
CREATE TABLE PRESENTATION_ATTENDANCE (
    TICKET_ID       INTEGER PRIMARY KEY AUTOINCREMENT,
    PRESENTATION_ID INTEGER REFERENCES PRESENTATION (PRESENTATION_ID),
    ATTENDEE_ID     INTEGER REFERENCES ATTENDEE (ATTENDEE_ID) 
);
INSERT INTO PRESENTATION_ATTENDANCE (
                                        TICKET_ID,
                                        PRESENTATION_ID,
                                        ATTENDEE_ID
                                    )
                                    SELECT TICKET_ID,
                                           PRESENTATION_ID,
                                           ATTENDEE_ID
                                      FROM sqlitestudio_temp_table;
DROP TABLE sqlitestudio_temp_table;
PRAGMA foreign_keys = 1;

-- CREATING FOREIGN KEY: COMPANY.PRIMARY_CONTACT_ATTENDEE_ID
PRAGMA foreign_keys = 0;
CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM COMPANY;
DROP TABLE COMPANY;
CREATE TABLE COMPANY (
    COMPANY_ID                  INTEGER      PRIMARY KEY AUTOINCREMENT,
    NAME                        VARCHAR (30) NOT NULL,
    DESCRIPTION                 VARCHAR (60),
    PRIMARY_CONTACT_ATTENDEE_ID INTEGER      NOT NULL
                                             REFERENCES ATTENDEE (ATTENDEE_ID) 
);
INSERT INTO COMPANY (
                        COMPANY_ID,
                        NAME,
                        DESCRIPTION,
                        PRIMARY_CONTACT_ATTENDEE_ID
                    )
                    SELECT COMPANY_ID,
                           NAME,
                           DESCRIPTION,
                           PRIMARY_CONTACT_ATTENDEE_ID
                      FROM sqlitestudio_temp_table;
DROP TABLE sqlitestudio_temp_table;
PRAGMA foreign_keys = 1;

