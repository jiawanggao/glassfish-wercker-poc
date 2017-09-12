/*

Description: PostgreSQL Db Structure Script.
             Includes creation of:
                1: Database;
                2: Language;
                3: Tables; and
                4: Views

Programmer:  Lee Goodyear
Date:        23 Jul 2015.

*/


-----------------------------------------------------------------------------------------------
-- CREATE DATABASE
-----------------------------------------------------------------------------------------------
DROP ROLE IF EXISTS "zlogrole";
CREATE ROLE "zlogrole" LOGIN PASSWORD 'ZLogRole01';

CREATE DATABASE "ZLogs"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default;
GRANT ALL ON DATABASE "ZLogs" TO zlogrole;
GRANT ALL ON DATABASE "ZLogs" TO postgres;




/*********************************************************************

    TABLES

*********************************************************************/
DROP TABLE IF EXISTS LOG_SYSTEM CASCADE;
CREATE TABLE LOG_SYSTEM (
	code                    SERIAL        NOT NULL,
	key                     TEXT          NOT NULL,
	message                 TEXT          NOT NULL,
	date                    TIMESTAMP     NOT NULL
);

DROP TABLE IF EXISTS LOG_USER CASCADE;
CREATE TABLE LOG_USER (
	code                    SERIAL        NOT NULL,
	userid                  INTEGER       NOT NULL,
	key                     TEXT          NOT NULL,
	message                 TEXT          NOT NULL,
	date                    TIMESTAMP     NOT NULL
);


/*********************************************************************

    PRIMARY KEYS

*********************************************************************/
ALTER TABLE LOG_SYSTEM ADD
	PRIMARY KEY
	(
		code
	);

ALTER TABLE LOG_USER ADD
	PRIMARY KEY
	(
		code
	);


/*********************************************************************

    PERMISSIONS

*********************************************************************/
GRANT  ALL  ON LOG_SYSTEM TO zlogrole;
GRANT  ALL  ON LOG_USER TO zlogrole;
GRANT  ALL  ON log_system_code_seq TO zlogrole;
GRANT  ALL  ON log_user_code_seq TO zlogrole;



/*

Description: PostgreSQL Db Structure Script.
             Includes creation of:
                1: Database;
                2: Language;
                3: Tables; and
                4: Views

Programmer:  Lee Goodyear
Date:        23 Jul 2015.

*/


-----------------------------------------------------------------------------------------------
-- CREATE DATABASE
-----------------------------------------------------------------------------------------------
DROP ROLE IF EXISTS "znewsrole";
CREATE ROLE "znewsrole" LOGIN PASSWORD 'ZNewsRole01';

CREATE DATABASE "ZNews"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default;
GRANT ALL ON DATABASE "ZNews" TO znewsrole;
GRANT ALL ON DATABASE "ZNews" TO postgres;





/*********************************************************************

    TABLES

*********************************************************************/
DROP TABLE IF EXISTS NEWS_ARTICLES CASCADE;
CREATE TABLE NEWS_ARTICLES (
	code                    SERIAL        NOT NULL,
	date                    TIMESTAMP     NOT NULL,
	title                   TEXT          NOT NULL,
	brief                   TEXT          NOT NULL,
	story                   TEXT          NULL
);


/*********************************************************************

    PRIMARY KEYS

*********************************************************************/
ALTER TABLE NEWS_ARTICLES ADD
	PRIMARY KEY
	(
		code
	);


/*********************************************************************

    PERMISSIONS

*********************************************************************/
GRANT  ALL  ON NEWS_ARTICLES TO znewsrole;

GRANT  ALL  ON news_articles_code_seq TO znewsrole;






/*

Description: PostgreSQL Db Structure Script.
             Includes creation of:
                1: Database;
                2: Language;
                3: Tables; and
                4: Views

Programmer:  Lee Goodyear
Date:        23 Jul 2015.

*/


-----------------------------------------------------------------------------------------------
-- CREATE DATABASE
-----------------------------------------------------------------------------------------------
DROP ROLE IF EXISTS "zsecurityrole";
CREATE ROLE "zsecurityrole" LOGIN PASSWORD 'ZSecurityRole01';

CREATE DATABASE "ZSecurity"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default;
GRANT ALL ON DATABASE "ZSecurity" TO zsecurityrole;
GRANT ALL ON DATABASE "ZSecurity" TO postgres;






/*********************************************************************

    TABLES

*********************************************************************/
DROP TABLE IF EXISTS SEC_LOGINS CASCADE;
CREATE TABLE SEC_LOGINS (
	code                    SERIAL        NOT NULL,
	parent                  INT           NOT NULL,
	userid                  VARCHAR (100) UNIQUE NOT NULL,
	password                VARCHAR (100) NOT NULL
);

DROP TABLE IF EXISTS SEC_GROUPS CASCADE;
CREATE TABLE SEC_GROUPS (
	code                    SERIAL        NOT NULL,
	parent                  INT           NOT NULL,
	userid                  VARCHAR (100) NOT NULL,
	groupid                 VARCHAR (100) NOT NULL
);

DROP TABLE IF EXISTS SEC_COMPANIES CASCADE;
CREATE TABLE SEC_COMPANIES (
	code                    SERIAL NOT NULL,
	name                    VARCHAR (100) NOT NULL,
	email                   VARCHAR (100) NOT NULL,
	phone                   VARCHAR (20)  NOT NULL,
	addressLine1            VARCHAR (200) NOT NULL,
	addressLine2            VARCHAR (200) NOT NULL,
	addressCity             VARCHAR (200) NOT NULL DEFAULT '',
	addressState            VARCHAR (200) NOT NULL DEFAULT '',
	addressCountry          VARCHAR (200) NOT NULL,
	addressPostcode         VARCHAR (50)  NOT NULL DEFAULT '',
	notes                   TEXT NOT NULL DEFAULT '',
        disabled                BOOLEAN DEFAULT false
);

DROP TABLE IF EXISTS SEC_CONTACTS CASCADE;
CREATE TABLE SEC_CONTACTS (
	code                    SERIAL NOT NULL,
	parent                  INTEGER NULL,
	firstName               VARCHAR (100) NOT NULL,
	familyName              VARCHAR (100) NOT NULL,
	email                   VARCHAR (100) NOT NULL,
	phone                   VARCHAR (20)  NOT NULL,
	company                 VARCHAR (200) NOT NULL DEFAULT '',
	addressLine1            VARCHAR (200) NOT NULL,
	addressLine2            VARCHAR (200) NOT NULL,
	addressCity             VARCHAR (200) NOT NULL DEFAULT '',
	addressState            VARCHAR (200) NOT NULL DEFAULT '',
	addressCountry          VARCHAR (200) NOT NULL,
	addressPostcode         VARCHAR (50)  NOT NULL DEFAULT '',
	notes                   TEXT NOT NULL DEFAULT '',
        disabled                BOOLEAN DEFAULT false
);

DROP TABLE IF EXISTS SEC_CONTACT_PERMISSIONS CASCADE;
CREATE TABLE SEC_CONTACT_PERMISSIONS (
	code                    SERIAL        NOT NULL,
	parent                  INTEGER       NULL,
	packageID               VARCHAR (100) NOT NULL,
	corporateAccount        BOOLEAN       DEFAULT false,
	accessTaskScheduler     BOOLEAN       DEFAULT false,
	fileStorageSizeGB       INT           DEFAULT 0,
	cpuTimeHoursPerMonth    INT           DEFAULT 0,
	bundleActivationDate    TIMESTAMP     NULL,
        bundleDeactivationDate  TIMESTAMP     NULL,
	notes                   TEXT          NOT NULL DEFAULT '',
        disabled                BOOLEAN       NOT NULL DEFAULT true
);

DROP TABLE IF EXISTS SEC_CONTACT_PERMISSION_PARSERS CASCADE;
CREATE TABLE SEC_CONTACT_PERMISSION_PARSERS (
	code                    SERIAL        NOT NULL,
	parent                  INTEGER       NULL,
	name                    VARCHAR (100) NOT NULL
);

DROP TABLE IF EXISTS SEC_CONTACT_PERMISSION_DATA_SOURCES CASCADE;
CREATE TABLE SEC_CONTACT_PERMISSION_DATA_SOURCES (
	code                    SERIAL        NOT NULL,
	parent                  INTEGER       NULL,
	name                    VARCHAR (100) NOT NULL
);

DROP TABLE IF EXISTS SEC_CONTACT_PERMISSION_TASKS CASCADE;
CREATE TABLE SEC_CONTACT_PERMISSION_TASKS (
	code                    SERIAL        NOT NULL,
	parent                  INTEGER       NULL,
	name                    VARCHAR (100) NOT NULL
);

/*********************************************************************

    PRIMARY KEYS

*********************************************************************/
ALTER TABLE SEC_LOGINS ADD
	PRIMARY KEY
	(
		code
	);

ALTER TABLE SEC_GROUPS ADD
	PRIMARY KEY
	(
		code
	);

ALTER TABLE SEC_COMPANIES ADD
	PRIMARY KEY
	(
		code
	);

ALTER TABLE SEC_CONTACTS ADD
	PRIMARY KEY
	(
		code
	);

ALTER TABLE SEC_CONTACT_PERMISSIONS ADD
	PRIMARY KEY
	(
		code
	);

ALTER TABLE SEC_CONTACT_PERMISSION_PARSERS ADD
	PRIMARY KEY
	(
		code
	);

ALTER TABLE SEC_CONTACT_PERMISSION_DATA_SOURCES ADD
	PRIMARY KEY
	(
		code
	);

ALTER TABLE SEC_CONTACT_PERMISSION_TASKS ADD
	PRIMARY KEY
	(
		code
	);

/*********************************************************************

    FOREIGN KEYS

*********************************************************************/
ALTER TABLE SEC_LOGINS ADD 
        FOREIGN KEY (
                parent )
        REFERENCES SEC_CONTACTS ( CODE ) ;

ALTER TABLE SEC_GROUPS ADD 
        FOREIGN KEY (
                parent )
        REFERENCES SEC_CONTACT_PERMISSIONS ( CODE ) ;

ALTER TABLE SEC_CONTACTS ADD 
        FOREIGN KEY (
                parent )
        REFERENCES SEC_COMPANIES ( CODE ) ;

ALTER TABLE SEC_CONTACT_PERMISSIONS ADD 
        FOREIGN KEY (
                parent )
        REFERENCES SEC_CONTACTS ( CODE ) ;

ALTER TABLE SEC_CONTACT_PERMISSION_PARSERS ADD 
        FOREIGN KEY (
                parent )
        REFERENCES SEC_CONTACT_PERMISSIONS ( CODE ) ;

ALTER TABLE SEC_CONTACT_PERMISSION_DATA_SOURCES ADD 
        FOREIGN KEY (
                parent )
        REFERENCES SEC_CONTACT_PERMISSIONS ( CODE ) ;

ALTER TABLE SEC_CONTACT_PERMISSION_TASKS ADD 
        FOREIGN KEY (
                parent )
        REFERENCES SEC_CONTACT_PERMISSIONS ( CODE ) ;


/*********************************************************************

    PERMISSIONS

*********************************************************************/
GRANT  ALL  ON SEC_LOGINS TO zsecurityrole;
GRANT  ALL  ON SEC_GROUPS TO zsecurityrole;
GRANT  ALL  ON SEC_COMPANIES TO zsecurityrole;
GRANT  ALL  ON SEC_CONTACTS TO zsecurityrole;
GRANT  ALL  ON SEC_CONTACT_PERMISSIONS TO zsecurityrole;
GRANT  ALL  ON SEC_CONTACT_PERMISSION_PARSERS TO zsecurityrole;
GRANT  ALL  ON SEC_CONTACT_PERMISSION_DATA_SOURCES TO zsecurityrole;
GRANT  ALL  ON SEC_CONTACT_PERMISSION_TASKS TO zsecurityrole;

GRANT  ALL  ON sec_logins_code_seq TO zsecurityrole;
GRANT  ALL  ON sec_groups_code_seq TO zsecurityrole;
GRANT  ALL  ON sec_companies_code_seq TO zsecurityrole;
GRANT  ALL  ON sec_contacts_code_seq TO zsecurityrole;
GRANT  ALL  ON sec_contact_permissions_code_seq TO zsecurityrole;
GRANT  ALL  ON sec_contact_permission_parsers_code_seq TO zsecurityrole;
GRANT  ALL  ON sec_contact_permission_data_sources_code_seq TO zsecurityrole;
GRANT  ALL  ON sec_contact_permission_tasks_code_seq TO zsecurityrole;

/*********************************************************************

    DEFAULT ACCOUNTS

*********************************************************************/
insert into SEC_COMPANIES (name, email, phone, addressLine1, addressLine2, addressCity, addressState, addressCountry, addressPostcode, notes, disabled)
values ('Zephyr Systems', 'lgoodyear@zephyr-systems.com.au', '+61 (0)40-1632-222', '2 Brook Street', '', 'East Perth', 'WA', 'Australia', '6004', '', false);

insert into SEC_CONTACTS (parent, firstName, familyName, email, phone, company, addressLine1, addressLine2, addressCity, addressState, addressCountry, addressPostcode, notes, disabled)
values ((select code from SEC_COMPANIES where name='Zephyr Systems'), 'admin', 'admin', 'lgoodyear@zephyr-systems.com.au', '+61 (0)40-1632-222', 'Zephyr Systems', '2 Brook Street', '', 'East Perth', 'WA', 'Australia', '6004', '', false);

insert into SEC_CONTACT_PERMISSIONS (parent, packageID, corporateAccount, accessTaskScheduler, fileStorageSizeGB, cpuTimeHoursPerMonth, bundleActivationDate, bundleDeactivationDate, notes, disabled)
values ((select code from SEC_CONTACTS where firstName='admin' and familyName='admin'), 'admin', true, true, 5000, 5000, '2015-01-01 00:00:00Z', '3015-01-01 00:00:00Z', '', false);

/*  Password: 'Admin01' encrypted using Charset UTF-8 SHA-256 encryption encoded to Base64   */
insert into SEC_LOGINS(parent, userid, password)
values ((select code from SEC_CONTACTS where firstName='admin' and familyName='admin'), 'admin', 'FCsXcPdCbarwoDwDr7w/5sAj3hY6MbXYdRfPeNFt/9s=');

insert into SEC_GROUPS(parent, userid, groupid)
values ((select code from SEC_CONTACTS where firstName='admin' and familyName='admin'), 'admin', 'ADMINISTRATOR');








/*

Description: PostgreSQL Db Structure Script.
             Includes creation of:
                1: Database;
                2: Language;
                3: Tables; and
                4: Views

Programmer:  Lee Goodyear
Date:        23 Jul 2015.

*/


-----------------------------------------------------------------------------------------------
-- CREATE DATABASE
-----------------------------------------------------------------------------------------------
DROP ROLE IF EXISTS "zstoredatarole";
CREATE ROLE "zstoredatarole" LOGIN PASSWORD 'ZStoreDataRole01';

CREATE DATABASE "ZStoreData"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default;
GRANT ALL ON DATABASE "ZStoreData" TO zstoredatarole;
GRANT ALL ON DATABASE "ZStoreData" TO postgres;






/*********************************************************************

    TABLES

*********************************************************************/
DROP TABLE IF EXISTS STORE_PURCHASES CASCADE;
CREATE TABLE STORE_PURCHASES (
	code                    SERIAL            NOT NULL,
	purchaseDate            TIMESTAMP         NOT NULL DEFAULT now(),
	userID                  INT               NOT NULL,
	ipAddress               TEXT              NOT NULL,
	priceGross              DOUBLE PRECISION  NOT NULL,
	priceDiscount           DOUBLE PRECISION  NOT NULL,
	priceNet                DOUBLE PRECISION  NOT NULL,
	couponCode              TEXT              NOT NULL,
	couponDiscount          DOUBLE PRECISION  NOT NULL,
	task_list_code          INT               NOT NULL,
	notes                   TEXT              NOT NULL DEFAULT ''
);

DROP TABLE IF EXISTS STORE_PURCHASE CASCADE;
CREATE TABLE STORE_PURCHASE (
	code                    SERIAL            NOT NULL,
	parent                  INT               NOT NULL,
	stationKey              TEXT              NOT NULL,
	stationCode             TEXT              NOT NULL,
	variableCode            TEXT              NOT NULL,
	dataContext             TEXT              NOT NULL,
	dateStart               TIMESTAMP         NOT NULL,
	dateEnd                 TIMESTAMP         NOT NULL,
	duration                DOUBLE PRECISION  NOT NULL,
	repository_key          TEXT              NOT NULL,
	repository_path         TEXT              NOT NULL
);


/*********************************************************************

    PRIMARY KEYS

*********************************************************************/
ALTER TABLE STORE_PURCHASES ADD
	PRIMARY KEY
	(
		code
	);

ALTER TABLE STORE_PURCHASE ADD
	PRIMARY KEY
	(
		code
	);


/*********************************************************************

    FOREIGN KEYS

*********************************************************************/
ALTER TABLE STORE_PURCHASE ADD 
        FOREIGN KEY (
                PARENT )
        REFERENCES STORE_PURCHASES ( CODE ) ;


/*********************************************************************

    PERMISSIONS

*********************************************************************/
GRANT  ALL  ON STORE_PURCHASES TO zstoredatarole;
GRANT  ALL  ON STORE_PURCHASE TO zstoredatarole;

GRANT  ALL  ON store_purchases_code_seq TO zstoredatarole;
GRANT  ALL  ON store_purchase_code_seq TO zstoredatarole;






