--*******************************************************************************************************************************
--****************DATA SPECIFIC TO A PARTICULAR CUSTOMER ************************************************************************
--*******************************************************************************************************************************

--emergencyhound.com settings
update T_OE_APP_SETTINGS set SETTING_VALUE = 'emergencyhound.noreply@gmail.com' where SETTING_NAME = 'EMAIL_FROM';
update T_OE_APP_SETTINGS set SETTING_VALUE = 'smtp.gmail.com' where SETTING_NAME = 'EMAIL_SERVER';
update T_OE_APP_SETTINGS set SETTING_VALUE = '587' where SETTING_NAME = 'EMAIL_PORT';
update T_OE_APP_SETTINGS set SETTING_VALUE = 'Emergencyhound.noreply@gmail.com' where SETTING_NAME = 'EMAIL_SECURE_USER';
update T_OE_APP_SETTINGS set SETTING_VALUE = 'hound4pound' where SETTING_NAME = 'EMAIL_SECURE_PWD';

--mcn settings
update T_OE_APP_SETTINGS set SETTING_VALUE = 'fharjo@mcn-nsn.gov' where SETTING_NAME = 'EMAIL_FROM';
update T_OE_APP_SETTINGS set SETTING_VALUE = '10.10.0.47' where SETTING_NAME = 'EMAIL_SERVER';
update T_OE_APP_SETTINGS set SETTING_VALUE = '25' where SETTING_NAME = 'EMAIL_PORT';
update T_OE_APP_SETTINGS set SETTING_VALUE = '' where SETTING_NAME = 'EMAIL_SECURE_USER';
update T_OE_APP_SETTINGS set SETTING_VALUE = '' where SETTING_NAME = 'EMAIL_SECURE_PWD';
update T_OE_APP_SETTINGS set SETTING_VALUE = 'http://12.238.224.66/emergencyhound' where SETTING_NAME = 'PUBLIC_APP_PATH';


update T_OE_USERS set USER_ID = 'doug.timms@open-environment.org', EMAIL = 'doug.timms@open-environment.org', phone = '609-556-0531', fname='Doug', lname='Timms' where USER_IDX = 1;

insert into T_OE_ORGANIZATIONS (ORG_NAME, ORG_DESC, CREATE_USERIDX, CREATE_DT, MODIFY_USERIDX, MODIFY_DT) values ('Muscogee Creek Nation','Muscogee Creek Nation',0,GetDate(),0,GetDate());
insert into T_OE_ORGANIZATIONS (ORG_NAME, ORG_DESC, CREATE_USERIDX, CREATE_DT, MODIFY_USERIDX, MODIFY_DT) values ('Seminole Nation','Seminole Nation',0,GetDate(),0,GetDate());
insert into T_OE_ORGANIZATIONS (ORG_NAME, ORG_DESC, CREATE_USERIDX, CREATE_DT, MODIFY_USERIDX, MODIFY_DT) values ('Kickapoo Tribe','Kickapoo Tribe',0,GetDate(),0,GetDate());
insert into T_OE_ORGANIZATIONS (ORG_NAME, ORG_DESC, CREATE_USERIDX, CREATE_DT, MODIFY_USERIDX, MODIFY_DT) values ('Potawatomi Nation','Citizen Potawatomi Nation',0,GetDate(),0,GetDate());
update T_OE_ORGANIZATIONS set ACT_IND = 1, ALLOW_JOIN_IND = 1;

insert into T_EM_USER_ORG (ORG_IDX, USER_IDX, ROLE_CD, STATUS_CD) (select ORG_IDX, 1, 'A', 'A' from T_OE_ORGANIZATIONS where ORG_NAME = 'Muscogee Creek Nation');


-- ***************** DEMO DATA *****************************
INSERT INTO T_EM_USER_NOTIFICATION ([USER_IDX],[NOTIFY_DT],[NOTIFY_TYPE],[NOTIFY_TITLE],[NOTIFY_DESC],[READ_IND],[FROM_USER_IDX])
     VALUES   (1, '4/4/2015', 'EMAIL', 'Shelter #2 at full capacity', 'Shelter #2 at full capacity', 0, null);

INSERT INTO T_EM_USER_NOTIFICATION ([USER_IDX],[NOTIFY_DT],[NOTIFY_TYPE],[NOTIFY_TITLE],[NOTIFY_DESC],[READ_IND],[FROM_USER_IDX])
     VALUES   (1, '5/5/2015', 'UPDATE', '4 buildings destroyed 2nd St Beggs', '4 buildings destroyed 2nd St Beggs', 0, null);

GO

