-- Inserting one value on ATTENDEE Table
INSERT INTO ATTENDEE (FIRST_NAME, LAST_NAME) VALUES ('Thomas', 'Nield');
SELECT * FROM ATTENDEE;

-- Inserting multiple values on ATTENDEE Table
INSERT INTO ATTENDEE (FIRST_NAME, LAST_NAME, PHONE, EMAIL, VIP) VALUES
('Jon', 'Skeeter', 4802185842, 'john.skeeter@rex.net', 1),
('Sam', 'Scala', 2156783401, 'sam.scala@gmail.com', 0),
('Brittany', 'Fisher', 5932857296, 'brittany.fisher@outlook.com', 0);

-- Try to insert into COMPANY table an invalid value: PRIMARY_CONTACT_ATTENDEE_ID
--INSERT INTO COMPANY (NAME, DESCRIPTION, PRIMARY_CONTACT_ATTENDEE_ID) VALUES ('RexApp Solutions', 'A mobile app delivery service', 5);

-- Insert into COMPANY table a valid value: PRIMARY_CONTACT_ID
INSERT INTO COMPANY (NAME, DESCRIPTION, PRIMARY_CONTACT_ATTENDEE_ID) VALUES ('RexApp Solutions', 'A mobile app delivery service', 3);
SELECT * FROM COMPANY;

-- DELETE tables and clean index
/*DELETE FROM COMPANY;
DELETE FROM sqlite_sequence where name='COMPANY';
DELETE FROM ATTENDEE;
DELETE FROM sqlite_sequence where name='ATTENDEE';*/

-- UPDATE emails on ATTENDEE table to be upper case
UPDATE ATTENDEE SET EMAIL = UPPER(EMAIL);

-- UPDATE first_name and last_name on ATTENDEE table to be upper case
UPDATE ATTENDEE SET FIRST_NAME = UPPER(FIRST_NAME), LAST_NAME = UPPER(LAST_NAME);

-- UPDATE vip on ATTENDEE table to be true
UPDATE ATTENDEE SET VIP = 1 WHERE ATTENDEE_ID IN (3,4);

-- Drop a table
-- DROP TABLE MY_UNWANTED_TABLE;