--- START ---
SP_RENAME 'SBI_I18N_MESSAGES', 'SBI_I18N_MESSAGES_OLD';

SELECT ROW_NUMBER() OVER(order by label) AS ID, t.* INTO SBI_I18N_MESSAGES FROM SBI_I18N_MESSAGES_OLD t;

DROP TABLE SBI_I18N_MESSAGES_OLD;

ALTER TABLE SBI_I18N_MESSAGES ADD CONSTRAINT PK_SBI_I18N_MESSAGES PRIMARY KEY (ID);
ALTER TABLE SBI_I18N_MESSAGES ADD CONSTRAINT FK_SBI_I18N_MESSAGES FOREIGN KEY (LANGUAGE_CD) REFERENCES SBI_DOMAINS (VALUE_ID);
ALTER TABLE SBI_I18N_MESSAGES ADD CONSTRAINT SBI_I18N_MESSAGES_UNIQUE UNIQUE (LANGUAGE_CD, LABEL, ORGANIZATION);

INSERT INTO hibernate_sequences VALUES ('SBI_I18N_MESSAGES',
                                                            (SELECT ISNULL(MAX(m.ID) + 1, 1) FROM SBI_I18N_MESSAGES m));
COMMIT;                                                            
--- END ---

ALTER TABLE SBI_DATA_SET ADD CONSTRAINT XAK2SBI_DATA_SET UNIQUE (NAME, VERSION_NUM, ORGANIZATION);

ALTER TABLE SBI_ATTRIBUTE ALTER COLUMN DESCRIPTION VARCHAR(500) NULL;

ALTER TABLE SBI_ATTRIBUTE ADD LOV_ID INTEGER NULL,ALLOW_USER SMALLINT  DEFAULT '1',MULTIVALUE SMALLINT  DEFAULT '0',SYNTAX SMALLINT NULL, 
									  VALUE_TYPE_ID INTEGER NULL, VALUE_TYPE_CD VARCHAR(20), VALUE_TYPE VARCHAR(50);
									  
ALTER TABLE SBI_ATTRIBUTE ADD CONSTRAINT FK_LOV FOREIGN KEY (LOV_ID) REFERENCES SBI_LOV(LOV_ID);
ALTER TABLE SBI_ATTRIBUTE ADD CONSTRAINT ENUM_TYPE CHECK (VALUE_TYPE IN('STRING','DATE','NUM'));

ALTER TABLE SBI_EVENTS_LOG ADD COLUMN EVENT_TYPE VARCHAR(50) DEFAULT 'SCHEDULER' NOT NULL;

UPDATE SBI_EVENTS_LOG SET EVENT_TYPE = (
CASE HANDLER 
	WHEN 'it.eng.spagobi.events.handlers.DefaultEventPresentationHandler' THEN 'SCHEDULER'
	WHEN 'it.eng.spagobi.events.handlers.CommonjEventPresentationHandler' THEN 'COMMONJ'
	WHEN 'it.eng.spagobi.events.handlers.TalendEventPresentationHandler' THEN 'ETL'
	WHEN 'it.eng.spagobi.events.handlers.WekaEventPresentationHandler' THEN 'DATA_MINING'
END
);
commit;

ALTER TABLE SBI_EVENTS_LOG DROP COLUMN HANDLER;

ALTER TABLE SBI_OUTPUT_PARAMETER ALTER COLUMN FORMAT_VALUE VARCHAR(30);

ALTER TABLE SBI_FEDERATION_DEFINITION ADD COLUMN OWNER VARCHAR(100) NULL AFTER DEGENERATED;

---BEGIN---
CREATE TABLE SBI_METAMODEL_PAR (
	METAMODEL_PAR_ID INT NOT NULL,
	PAR_ID INT NOT NULL,
	METAMODEL_ID INT NOT NULL,
	LABEL VARCHAR(40) NOT NULL,
	REQ_FL SMALLINT NULL,
	MOD_FL SMALLINT NULL,
	VIEW_FL SMALLINT NULL,
	MULT_FL SMALLINT NULL,
	PROG INT NOT NULL,
	PARURL_NM VARCHAR(20) NULL,
	PRIORITY INT NULL,
	COL_SPAN INT DEFAULT 1 NULL,
	THICK_PERC INT DEFAULT 0 NULL,
	USER_IN VARCHAR(100) NOT NULL,
	USER_UP VARCHAR(100) NULL,
	USER_DE VARCHAR(100) NULL,
	TIME_IN DATETIME NOT NULL,
	TIME_UP DATETIME NULL,
	TIME_DE DATETIME NULL,
	SBI_VERSION_IN VARCHAR(10) NULL,
	SBI_VERSION_UP VARCHAR(10) NULL,
	SBI_VERSION_DE VARCHAR(10) NULL,
	META_VERSION VARCHAR(100) NULL,
	ORGANIZATION VARCHAR(20) NULL,
	PRIMARY KEY (METAMODEL_PAR_ID)
);

ALTER TABLE SBI_METAMODEL_PAR ADD CONSTRAINT FK_SBI_METAMODEL_PAR_1 FOREIGN KEY (METAMODEL_ID) REFERENCES SBI_META_MODELS (ID) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE SBI_METAMODEL_PAR ADD CONSTRAINT FK_SBI_METAMODEL_PAR_2 FOREIGN KEY (PAR_ID) REFERENCES SBI_PARAMETERS (PAR_ID) ON UPDATE NO ACTION ON DELETE NO ACTION;


CREATE TABLE SBI_METAMODEL_PARUSE (
	PARUSE_ID INT NOT NULL
	METAMODEL_PAR_ID INT NOT NULL,
	USE_ID INT NOT NULL,
	METAMODEL_PAR_FATHER_ID INT NOT NULL,
	FILTER_OPERATION VARCHAR(20) NOT NULL,
	PROG INT NOT NULL,
	FILTER_COLUMN VARCHAR(30) NOT NULL,
	PRE_CONDITION VARCHAR(10) NULL,
	POST_CONDITION VARCHAR(10) NULL,
	LOGIC_OPERATOR VARCHAR(10) NULL,
	USER_IN VARCHAR(100) NOT NULL,
	USER_UP VARCHAR(100) NULL,
	USER_DE VARCHAR(100) NULL,
	TIME_IN DATETIME NOT NULL,
	TIME_UP DATETIME NULL,
	TIME_DE DATETIME NULL,
	SBI_VERSION_IN VARCHAR(10) NULL,
	SBI_VERSION_UP VARCHAR(10) NULL,
	SBI_VERSION_DE VARCHAR(10) NULL,
	META_VERSION VARCHAR(100) NULL,
	ORGANIZATION VARCHAR(20) NULL,
	PRIMARY KEY (PARUSE_ID),
);

ALTER TABLE SBI_METAMODEL_PARUSE ADD CONSTRAINT FK_SBI_METAMODEL_PARUSE_1 FOREIGN KEY (METAMODEL_PAR_ID) REFERENCES SBI_METAMODEL_PAR (METAMODEL_PAR_ID) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE SBI_METAMODEL_PARUSE ADD CONSTRAINT FK_SBI_METAMODEL_PARUSE_2 FOREIGN KEY (USE_ID) REFERENCES SBI_PARUSE (USE_ID) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE SBI_METAMODEL_PARUSE ADD CONSTRAINT FK_SBI_METAMODEL_PARUSE_3 FOREIGN KEY (METAMODEL_PAR_FATHER_ID) REFERENCES SBI_METAMODEL_PAR (METAMODEL_PAR_ID) ON UPDATE NO ACTION ON DELETE NO ACTION;


CREATE TABLE SBI_METAMODEL_PARVIEW (
	PARVIEW_ID INT NOT NULL,
	METAMODEL_PAR_ID INT NOT NULL,
	METAMODEL_PAR_FATHER_ID INT NOT NULL,
	OPERATION VARCHAR(20) NOT NULL,
	COMPARE_VALUE VARCHAR(200) NOT NULL,
	VIEW_LABEL VARCHAR(50) NULL,
	PROG INT NULL,
	USER_IN VARCHAR(100) NOT NULL,
	USER_UP VARCHAR(100) NULL,
	USER_DE VARCHAR(100) NULL,
	TIME_IN DATETIME NOT NULL,
	TIME_UP DATETIME NULL,
	TIME_DE DATETIME NULL,
	SBI_VERSION_IN VARCHAR(10) NULL,
	SBI_VERSION_UP VARCHAR(10) NULL,
	SBI_VERSION_DE VARCHAR(10) NULL,
	META_VERSION VARCHAR(100) NULL,
	ORGANIZATION VARCHAR(20) NULL,
	PRIMARY KEY (PARVIEW_ID),
);


ALTER TABLE SBI_METAMODEL_PARVIEW ADD CONSTRAINT FK_SBI_METAMODEL_PARVIEW_1 FOREIGN KEY (METAMODEL_PAR_ID) REFERENCES SBI_METAMODEL_PAR (METAMODEL_PAR_ID) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE SBI_METAMODEL_PARVIEW ADD CONSTRAINT FK_SBI_METAMODEL_PARVIEW_2 FOREIGN KEY (METAMODEL_PAR_FATHER_ID) REFERENCES SBI_METAMODEL_PAR (METAMODEL_PAR_ID) ON UPDATE NO ACTION ON DELETE NO ACTION;

---END---

---Begin---
ALTER TABLE SBI_METAMODEL_PAR 
CHANGE COLUMN REQ_FL SMALLINT SET DEFAULT '0' ,
CHANGE COLUMN MOD_FL SMALLINT SET DEFAULT '0' ,
CHANGE COLUMN VIEW_FL SMALLINT SET DEFAULT '1' ,
CHANGE COLUMN MULT_FL SMALLINT SET DEFAULT '0' ;

ALTER TABLE SBI_OBJ_PAR 
CHANGE COLUMN REQ_FL SMALLINT SET DEFAULT '0' ,
CHANGE COLUMN MOD_FL SMALLINT SET DEFAULT '0' ,
CHANGE COLUMN VIEW_FL SMALLINT SET DEFAULT '1' ,
CHANGE COLUMN MULT_FL SMALLINT SET DEFAULT '0' ;

---END---
ALTER TABLE SBI_FEDERATION_DEFINITION ADD OWNER VARCHAR(100) NULL ;

---BEGIN---

SP_RENAME 'SBI_OBJ_PARUSE', 'SBI_OBJ_PARUSE_OLD';
SELECT ROW_NUMBER() OVER(order by OBJ_PAR_ID) AS PARUSE_ID, a.* INTO SBI_OBJ_PARUSE FROM SBI_OBJ_PARUSE_OLD a;
drop table SBI_OBJ_PARUSE_OLD;
alter table SBI_OBJ_PARUSE alter column PARUSE_ID int not null;
ALTER TABLE SBI_OBJ_PARUSE ADD CONSTRAINT PK_PARUSE_ID PRIMARY KEY (PARUSE_ID);
ALTER TABLE SBI_OBJ_PARUSE ADD CONSTRAINT FK_SBI_OBJ_PARUSE_1 FOREIGN KEY (OBJ_PAR_ID) REFERENCES SBI_OBJ_PAR (OBJ_PAR_ID) ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE SBI_OBJ_PARUSE ADD CONSTRAINT FK_SBI_OBJ_PARUSE_2 FOREIGN KEY (USE_ID) REFERENCES SBI_PARUSE (USE_ID) ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE SBI_OBJ_PARUSE ADD CONSTRAINT FK_SBI_OBJ_PARUSE_3 FOREIGN KEY (OBJ_PAR_FATHER_ID) REFERENCES SBI_OBJ_PAR (OBJ_PAR_ID) ON UPDATE NO ACTION ON DELETE NO ACTION;

SP_RENAME 'SBI_OBJ_PARVIEW', 'SBI_OBJ_PARVIEW_OLD';
SELECT ROW_NUMBER() OVER(order by OBJ_PAR_ID) AS PARVIEW_ID, a.* INTO SBI_OBJ_PARVIEW FROM SBI_OBJ_PARVIEW_OLD a;
drop table SBI_OBJ_PARVIEW_OLD;
alter table SBI_OBJ_PARVIEW alter column PARVIEW_ID int not null;
ALTER TABLE SBI_OBJ_PARVIEW ADD CONSTRAINT PK_PARVIEW_ID PRIMARY KEY (PARVIEW_ID);
ALTER TABLE SBI_OBJ_PARVIEW ADD CONSTRAINT FK_SBI_OBJ_PARVIEW_1 FOREIGN KEY (OBJ_PAR_ID) REFERENCES SBI_OBJ_PAR (OBJ_PAR_ID) ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE SBI_OBJ_PARVIEW ADD CONSTRAINT FK_SBI_OBJ_PARVIEW_2 FOREIGN KEY (OBJ_PAR_FATHER_ID) REFERENCES SBI_OBJ_PAR (OBJ_PAR_ID) ON UPDATE NO ACTION ON DELETE NO ACTION;


---END---
