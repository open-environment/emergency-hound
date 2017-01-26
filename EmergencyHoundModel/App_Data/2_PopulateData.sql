--*******************************************************************************************************************************
--****************GLOBAL REFERENCE DATA - APPLIES TO ALL CUSTOMERS  *************************************************************
--*******************************************************************************************************************************


--****************GENERAL APP SETTINGS  *****************************************************************************************
INSERT INTO T_OE_APP_SETTINGS ([SETTING_NAME],[SETTING_VALUE],[MODIFY_USERIDX],[MODIFY_DT]) VALUES ('EMAIL_FROM','emergencyhound.noreply@change.me',0,GetDate());
INSERT INTO T_OE_APP_SETTINGS ([SETTING_NAME],[SETTING_VALUE],[MODIFY_USERIDX],[MODIFY_DT]) VALUES ('EMAIL_SERVER','smtp.changeme.com',0,GetDate());
INSERT INTO T_OE_APP_SETTINGS ([SETTING_NAME],[SETTING_VALUE],[MODIFY_USERIDX],[MODIFY_DT]) VALUES ('EMAIL_PORT','25',0,GetDate());
INSERT INTO T_OE_APP_SETTINGS ([SETTING_NAME],[SETTING_VALUE],[MODIFY_USERIDX],[MODIFY_DT]) VALUES ('EMAIL_SECURE_USER','smtp@change.me',0,GetDate());
INSERT INTO T_OE_APP_SETTINGS ([SETTING_NAME],[SETTING_VALUE],[MODIFY_USERIDX],[MODIFY_DT]) VALUES ('EMAIL_SECURE_PWD','change.me',0,GetDate());
INSERT INTO T_OE_APP_SETTINGS ([SETTING_NAME],[SETTING_VALUE],[MODIFY_USERIDX],[MODIFY_DT]) VALUES ('PUBLIC_APP_PATH','http://www.emergencyhound.com',0,GetDate());

--****************APP ROLES *****************************************************************************************
insert into T_OE_ROLES (ROLE_NAME, ROLE_DESC, CREATE_USERIDX, CREATE_DT) values ('Admins', 'Application Administrator can access administrative functions', 0, GetDate());
insert into T_OE_ROLES (ROLE_NAME, ROLE_DESC, CREATE_USERIDX, CREATE_DT) values ('Users', 'General basic user privileges', 0, GetDate());

--****************APP USERS*****************************************************************************************
insert into T_OE_USERS (USER_ID, PWD_HASH, PWD_SALT, FNAME, LNAME, EMAIL, ACT_IND, INITAL_PWD_FLAG, EFFECTIVE_DT, LASTLOGIN_DT, PHONE, PHONE_EXT, CREATE_USERIDX, CREATE_DT, MODIFY_USERIDX, MODIFY_DT)
values ('system', 'notused','notused', 'system','','notused', 0, 0, GETDATE(), null, null, null, 0,GETDATE(),0,GETDATE());

insert into T_OE_USERS (USER_ID, PWD_HASH, PWD_SALT, FNAME, LNAME, EMAIL, ACT_IND, INITAL_PWD_FLAG, EFFECTIVE_DT, LASTLOGIN_DT, PHONE, PHONE_EXT, CREATE_USERIDX, CREATE_DT, MODIFY_USERIDX, MODIFY_DT)
values ('superadmin@change.me', 'pwd','', 'First','Last','superadmin@change.me', 1,1,GETDATE(),null, '555-555-5555', null, 0,GETDATE(),0,GETDATE());

--****************APP USER ROLES *****************************************************************************************
insert into T_OE_USER_ROLES (USER_IDX, ROLE_IDX) values (1,1);
insert into T_OE_USER_ROLES (USER_IDX, ROLE_IDX) values (1,2);


--**************** REF_STATE ***********************************************************************************************

INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('AK','Alaska');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('AL','Alabama');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('AZ','Arizona');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('AR','Arkansas');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('CA','California');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('CO','Colorado');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('CT','Connecticut');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('DE','Delaware');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('FL','Florida');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('GA','Georgia');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('HI','Hawaii');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('ID','Idaho');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('IL','Illinois');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('IN','Indiana');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('IA','Iowa');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('KS','Kansas');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('KY','Kentucky');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('LA','Louisiana');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('ME','Maine');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('MD','Maryland');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('MA','Massachusetts');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('MI','Michigan');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('MN','Minnesota');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('MS','Mississippi');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('MO','Missouri');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('MT','Montana');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('NE','Nebraska');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('NV','Nevada');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('NH','New Hampshire');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('NJ','New Jersey');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('NM','New Mexico');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('NY','New York');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('NC','North Carolina');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('ND','North Dakota');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('OH','Ohio');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('OK','Oklahoma');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('OR','Oregon');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('PA','Pennsylvania');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('RI','Rhode Island');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('SC','South Carolina');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('SD','South Dakota');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('TN','Tennesee');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('TX','Texas');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('UT','Utah');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('VT','Vermont');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('VA','Virginia');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('WA','Washington');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('WV','West Virginia');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('WI','Wisconsin');
INSERT INTO T_OE_REF_STATE (STATE_CD,STATE_NAME) VALUES ('WY','Wyoming');





--****************REF_INCIDENT_PRIORITY ************************************************************************************
INSERT INTO T_EM_REF_INCIDENT_PRIORITY ([INCIDENT_PRIORITY],[SORT_ORD],[ACT_IND],[CREATE_USERIDX],[CREATE_DT]) VALUES ('High', 1, 1, 0, GetDate());
INSERT INTO T_EM_REF_INCIDENT_PRIORITY ([INCIDENT_PRIORITY],[SORT_ORD],[ACT_IND],[CREATE_USERIDX],[CREATE_DT]) VALUES ('Medium', 2, 1, 0, GetDate());
INSERT INTO T_EM_REF_INCIDENT_PRIORITY ([INCIDENT_PRIORITY],[SORT_ORD],[ACT_IND],[CREATE_USERIDX],[CREATE_DT]) VALUES ('Low', 3, 1, 0, GetDate());


--****************REF_RESOURCE_STATUS ************************************************************************************
insert into T_EM_REF_RESOURCE_STATUS (RESOURCE_STATUS_CD, RESOURCE_STATUS_NAME, CREATE_USERIDX, CREATE_DT) values ('A', 'Available', 0, GetDate());
insert into T_EM_REF_RESOURCE_STATUS (RESOURCE_STATUS_CD, RESOURCE_STATUS_NAME, CREATE_USERIDX, CREATE_DT) values ('U', 'Unavailable', 0, GetDate());
insert into T_EM_REF_RESOURCE_STATUS (RESOURCE_STATUS_CD, RESOURCE_STATUS_NAME, CREATE_USERIDX, CREATE_DT) values ('D', 'Decommissioned', 0, GetDate());
insert into T_EM_REF_RESOURCE_STATUS (RESOURCE_STATUS_CD, RESOURCE_STATUS_NAME, CREATE_USERIDX, CREATE_DT) values ('I', 'In-Transit', 0, GetDate());

--****************T_REF_SHARE_TYPE ************************************************************************************
INSERT INTO T_EM_REF_SHARE_TYPE (SHARE_TYPE,SHARE_DESC,ACT_IND) values ('Jurisdiction', 'Only allow users of same jurisdiction to view', 1);
INSERT INTO T_EM_REF_SHARE_TYPE (SHARE_TYPE,SHARE_DESC,ACT_IND) values ('All Jurisdictions', 'Share with all jurisdictions', 1);
INSERT INTO T_EM_REF_SHARE_TYPE (SHARE_TYPE,SHARE_DESC,ACT_IND) values ('Public', 'Share with the Public', 1);

--****************T_REF_DOC_TYPE ************************************************************************************
INSERT INTO T_EM_REF_DOC_TYPE (DOC_TYPE,DOC_TYPE_DESC,ACT_IND,CREATE_USERIDX,CREATE_DT) VALUES ('SOP', 'SOP', 1, 0, GetDate());
INSERT INTO T_EM_REF_DOC_TYPE (DOC_TYPE,DOC_TYPE_DESC,ACT_IND,CREATE_USERIDX,CREATE_DT) VALUES ('Users Manual', 'Users Manual', 1, 0, GetDate());
INSERT INTO T_EM_REF_DOC_TYPE (DOC_TYPE,DOC_TYPE_DESC,ACT_IND,CREATE_USERIDX,CREATE_DT) VALUES ('Report', 'Report', 1, 0, GetDate());
INSERT INTO T_EM_REF_DOC_TYPE (DOC_TYPE,DOC_TYPE_DESC,ACT_IND,CREATE_USERIDX,CREATE_DT) VALUES ('Assessment', 'Assessment', 1, 0, GetDate());

--****************T_REF_DOC_STATUS_TYPE ************************************************************************************
INSERT INTO T_EM_REF_DOC_STATUS_TYPE (DOC_STATUS_TYPE,ACT_IND,CREATE_USERIDX,CREATE_DT) VALUES ('Current',1,0,GetDate());
INSERT INTO T_EM_REF_DOC_STATUS_TYPE (DOC_STATUS_TYPE,ACT_IND,CREATE_USERIDX,CREATE_DT) VALUES ('Archive',1,0,GetDate());
INSERT INTO T_EM_REF_DOC_STATUS_TYPE (DOC_STATUS_TYPE,ACT_IND,CREATE_USERIDX,CREATE_DT) VALUES ('Historical',1,0,GetDate());

--****************REF_INC_STATUS_TYPE ************************************************************************************
insert into T_EM_REF_INC_STATUS_TYPE (STATUS_TYPE_CD, STATUS_DESC) values ('Situation Summary', 'Situation Summary');
insert into T_EM_REF_INC_STATUS_TYPE (STATUS_TYPE_CD, STATUS_DESC) values ('Health/Safety Brief', 'Health and Safety Briefing');
insert into T_EM_REF_INC_STATUS_TYPE (STATUS_TYPE_CD, STATUS_DESC) values ('Significant Event', 'Significant Event');

--****************INCIDENT COMPLEXITY LEVELS ************************************************************************************
insert into T_EM_REF_COMPLEX_LVL (INCIDENT_COMPLEX_LVL, COMPLEX_LVL_DESC) values ('Type 1', 'This type of incident is the most complex, requiring national resources for safe and effective management and operation');
insert into T_EM_REF_COMPLEX_LVL (INCIDENT_COMPLEX_LVL, COMPLEX_LVL_DESC) values ('Type 2', 'This type of incident extends beyond the capabilities for local control and is expected to go into multiple operational periods. A Type 2 incident may require the response of resources out of area, including regional and/or national resources, to effectively manage the operations, command, and general staffing');
insert into T_EM_REF_COMPLEX_LVL (INCIDENT_COMPLEX_LVL, COMPLEX_LVL_DESC) values ('Type 3', 'When incident needs exceed capabilities, the appropriate ICS positions should be added to match the complexity of the incident.');
insert into T_EM_REF_COMPLEX_LVL (INCIDENT_COMPLEX_LVL, COMPLEX_LVL_DESC) values ('Type 4', 'Command staff and general staff functions are activated only if needed.');
insert into T_EM_REF_COMPLEX_LVL (INCIDENT_COMPLEX_LVL, COMPLEX_LVL_DESC) values ('Type 5', 'The incident can be handled with one or two single resources with up to six personnel.');

--****************INCIDENT MANAGEMENT TEAMS ************************************************************************************
INSERT INTO T_EM_REF_MANAGEMENT_ORG(INC_MANAGEMENT_ORG_CD,COMPLEX_LVL_DESC) VALUES ('IMT1','Incident Management Team - Type 1');
INSERT INTO T_EM_REF_MANAGEMENT_ORG(INC_MANAGEMENT_ORG_CD,COMPLEX_LVL_DESC) VALUES ('IMT2','Incident Management Team - Type 2');
INSERT INTO T_EM_REF_MANAGEMENT_ORG(INC_MANAGEMENT_ORG_CD,COMPLEX_LVL_DESC) VALUES ('IMT3','Incident Management Team - Type 3');
INSERT INTO T_EM_REF_MANAGEMENT_ORG(INC_MANAGEMENT_ORG_CD,COMPLEX_LVL_DESC) VALUES ('UC','Unified Command');


--****************QUAL_CATEGORY ***********************************************************************************************
INSERT INTO T_EM_REF_QUAL_CATEGORY (QUAL_CAT_NAME,QUAL_TYPE_DESC,QUAL_CAT_COLOR,CREATE_USERIDX,CREATE_DT) VALUES ('Incident Management','Incident Management','',0,GetDate());
INSERT INTO T_EM_REF_QUAL_CATEGORY (QUAL_CAT_NAME,QUAL_TYPE_DESC,QUAL_CAT_COLOR,CREATE_USERIDX,CREATE_DT) VALUES ('Public Works','Public Works','',0,GetDate());
INSERT INTO T_EM_REF_QUAL_CATEGORY (QUAL_CAT_NAME,QUAL_TYPE_DESC,QUAL_CAT_COLOR,CREATE_USERIDX,CREATE_DT) VALUES ('Communications','Communications','',0,GetDate());
INSERT INTO T_EM_REF_QUAL_CATEGORY (QUAL_CAT_NAME,QUAL_TYPE_DESC,QUAL_CAT_COLOR,CREATE_USERIDX,CREATE_DT) VALUES ('Emergency Management','Emergency Management','',0,GetDate());
INSERT INTO T_EM_REF_QUAL_CATEGORY (QUAL_CAT_NAME,QUAL_TYPE_DESC,QUAL_CAT_COLOR,CREATE_USERIDX,CREATE_DT) VALUES ('Fire','Firefighting','',0,GetDate());
INSERT INTO T_EM_REF_QUAL_CATEGORY (QUAL_CAT_NAME,QUAL_TYPE_DESC,QUAL_CAT_COLOR,CREATE_USERIDX,CREATE_DT) VALUES ('Search & Rescue','Search & Rescue','',0,GetDate());
INSERT INTO T_EM_REF_QUAL_CATEGORY (QUAL_CAT_NAME,QUAL_TYPE_DESC,QUAL_CAT_COLOR,CREATE_USERIDX,CREATE_DT) VALUES ('HazMat','HazMat','',0,GetDate());
INSERT INTO T_EM_REF_QUAL_CATEGORY (QUAL_CAT_NAME,QUAL_TYPE_DESC,QUAL_CAT_COLOR,CREATE_USERIDX,CREATE_DT) VALUES ('Medical','Medical','',0,GetDate());
INSERT INTO T_EM_REF_QUAL_CATEGORY (QUAL_CAT_NAME,QUAL_TYPE_DESC,QUAL_CAT_COLOR,CREATE_USERIDX,CREATE_DT) VALUES ('EMS','EMS','',0,GetDate());
INSERT INTO T_EM_REF_QUAL_CATEGORY (QUAL_CAT_NAME,QUAL_TYPE_DESC,QUAL_CAT_COLOR,CREATE_USERIDX,CREATE_DT) VALUES ('Public Health','Public Health','',0,GetDate());
INSERT INTO T_EM_REF_QUAL_CATEGORY (QUAL_CAT_NAME,QUAL_TYPE_DESC,QUAL_CAT_COLOR,CREATE_USERIDX,CREATE_DT) VALUES ('Agriculture/Animal Control','Agriculture/Animal Control','',0,GetDate());
INSERT INTO T_EM_REF_QUAL_CATEGORY (QUAL_CAT_NAME,QUAL_TYPE_DESC,QUAL_CAT_COLOR,CREATE_USERIDX,CREATE_DT) VALUES ('Public Safety & Security','Public Safety & Security','',0,GetDate());
INSERT INTO T_EM_REF_QUAL_CATEGORY (QUAL_CAT_NAME,QUAL_TYPE_DESC,QUAL_CAT_COLOR,CREATE_USERIDX,CREATE_DT) VALUES ('Volunteer','Volunteer','',0,GetDate());
INSERT INTO T_EM_REF_QUAL_CATEGORY (QUAL_CAT_NAME,QUAL_TYPE_DESC,QUAL_CAT_COLOR,CREATE_USERIDX,CREATE_DT) VALUES ('Chaplain/Clergy','Chaplain/Clergy','',0,GetDate());


--****************QUAL_TYPE ***********************************************************************************************
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'FSC3','Finance/Administration Section Chief (Type 3)','A Finance/Administration Section Chief (Type 3) is responsible for all financial, administrative, and cost analysis aspects of an incident.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Incident Management');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'ICT3','Incident Commander','An Incident Commander has overall authority and responsibility for conducting incident operations and is responsible for the management of all incident operations at the incident site.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Incident Management');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'LOF3','Liaison Officer (Type 3)','A Liaison Officer (Type 3) is responsible for coordinating with cooperating and assisting agencies.',0,GetDate()  from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Incident Management');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'LSC3','Logistics Section Chief (Type 3)','A Logistics Section Chief (Type 3) is responsible for providing facilities, services and material support for the incident, including all essential services and support functions needed for the incident management team to conduct effective operations.',0,GetDate()  from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Incident Management');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'OSC3','Operations Section Chief (Type 3)','An Operations Section Chief (Type 3) is responsible for all tactical incident operations, including the activation and supervision of ICS organizational elements in accordance with and in execution of the Incident Action Plan (IAP).',0,GetDate()  from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Incident Management');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'PSC3','Planning Section Chief (Type 3)','A Planning Section Chief (Type 3) is responsible for the collection, evaluation, dissemination of operational information related to the incident, and for the preparation and documentation of the Incident Action Plan (IAP).',0,GetDate()  from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Incident Management');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'PIO3','Public Information Officer (Type 3)','A Public Information Officer (Type 3) is responsible for interfacing with the public and media or with other agencies with incident-related information requirements.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Incident Management');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'SOF3','Safety Officer (Type 3)','A Safety Officer (Type 3) is responsible for monitoring and assessing safety hazards or unsafe situations and for developing measures for ensuring personnel safety.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Incident Management');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'DIVS','Division / Group Supervisor','The Division/Group Supervisor - reports to the Operations Section Chief (OPS) (or Branch Director when activated). The Division/Group Supervisor is responsible for the implementation of the assigned portion of the Incident Action Plan (IAP), assignment of resources within the Division/Group, and reporting on the progress of control operations and status of resources within the Division/Group. The Division / Group Supervisor provides operational briefing to Task Force Leaders when assigned.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Incident Management');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'TFLD','Task Force Leader','A The Task Force Leader reports to a Division/Group Supervisor or Incident Commander and is responsible for performing tactical assignments assigned to the Task Force. The Task Force Leader reports work progress, resources status, and other important information to a Division/Group Supervisor or Incident Commander, and maintains work records on assigned personnel.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Incident Management');

INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'CFE','Civil/Field Engineer','A Civil/Field Engineer provides general engineering support to emergency response and recovery operations. This position operates at a Branch, Division/Group, or Strike Team/Task Force level based upon Incident Commanders needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Works');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'CSWM','Certified Storm Water Manager','The Storm Water Quality Manager assists the Public Works Director with potential environmental water quality issues during an emergency situation. Possible issues might include contaminated runoff from fires, ruptured/damaged or leaking above ground storage tanks, household hazardous waste, damage to oil wells, debris removal and preliminary disaster assessments. This position may be in the Incident Command, a Branch, Division/Group, or Strike Team/Task Force, based upon mission-specific activities and needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Works');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'HEO','Heavy Equipment Operator','A Heavy Equipment Operator performs physical activities involving the operation of vehicles and equipment for recovery and response activities. This position operates primarily at a Division/Group, Strike Team/Task Force level based upon Incident Commanders needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Works');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'PWD','Public Works Director','A Public Works Director serves as an advisor to the policy group on matters pertaining to the preservation and restoration of lifelines during an emergency situation to include all aspects of a response and recovery operation. This position operates at a Strike Team/Task Force level based upon mission-specific activities and needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Works');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'PWSO','Public Works Safety Officer','A Public Works Safety Officer assists the Public Works Director/Incident Commander in monitoring safety during all departmental activities. The Safety Officer works under the general guidance and direction of the Public Works Director/Incident Commander at the event and supervises all employees regarding personal safety. Identifies potential safety hazards and takes actions or makes recommendations to eliminate the hazard. Knowledge of federal and state laws related to the safety of people and property. The Safety Officer is responsible for the researching, planning, designing, implementing, directing, and evaluating safety programs. Also conducts systematic investigations and analysis of incidents involving personnel, programs and properties.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Works');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'SE','Structural Engineer','A Structural Engineer oversees, inspects, and assesses impacted structures and makes appropriate recommendations. This position operates at a Branch, Division/Group, or Strike Team/Task Force level based upon mission-specific activities and needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Works');

INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'COML','Communications Unit Leader','A Communications Unit Leader (COML) is defined by DHS as “a person that plans and manages the technical and operational aspects of the communications function during an all-hazards incident or event.” At larger incidents, the COML is a supervisor and manages subordinate positions within the Communications Unit.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Communications');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'COMT','Communications Unit Technician','A Communications Unit Technician (COMT) is defined by DHS as “the person responsible for supporting the technical activities of the Communications Unit, (by) performing radio programming, maintenance and repair, gateway and cache radio management.” The COMT reports directly to the COML; however, in some situations the COMT may be required to manage the Communications Unit, should a COML be unavailable. Therefore, a COMT must have a basic understanding of the roles and responsibilities of the COML.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Communications');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'EART','Emergency Amateur Radio Technician','An Emergency Amateur Radio Technician is an individual capable of using a designated radio frequency spectrum for the purpose of emergency communication. This person uses a variety of voice, text, image, and data communications modes with access to frequency allocations throughout the RF Spectrum that will allow emergency communication across the city, state, and even the county in the event that normal communication avenues are no longer functioning. This position may be assigned to the communications group or other position as determined by the incident needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Communications');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'PSTD','Public Safety Telecommunicator/ Dispatcher','A Public Safety Telecommunicator/Dispatcher uses a computer-aided dispatch system; receive emergency calls from the public requesting police, fire, medical or other emergency services. Determine the nature and location of the emergency; determine priorities, and dispatch police, fire ambulance or other emergency units as necessary and in accordance with established procedures. Receive and process 911 emergency calls, maintain contact with all units on assignment, maintain status and location of police and fire units. Monitor direct emergency alarms, answer non-emergency calls for assistance. Enter, update and retrieve information from a variety of computer systems. Receive requests for information regarding vehicle registration, driving records and warrants, and provides pertinent data. Monitor several complex public safety radio frequencies. Operate a variety of communications equipment, including radio consoles, telephones and computer systems.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Communications');

INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'EMAD','Emergency Management Director','An Emergency Resource Management Director is an individual involved in All Hazard response, Planning, Mitigation, and Resource Management to assist Local Incident Commanders.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Emergency Management');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'EMAS','Emergency Management Staff','An Emergency Management Staff is an individual who is employed by a State, Local, or Tribal Jurisdiction who works in support of Emergency Management Directors.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Emergency Management');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'EMAV','Emergency Management Volunteer','An Emergency Management Volunteer is an individual who works in a volunteer capacity to support an Emergency Management Director',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Emergency Management');

INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'ARFF','Airport Firefighter','An Airport Firefighter is an integral member of an aircraft rescue and firefighting (ARFF) team.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'EVT','Emergency Vehicle Technician','An Emergency Vehicle Technician performs inspection, diagnosis, maintenance, repair and testing on emergency response vehicles.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'FADO','Fire Apparatus Driver/Operator','A Fire Apparatus Driver/Operator is an integral member of a firefighting team who drives and operates fire apparatus. Examples of these apparatus may include: Pumping Apparatus; HazMat Apparatus; Rescue Apparatus; Aerial Apparatus; Tiller Apparatus; Wild-land Fire Apparatus; Aircraft Rescue and firefighting Apparatus; and/or Mobile Water Supply Apparatus.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'FF1','Firefighter 1','A Firefighter 1 is an integral member of a firefighting team working under direct supervision.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'FF2','Firefighter 2','A Firefighter 2 is an integral member of a firefighting team working under general supervision and may assume command of that team if necessary (to include Firefighters 1 and 2)',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'FINS1','Fire Inspector 1','A Fire Inspector 1 conducts fire inspections and applies codes and standards.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'FINS2','Fire Inspector 2','A Fire Inspector 2 conducts fire inspections and interprets applicable codes and standards.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'FOCO','Fire Officer Company/Unit','A Fire Officer-Company/Unit provides supervisory or managerial function for a company/unit up to six members, typically at the tactical and task level.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'FOCM','Fire Officer Command','A Fire Officer-Command provides managerial and administrative function for multiple companies/units at the strategic and/or tactical level.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'OKSFF','Oklahoma Support Firefighter','The Support Firefighter prepares a firefighter to work on the fire scene in a support capacity, operating rigs and assisting with wild-land firefighting set-up and preparations.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'OKBFF','Oklahoma Basic Firefighter','The Oklahoma Basic Firefighter level builds on the Support Level and prepares a firefighter to effectively combat wildland fires and respond to various types of accidents (e.g., automobile).',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'OKIFF','Oklahoma Intermediate Firefighter','The Oklahoma Intermediate Fighter is the minimum level for structural, interior fire attacks. This is the minimum level for “paid firefighters.”',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'OKAFF','Oklahoma Advanced Firefighter','The Oklahoma Advanced Firefighter level requires the completion of Firefighter 1 and for career firefighters it must be completed within 18 months of employment. See also Firefighter 1 Qualification.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'OKMFF','Oklahoma Master Firefighter','The Oklahoma Master Firefighter is the highest COFT level and requires the completion of Firefighter 2 and EMT Basic. For career firefighters, it must be completed within 36 months of employment. See also Firefighter 2 Qualification.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'VFF','Volunteer FF (BFFS)','A Volunteer (BFFS) is an individual who is a member of a small rural department that primarily performs limited structural and wildland firefighting functions under moderate supervision.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'WFF1','Wildland Firefighter I','A Wildland Firefighter 1 is an integral member of a wildland fire suppression crew working under direct supervision.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'WFF2','Wildland Firefighter II','Wildland Firefighter 2 is an integral member of a wildland fire suppression crew working under general supervision.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'WFO','Wildland Fire Officer/Single Resource Boss','A Wildland Fire Officer/Single Resource Boss is responsible for supervising and directing a single wildland fire suppression resource.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Fire');

INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'CST','Canine Search Technician','A Canine Search Technician is a pairing of one handler and one canine trained to search for and detect human scent in failed structures and natural debris fields.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Search & Rescue');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'HSART','Helicopter Search and Rescue Technician','A Helicopter Search and Rescue Technician is an entry level position within a helicopter rescue unit (single resource) that performs search and rescue functions inside and outside the aircraft and typically may include rappelling, short haul, hoist operations, and water insertions on any of the following credential-specific disciplines; search, rescue, urban, wilderness, mountain, disaster Stillwater, Swiftwater, etc.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Search & Rescue');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'PSD','Public Safety Diver','A Public Safety Diver affiliated with a State, Local or Tribal response jurisdictional or certified Volunteer Fire Department assists with any underwater search and recoveries. This position operates primarily at a Division/Group, Strike Team/Task Force level based upon Incident Commanders needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Search & Rescue');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'SWRT','Swiftwater/Flood Rescue Technician','A Swiftwater/Flood Rescue Technician is an entry level position within a water rescue task force that responds to searches and rescues from shore and in water consistent with NFPA 1006.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Search & Rescue');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'TSART','Technical Search and Rescue Technician','A Technical Search and Rescue Technician responds to SAR incidents, identifies hazards, uses equipment, and applies advanced techniques specified in NFPA 1670 and 1006 necessary to coordinate, perform, and supervise technical SAR incidents in the following areas: Trench, rope, confined space, and vehicle and machinery.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Search & Rescue');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'USART','Urban/Structural Collapse Search and Rescue Technician','An Urban/Structural Collapse Search and Rescue Technician identifies hazards, uses equipment, and applies advanced search and rescue techniques in collapsed buildings.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Search & Rescue');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'WSART','Wilderness Search and Rescue Technician','A Wilderness Search and Rescue Technician is a member of a Wilderness ASAR Team who searches for and rescues those in trouble in rural environments.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Search & Rescue');

INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'HAZO','HazMat Officer','A HazMat Officer is an integral member of a hazardous materials response team or crew and serves as manager and/or supervisor.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='HazMat');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'HAZT','HazMat Technician','A HazMat Technician is an individual or team member who responds to releases or potential releases of hazardous substances for the purpose of protecting persons, property, or the environment and stopping the release.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='HazMat');

INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'APRN','Advanced Practice Registered Nurse','The primary role of the Advanced Practice Registered Nurse (APRN) is to function as a health care professional licensed to diagnose and treat a range of health problems, working either independently or in collaboration with a physician or other licensed independent practitioner. APRNs specialize and most become certified in such areas as anesthesia, emergency care, pediatrics, geriatrics, family, obstetrics, psychiatry and acute care.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Medical');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'BHSL','Behavioral Health Specialist (Licensed)','The primary role of the Behavioral Health Specialist (Licensed) is to function as a mental health or substance abuse professional in a disaster setting. A behavioral health specialist is qualified to provide behavioral health triage, assessment and stabilization or referral of responders and affected populations. In addition, a licensed behavioral health specialist, including but not limited to psychologists, LMFT, LCSW, Licensed Professional Counselors are qualified to provide and supervise diagnosis and treatment of mental and emotional disorders within the context of various family systems.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Medical');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'LPN','Licensed Practical Nurse','The primary role of the Licensed Practical Nurse is to provide health care under supervision of a physician to individuals, families, and communities. The LPN provides services designed to promote health, prevent illness, and achieve optimal recovery from or adaptation to health problems. The LPN possesses the education and experience in the practice setting commensurate with the mission assignment.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Medical');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'MD','Physician','A Physician is an independent health care professional trained in health promotion, disease prevention and comprehensive health care.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Medical');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'PA','Physician Assistant','A Physician Assistant is a health care professional trained in health promotion, disease prevention and comprehensive health care working under the general supervision of a licensed physician.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Medical');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'PCT','Patient Care Technician','The primary focus is assisting in direct patient care, planning and assessments including documentation of vital signs, height, weight, input and output, collection of specimens, report and record patient conditions and treatments, and assists with patient mobility, positioning and transfers under the supervision of the nursing staff.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Medical');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'RN','Registered Nurse','The primary role of the Registered Nurse (RN) is to provide health care to individuals, families, and communities. The RN provides services designed to promote health, prevent illness, and achieve optimal recovery from or adaptation to health problems. These services may include, but are not limited to, assessment of the patient’s and family’s health status and needs, clinical treatment, teaching, counseling, coordination of multidisciplinary care, and other patient care needs as assigned in a functional or degraded environment in a variety of settings or assessment levels. The RN possesses the education and experience in the practice setting commensurate with the mission assignment.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Medical');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'SW','Social Worker','Social Worker',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Medical');

INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'AEMT','Advanced Emergency Medical Technician (EMT-Intermediate)','The primary focus of the Advanced Emergency Medical Technician (AEMT) is to provide triage, assessment and limited advanced emergency medical care, under medical oversight. This may occur at an emergency scene until transportation resources arrive, during triage, from and emergency scene to a health care facility, or between health care facilities. The AEMT possesses the education and experience in areas of patient care that are commensurate with the patient care mission, provides care to minimize secondary injury and provides comfort to the patient and family while transporting the patient to an emergency care facility. The major difference between the Advanced Emergency Medical Technician and the Emergency Medical Technician is the AEMT’s ability to perform limited advanced skills and pharmacological interventions.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='EMS');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'EMR','Emergency Medical Responder (First Responder)','The primary focus of the Emergency Medical Responder (EMR) is to initiate immediate lifesaving care to patients who access the emergency medical system. The Emergency medical Responder possesses education and experience in areas of patient care commensurate with the patient care mission. Additionally, the EMR:
*Has the basic knowledge and skills necessary to provide lifesaving interventions while awaiting additional EMS response and to assist higher level personnel at the scene and during transport.
*Functions as part of a comprehensive EMS response, under medical oversight
*Performs initial triage and basic interventions with minimal equipment.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='EMS');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'EMT','Emergency Medical Technician (EMT-Basic)','The primary focus of the Emergency Medical Technician (EMT) is to provide basic triage, assessment, and noninvasive interventions to reduce the morbidity and mortality associated with acute out of hospital medical and traumatic emergencies. This may occur at an emergency scene until transportation resources arrive, from an emergency scene to a health care facility or between health care facilities. Additionally, the EMT possesses the education and experience in areas of patient care that are commensurate with the patient care mission, providing care to minimize secondary injury and provide comfort to the patient and family while transporting the patient to an emergency care facility. The EMT level is the minimum licensure level for personnel transporting patients in ambulances.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='EMS');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'EMTP','Emergency Medical Technician Paramedic (EMT-P)','The primary focus of the Paramedic (EMTP) is to provide emergency care based on an advanced assessment and the formulation of a field impression, including basic and advanced skills focusing on the acute management and transportation of the broad range of patients who access the emergency medical system. The paramedic: 1. Possesses the education and experience in areas of medicine and pre-hospital care commensurate with the patient care mission. 2. Skills include triage, assessment, ongoing monitoring capabilities as well as invasive and pharmacological interventions to reduce the morbidity and mortality associated with acute out-of-hospital medical nad traumatic emergencies. 3. Provides care designed to minimize secondary injury and provide comfort to the patient and family while transporting the patient to an appropriate health care facility.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='EMS');

INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'EHSS','Environmental Health Specialist','The primary purpose of the Environmental Health Specialist is to provide professional guidance on specific area such as environmental epidemiology, toxicology, exposure assessment/risk analysis, radiations training and response, as needed for the incident.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Health');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'EPI','Epidemiologist','The primary purpose of an epidemiologist is to compile, interpret and analyze epidemiologic information during an incident. An epidemiologist interfaces with environmental agencies, other public health disciplines and laboratories.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Health');

INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'ACM','Animal Case Manager','An Animal Case Manager assists in reuniting displaced animal. An ACM oversees animal welfare while in custodial care and maintains appropriate records and reports pertaining to animals and ownership.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Agriculture/Animal Control');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'ACS','Animal Control Specialist','An Animal Control Specialist captures and evacuates (extricates) animals. An ACS restrains dangerous and fractious animals safely and humanely. Advises on euthanasia of dangerous animals. Coordinates animal operations at impacted sites. Identifies and counts animals and their populations. Advises on species management.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Agriculture/Animal Control');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'ADE','Animal Disease Epidemiologist','An Animal Disease Epidemiologist investigates diseases in animal populations. An Epidemiologist identifies animal, age and environmental risk factors for animal disease transmission as well as other factors that may adversely affect animals.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Agriculture/Animal Control');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'AHT','Animal Health Technician','An Animal Health Technician assists with animal health care and animal depopulation. Collects specimens from animal and assists with establishing and maintaining medical records. Identifies and counts animal premises. Provides for live animal inspection and may work as an assistant to Veterinarian.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Agriculture/Animal Control');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'ASM','Animal Shelter Manager','An Animal Shelter Manager is an individual who supervises and coordinates temporary animal shelters and housing for displaced animals.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Agriculture/Animal Control');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'LAE','Livestock Agriculture Economist','A Livestock Agriculture Economist advises on economic impact of livestock disease control measures upon the economy.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Agriculture/Animal Control');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'VCS','Vector Control Specialist','A Vector Control Specialist is an individual who advises on pest and vector control during an emergency incident.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Agriculture/Animal Control');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'DVM','Veterinarian','Same as Animal Medical Technician as well as investigates cases of animal diseases and performs clinical examinations and makes diagnoses of animal diseases. A veterinarian identifies the presence of risk reduction procedures for animal to animal disease transmission. Provides for the healthcare to animals as well as advises on Animal depopulation and euthanasia and oversees Vaccination of animals and disease control and prevention. Monitors and recommends humane care standards of animals',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Agriculture/Animal Control');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'WCB','Wildlife Control Biologist','A Wildlife Control Biologist safely captures, restrains, evacuates and handles wildlife. Wildlife Control Biologists advise on euthanasia of wildlife and assess the needs of wildlife. Coordinates census of wildlife and identifies appropriate wildlife premises. Coordinates in wildlife management operations at impacted sites. Performs research on various types of wildlife and their premises.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Agriculture/Animal Control');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'WCS','Wildlife Control Specialist','A Wildlife Control Specialist safely captures, restrains, evacuates and handles wildlife. Advises on euthanasia of wildlife. Assesses the needs of wildlife. Coordinates census of wildlife and identifies appropriate wildlife premises. Coordinates in wildlife management operations at impacted sites.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Agriculture/Animal Control');


INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'AREI','Arson/Explosive Investigator','A Law enforcement officer that operates as a team with fire department personnel to investigate arson fires. This position operates primarily at a Division/Group, Strike Team/Task Force level based upon Incident Commanders needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Safety & Security');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'CDO','Correctional Detention Officer','This position is assigned responsibility related to custody duties of inmates in a state adult correctional facility. Correctional Security Officers are deemed peace officers and may perform functions as determined necessary by the AHJ This position operates primarily at a Division/Group, Strike Team/Task Force level based upon Incident Commanders needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Safety & Security');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'CHCDS','Canine Handler: Controlled Dangerous Substances','A Law enforcement officer that operates as a team with a certified Controlled Dangerous Substance Canine. This position operates primarily at a Division/Group, Strike Team/Task Force level based upon Incident Commanders needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Safety & Security');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'CHE','Canine Handler: Explosives','A law enforcement officer that operates as a team with a certified Explosives Animal. This position operates primarily at a Division/Group, Strike Team/Task Force level based upon Incident Commanders needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Safety & Security');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'CLEET','Oklahoma Law Enforcement Officer: Basic','A Basic Level peace officer employed with a State, Local or Tribal Jurisdiction. This position operates primarily at a Division/Group, Strike Team/Task Force level based upon Incident Commanders needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Safety & Security');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'CLEETI','Oklahoma Law Enforcement Officer: Intermediate','An Intermediate Level peace officer employed with a State, Local or Tribal Jurisdiction. This position operates primarily at a Division/Group, Strike Team/Task Force level based upon Incident Commanders needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Safety & Security');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'CLEETA','Oklahoma law Enforcement Officer: Advanced','A Basic Level peace officer employed with a State, Local or Tribal Jurisdiction. This position operates primarily at a Division/Group, Strike Team/Task Force level based upon Incident Commanders needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Safety & Security');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'CLEETR','Oklahoma Law Enforcement Officer: Reserve','A reserve officer volunteer or employed with a State, Local or Tribal Jurisdiction. This position operates primarily at a Division/Group, Strike Team/Task Force level based upon Incident Commanders needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Safety & Security');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'CSO','Correctional Security Officer','This position is assigned responsibility related to maintaining the security, control and custody of inmates in a state adult correctional facility. Correctional Security Officers are deemed peace officers and may perform functions as determined necessary by the AHJ. This position operates primarily at a Division/Group, Strike Team/Task Force level based upon Incident Commanders needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Safety & Security');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'LECI','Criminal Investigator','A Law enforcement officer that operates as an investigator conducing criminal investigations from beginning to end. This position operates primarily at a Division/Group, Strike Team/Task Force level based upon Incident Commanders needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Safety & Security');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'LECIT','Crisis Intervention Officer','A Law enforcement officer that operates on a scene to provide expertise in handling situations involving mental health issues. This position operates primarily at a Division/Group, Strike Team/Task Force level based upon Incident Commanders needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Safety & Security');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'LEHDT','Hazardous Devices Technician','A Law Enforcement Officer with special training in explosive devices and their components. They respond to actual and threatened improvised explosive device incidents domestically. This position operates primarily at a Division/Group, Strike Team/Task Force level based upon Incident Commanders needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Safety & Security');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'LEHN','Hostage Negotiator','A Law Enforcement Officer with special training in Crisis Negotiations.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Safety & Security');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'TLEO','Tribal Law Enforcement Officer (Light Horse/Marshal)','A state, local or tribal law enforcement officer having legal jurisdiction to respond on Tribal lands. This includes both Tribal and local officers cross-deputized to mutually respond. This position operates primarily at a Division/Group, Strike Team/Task Force level based upon Incident Commanders needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Public Safety & Security');


INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'CVSM','Certified VOAD Staff Member','A Certified Volunteer Organization Staff Member is an administrative member of a Volunteer Organization or Agency providing coordination and oversight for emergency services being provided to those affected by natural or manmade disasters.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Volunteer');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'DAW','Disaster Assessment Worker','A Disaster Assessment Worker provides emergent assessment for human service needs immediately following a natural or man-made incident.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Volunteer');
INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'VOL','Volunteer Organization Liaison','A Volunteer Organization Liaison provides representation and mediation between the volunteer organization and the Authority Having Jurisdiction.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Volunteer');

INSERT INTO T_EM_REF_QUAL_TYPE (QUAL_CAT_IDX,QUAL_TYPE_CD,QUAL_TYPE_NAME,QUAL_TYPE_DESC,CREATE_USERIDX,CREATE_DT) 
(select QUAL_CAT_IDX,'CHAP','Chaplain','A member of clergy attached to an Oklahoma State, Local, Tribal, or VOAD Emergency Response Organization. This individual may perform religious, crisis intervention, or counseling services for emergency response personnel on an incident. This position operates primarily at a Division/Group, Strike Team/Task Force level based upon Incident Commanders needs.',0,GetDate() from T_EM_REF_QUAL_CATEGORY where QUAL_CAT_NAME='Chaplain/Clergy');





--****************QUAL_TYP_REQ ***********************************************************************************************

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','High School Degree or GED Equivalent',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, IS 701, ICS 100, ICS 200, IS 800, ICS 300, ICS 400',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFA Course H460 All Hazards Finance Administration Section Chief, or NWCG S460 Finance Administration Section Chief, or EMI L973,All Hazards Finance/Admin Section Chief, or State approved equivalent',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','USFA Course O305, All Hazards Incident Management Team or equivalent',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Continuing Education requirements for training as required by AHJ',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Recertification and verification of requisite training Functional experience in Finance / Administration at the level, or levels of government commensurate with the scope of the incident',5,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Functional experience in finance/administration at the level or levels of government commensurate with the scope of the incident',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Successful previous experience within the Time Unit or Cost Unit, or Procurement Unit',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Completion of Position Task Books that validate and verify (by AHJ) demonstrated ability to perform required skills in exercises and/or incidents every 5 years or as dictated by need.',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Certification must be based on a national, state, or local performance-based qualification system that documents the minimum training, skills, knowledge, experience, and physical fitness requirements identified.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Medical and physical fitness requirements established by the AHJ that include the ability to perform duties under moderate to severe stress.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be Affiliated with an Oklahoma; State, Local, or Tribal Jurisdiction',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FSC3');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PREREQ','Either: Planning Section Chief - PSC3 or Operations Section Chief – OSC3',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','High School Degree or GED Equivalent',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, IS 701, ICS 100, ICS 200, IS 800, ICS 300, ICS 400',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFA Course H400, All Hazards Incident Commander, or NWCG S300 Incident Commander, or EMI L950 All Hazards Incident Commander Course, or State Approved Equivalent',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','USFA Course O305, All Hazards Incident Management Team or equivalent',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Continuing Education requirements for training as required by AHJ',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Recertification and verification of requisite training',5,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Management Leadership, and Team building training relevant to emergency response',6,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Functional experience in Incident Command at the level or levels of government commensurate with the scope of the incident',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','NWCG ICT4 or significant ongoing experience related to the management of emergency incidents and events that may involve multiple jurisdictions requiring mutual-aid response.',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Completion of Position Taskbooks that validate and verify (by AHJ) demonstrated ability to perform required skills in exercises and/or incidents every 5 years or as dictated by need.',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Satisfactory performance in other positions within the ICS organizational structure, including Operations Section Chief or Planning Section Chief.',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Certification must be based on a national, state, or local performance-based qualification system that documents the minimum training, skills, knowledge, experience, and physical fitness requirements identified.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Medical and physical fitness requirements established by the AHJ that include the ability to perform duties under moderate to severe stress',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be Affiliated with an Oklahoma; State, Local, or Tribal Jurisdiction',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','When Available, ICT3 should have a working knowledge of the Continuity of Operations (COOP) procedures for the AHJ and adjacent jurisdictions',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','On incidents involving Hazardous Materials: NFPA 472 Professional Competence of Responders to Hazardous Materials (HazMat) incidents (Awareness Level) or Occupational Safety and Health Administration 9OSHA) 1910.120 HazMat Awareness Level training or equivalent basic instruction on responding to and operating in a CBRNE Mass Casualty Incident',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ICT3');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','High School Degree or GED Equivalent',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, IS 701, ICS 100, ICS 200, IS 800, ICS 300, ICS 400',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFA Course H480; All Hazards Liaison Officer, or EMI L956 All hazards Liaison Officer, or State approved Equivalent',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','USFA Course O305, All Hazards Incident Management Team or equivalent',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Continuing Education requirements for training as required by AHJ',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Recertification and verification of requisite training',5,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','All Hazards scenario – specific training on hazards of concern to the AHJ.',6,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Functional experience in interagency coordination at the level or levels of government commensurate with the scope of the incident',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Significant ongoing experience related to coordinating with representatives from various agencies and organizations during emergency situations, as well as experience in emergency management',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Completion of Position Taskbooks that validate and verify (by AHJ) demonstrated ability to perform required skills in exercises and/or incidents every 5 years or as dictated by need.',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Certification must be based on a national, state, or local performance-based qualification system that documents the minimum training, skills, knowledge, experience, and physical fitness requirements identified.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Medical and physical fitness requirements established by the AHJ that include the ability to perform duties under moderate to severe stress.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be Affiliated with an Oklahoma; State, Local, or Tribal Jurisdiction',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LOF3');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','High School Degree or GED Equivalent',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, IS 703, ICS 100, ICS 200, IS 800, ICS 300, ICS 400',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFA Course H450; All Hazards Logistics Section Chief, or State Approved Equivalent',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','USFA Course O305, All Hazards Incident Management Team or equivalent',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Continuing Education requirements for training as required by AHJ',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Training on scenario - specific operations of concern to the jurisdiction and incident',5,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Functional experience in logistics at the level or levels of government commensurate with the scope of the incident',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Successful experience related to facilities, services, and material support, as well as experience in emergency response or incident management.',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Completion of Position Taskbooks that validate and verify (by AHJ) demonstrated ability to perform required skills in exercises and/or incidents every 5 years or as dictated by need.',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Certification must be based on a national, state, or local performance-based qualification system that documents the minimum training, skills, knowledge, experience, and physical fitness requirements identified.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Medical and physical fitness requirements established by the AHJ that include the ability to perform duties under moderate to severe stress.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be Affiliated with an Oklahoma; State, Local, or Tribal Jurisdiction',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','For Incidents involving Hazardous Materials Response, LSC3 must have NFPA 472 HazMat Awareness Level or OSHA 1910 HazMat Awareness Level training or State Approved equivalent basic instruction on CBRNE MCI incidents',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='LSC3');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','High School Degree or GED Equivalent',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='OSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, IS 701, IC 704, ICS 100, ICS 200, IS 800, ICS 300, ICS 400',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='OSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFA Course H430, All Hazards Operations Section Chief, NWCG S430 Operations Section Chief or EMI L958 All Hazards Operations Section Chief, or State approved Equivalent',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='OSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','USFA Course O305, All Hazards Incident Management Team or equivalent',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='OSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Continuing Education requirements for training as required by AHJ',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='OSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','All Hazards Scenario – Specific training of concern to AHJ',5,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='OSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFPA 472 HazMat Awareness Level or OSHA 1910 HazMat Awareness Level training or equivalent basic instruction on CBRNE MCI incidents',6,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='OSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','OSHA 1910.120 and /or 1910.134 Respiratory Protection',7,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='OSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Functional experience in operations at the level, or levels of government commensurate with the scope of the incident',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='OSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Significant ongoing experience in strategy and tactics related to the incident (e.g. wild land fire, water rescue, confined space rescue, or HazMat incident) and experience in emergency response and incident management',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='OSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Successful, previous experience as a Division/Group Supervisor within the Operations Section.',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='OSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Completion of Position Taskbooks that validate and verify (by AHJ) demonstrated ability to perform required skills in exercises and/or incidents every 5 years or as dictated by need.',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='OSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Certification must be based on a national, state, or local performance-based qualification system that documents the minimum training, skills, knowledge, experience, and physical fitness requirements identified.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='OSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='OSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Medical and physical fitness requirements established by the AHJ that include the ability to perform duties under moderate to severe stress.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='OSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be Affiliated with an Oklahoma; State, Local, or Tribal Jurisdiction',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='OSC3');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','High School Degree or GED Equivalent',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, IS 703, ICS 100, ICS 200, IS 800, ICS 300, ICS 400',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFA Course H440 All Hazards Planning Section Chief, or EMI L962 All-Hazards Plannine Section Chief, or State Approved Equivalent',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','USFA Course O305, All Hazards Incident Management Team or equivalent',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Continuing Education requirements for training as required by AHJ',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Functional experience in planning at the level or levels of government commensurate with the scope of the incident',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Significant ongoing experience related to emergency planning and preparedness report writing, and information management.',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Successful, previous experience filing Unit positions within the Planning Section.',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Completion of Position Taskbooks that validate and verify (by AHJ) demonstrated ability to perform required skills in exercises and/or incidents every 5 years or as dictated by need.',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Certification must be based on a national, state, or local performance-based qualification system that documents the minimum training, skills, knowledge, experience, and physical fitness requirements identified.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Medical and physical fitness requirements established by the AHJ that include the ability to perform duties under moderate to severe stress.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSC3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be Affiliated with an Oklahoma; State, Local, or Tribal Jurisdiction',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSC3');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','High School Diploma or GED Equivalent: AHJ May require higher level.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PIO3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, IS 702, ICS 100, ICS 200, IS 800, ICS 300, ICS 400',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PIO3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','EMI Course E388; Advanced Public Information Officers, or NFA course H403; All Hazards Public Information Officer, or NWCG S403 Public Information Officer, or EMI 952 All Hazards Public Information Officer, or State Approved Equivalent',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PIO3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','USFA Course O305, All Hazards Incident Management Team or equivalent',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PIO3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Continuing Education requirements for training as required by AHJ',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PIO3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','All Hazards scenario-specific training of concern to the AHJ',5,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PIO3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Recertification and verification of requisite training',6,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PIO3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Functional experience in media relations at the level or levels of government commensurate with the scope of the incident',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PIO3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Significant ongoing experience managing the generation and dissemination of information related to the incident for the public and the media, as well as experience in emergency management',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PIO3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Successful, previous experience as a Public Information Officer or functional knowledge of print, radio, television, and internet media.',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PIO3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Completion of Position Taskbooks that validate and verify (by AHJ) demonstrated ability to perform required skills in exercises and/or incidents every 5 years or as dictated by need.',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PIO3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Certification must be based on a national, state, or local performance-based qualification system that documents the minimum training, skills, knowledge, experience, and physical fitness requirements identified.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PIO3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PIO3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Medical and physical fitness requirements established by the AHJ that include the ability to perform duties under moderate to severe stress',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PIO3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be Affiliated with an Oklahoma; State, Local, or Tribal Jurisdiction',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PIO3');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','High School Diploma or GED Equivalent',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, ICS 100, ICS 200, IS 800, ICS 300, ICS 400',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFA course H404; All Hazards Safety Officer, NWCG S404 Safety Officer, or State Approved Equivalent',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','USFA Course O305, All Hazards Incident Management Team or equivalent',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Continuing Education requirements for training as required by AHJ',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','All Hazards scenario-specific training on incidents of concern to the AHJ',5,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Recertification and verification of requisite training',6,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','OSHA 1910.120 and/or OSHA 1910.134, Respiratory Protection',7,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Functional experience in safety at the level or levels of government commensurate with the scope of the incident',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Significant ongoing safety experience in strategy and tactics related to the incident (e.g. wildland fire, or HazMat Incident) and experience in emergency management.',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Successful, previous experience filling positions within the Operations Section',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Completion of Position Taskbooks that validate and verify (by AHJ) demonstrated ability to perform required skills in exercises and/or incidents every 5 years or as dictated by need.',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Certification must be based on a national, state, or local performance-based qualification system that documents the minimum training, skills, knowledge, experience, and physical fitness requirements identified.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Medical and physical fitness requirements established by the AHJ that include the ability to perform duties under moderate to severe stress',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be Affiliated with an Oklahoma; State, Local, or Tribal Jurisdiction',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SOF3');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','For incidents involving Hazardous Environments, SOF3 must have NFPA 472 HazMat Operations Level training or OSHA 1910.120 HazMat Operations Level Training, or equivalent basic instruction on responding to and operating in a CBRNE MCI',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SOF3');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','High School Diploma or GED Equivalent',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='DIVS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, ICS 100, ICS 200, IS 800, ICS 300',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='DIVS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFA E960 / EMI L960 Division/Group Supervisor Course, and/or NWCG S339 Division/Group Supervisor course, or State approved Equivalent',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='DIVS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Satisfactory performance as a task force leader.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='DIVS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Completion of Position Taskbooks that validate and verify (by AHJ) demonstrated ability to perform required skills in exercises and/or incidents every 5 years or as dictated by need.',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='DIVS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Certification must be based on a national, state, or local performance-based qualification system that documents the minimum training, skills, knowledge, experience, and physical fitness requirements identified.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='DIVS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='DIVS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Medical and physical fitness requirements established by the AHJ that include the ability to perform duties under moderate to severe stress',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='DIVS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be Affiliated with an Oklahoma; State, Local, or Tribal Jurisdiction',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='DIVS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Additional training to support qualification: NFPA 472 HazMat Operations Level training or OSHA 1910.120 HazMat Operations Level Training, or equivalent basic instruction on responding to and operating in a CBRNE MCI for incidents involving Hazardous Materials response',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='DIVS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Additional Training to support qualifications: OSHA 1910.120 and/or OSHA 1910.134, Respiratory Protection for incidents involving Hazardous Materials response',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='DIVS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Additional Training to support qualifications: S390 Fire Behavior Calculations when responding to wildland fire incident.',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='DIVS');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','Determined by the AHJ',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='TFLD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, ICS 100, ICS 200, IS 800, ICS 300',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='TFLD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFPA 1051 Wildland Fire Officer 2, or NFA course E984 or EMI L984 Task Force/Strike Team Leader, and/or NWCG S-330 /G330 Task Force/Strike Team Leader, or State Equivalent',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='TFLD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','All Hazards scenario-specific operational training and Exercises',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='TFLD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Recertification and verification of requisite training as determined by AHJ',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='TFLD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','unctional supervisory experience at the single resource level. (ie.. Fire Officer Company/Unit, Wildland Fire Officer 1, NWCG Engine Boss, Law Enforcement Supervisor, Public Works Supervisor, Supervisory EMS provider)',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='TFLD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Completion of Position Taskbooks that validate and verify (by AHJ) demonstrated ability to perform required skills in exercises and/or incidents every 5 years or as dictated by need.',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='TFLD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Certification must be based on a national, state, or local performance-based qualification system that documents the minimum training, skills, knowledge, experience, and physical fitness requirements identified.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='TFLD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='TFLD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Medical and physical fitness requirements established by the AHJ that include the ability to perform duties under moderate to severe stress',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='TFLD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be Affiliated with an Oklahoma; State, Local, or Tribal Jurisdiction',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='TFLD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Additional training to support qualification: NFPA 472 HazMat Operations Level training or OSHA 1910.120 HazMat Operations Level Training, or equivalent basic instruction on responding to and operating in a CBRNE MCI for incidents involving Hazardous Materials response',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='TFLD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Additional Training to support qualifications: OSHA 1910.120 and/or OSHA 1910.134, Respiratory Protection for incidents involving Hazardous Materials response',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='TFLD');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','Bachelors of Science in Engineering',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CFE');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, ICS 100, ICS 200',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CFE');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Reporting requirements of Technological capabilities and operational theory requirements in a recovery environment',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CFE');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Mission-specific Training , As required by the AHJ',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CFE');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Minimum Five Years relevant civil engineering experience',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CFE');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','OSHA 1910.120 Hazardous Waste Operations and Emergency Response OSHA 1910 Hazard Communications',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CFE');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','The AHJ also determines recertification requirements, if any',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CFE');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CFE');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Professional Engineer (PE) as required by the State of Oklahoma',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CFE');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Physical capability to work long hours in adverse environmental and potentially extreme temperature and weather conditions',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CFE');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','High School Degree or Equivalent',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CSWM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS Training: ICS-100 PW, ICS 200 Basic ICS, FEMA IS-700, ICS 300, IS 800',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CSWM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Reporting requirements of Technological capabilities and operational theory requirements in a recovery environment',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CSWM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Mission-specific Training , As required by the AHJ',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CSWM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','FEMA IS – 556: Preliminary Damage Assessment for Public Works',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CSWM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Minimum of 5 years management experience in the field of enforcement of environmental storm water quality regulations',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CSWM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','In depth understanding of the principals of planning and response to emergencies',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CSWM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Experience of responding to emergency spills and clean-up',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CSWM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','OSHA 1910.120 (Hazardous Waste Operations and Emergency Response)',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CSWM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','OSHA 1910: Hazard Communications.',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CSWM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Certified Flood Plain Manager (CFM)',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CSWM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CSWM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Physical capability to work long hours in adverse environmental and potentially extreme temperature and weather conditions',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='CSWM');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, ICS 100pw, ICS 200',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='HEO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','OSHA 1910.134 Respiratory protection compliance',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='HEO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Mission-specific Training , As required by the AHJ',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='HEO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','One year related equipment operations in a Hazardous environm',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='HEO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Demonstrated experience or local certification on equipment being operated',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='HEO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','National Center for Construction Education and Research NCCER : Safe equipment operation',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='HEO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','OSHA 1910 Hazard Communication',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='HEO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Commercial Driver''s License (CDL) as required by the State of Oklahoma',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='HEO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Physical capability to work long hours in adverse environmental and potentially extreme temperature and weather conditions',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='HEO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be affiliated with a State, Local, or Tribal Jurisdiction',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='HEO');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','Determined by the AHJ',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS Training: ICS-100 PW, ICS 200 Basic ICS, ICS-300, ICS-400, FEMA IS-700, IS 800',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Reporting requirements of Technological capabilities and operational theory requirements in a recovery environment',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Mission-specific Training , As required by the AHJ',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','FEMA IS 556 Preliminary Damage Assessment for Public Works',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Minimum 10 Years Leadership and management experience in the field of public works',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','In-depth understanding of the principles of planning and response to emergencies',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Past involvement in policy formulation activities with community regional, or state level officials.',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Previous participation in Presidentially declared disaster',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Annual participation in community based emergency management exercises.',5,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','OSHA 1910.120 (Hazardous Waste Operations and Emergency Response)',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','OSHA 1910 Hazard Communication',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Physical capability to work long hours in adverse environmental and potentially extreme temperature and weather conditions',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be affiliated with a State, Local, or Tribal Jurisdiction',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWD');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','Bachelor of Science in Occupational Health and Safety or related field.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWSO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS Training: ICS-100 PW, ICS 200 Basic ICS, ICS-300, ICS-400, FEMA IS-700, IS 800 IC',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWSO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Reporting requirements of Technological capabilities and operational theory requirements in a recovery environment',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWSO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','OSHA 1910 Hazardous Communications',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWSO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','IS 00035.11 FEMA Safety Orientation',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWSO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','FEMA IS 556 Preliminary Damage Assessment for Public Works',5,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWSO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Minimum 3 years management experience in field of safety',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWSO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Experience and knowledge of state and federal governmental safety laws and regulations.',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWSO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Experience monitoring analyzing and making recommendations relative to governmental safety laws and regulations',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWSO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Ability to interact, advise, perform training and communicate effectively, including reading and writing English.',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWSO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Experience in use and function of tools and equipment applicable to positions including computers and applicable software',5,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWSO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','OSHA 1910.120 (Hazardous Waste Operations and Emergency Response)',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWSO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','OSHA 1910 Hazard Communications',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWSO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWSO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Physical capability to work long hours in adverse environmental and potentially extreme temperature and weather conditions',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWSO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be affiliated with a State, Local, or Tribal Jurisdiction',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PWSO');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','Bachelor of Science in Civil Engineering or Architecture with a Specialized Structural emphasis',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SE');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS Training: ICS-100 PW, ICS 200 Basic ICS, FEMA IS-700',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SE');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Reporting requirements of Technological capabilities and operational theory requirements in a recovery environment',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SE');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Mission-specific Training , As required by the AHJ',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SE');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Minimum Five Years relevant experience',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SE');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Professional Engineer (PE) as required by the State of Oklahoma',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SE');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SE');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Physical capability to work long hours in adverse environmental and potentially extreme temperature and weather conditions',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SE');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be affiliated with a State, Local, or Tribal Jurisdiction',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='SE');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','High School Degree or GED Equivalent (AHJ may require Higher Level)',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COML');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, IS 704, ICS 100, ICS 200, IS 800, ICS 300',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COML');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','US DHS: All Hazards COML course (Type III), or OKOHS/COML Committee Approved Equivalent',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COML');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Continuing Education requirements for training as required by AHJ',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COML');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Recertification and verification of requisite training as determined by the AHJ',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COML');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Functional experience in local communications and communications systems',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COML');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Significant ongoing experience related to coordinating with representatives from various agencies and organizations during emergency situations, as well as experience in frequency spectrums, communication plans, topography and system site location',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COML');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Completion of Position Taskbook (OKOHS COML) that validate and verify (by AHJ) demonstrated ability to perform required skills in exercises and/or incidents. Experience may be within 3 years of completion of taskbook.',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COML');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Fundamental public safety communications technology, supervisory and personnel management skills including knowledge personnel documentation, safety and risk management, and teamwork',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COML');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','FEMA/OKOHS Certified COML: A performance based certification and qualification system to document minimum training, skills and knowledge, experience, and fitness requirements for COML.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COML');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COML');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Medical and physical fitness requirements established by the AHJ that include the ability to perform duties under moderate stress by working under physical and emotional stress for sustained periods.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COML');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be Affiliated with a State, Local, or Tribal Emergency Response Jurisdiction.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COML');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Additional information about COML requirements may be found in the Certified State of Oklahoma Communications Unit Leader/Communications Unit Technician Recognition Procedures handbook.',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COML');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','High School Degree or GED Equivalent (AHJ may require Higher Level)',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COMT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, IS 704, ICS 100, ICS 200, IS 800, ICS 300',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COMT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','US DHS Approved: All Hazards COMT course or OKOHS/COML Committee Approved Equivalent',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COMT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Continuing Education requirements for training as required by AHJ',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COMT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Recertification and verification of requisite training as determined by the AHJ',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COMT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Basic knowledge of local communications and communications systems, frequencies and spectrum, technologies, local topography, systems site locations including knowledge of local, regional and state communications plans and resource contacts.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COMT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Fundamental public safety communications technology awareness',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COMT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Completion of Position Taskbook (OKOHS COMT) that validate and verify (by AHJ) demonstrated ability to perform required skills in exercises and/or incidents. (Experience may be within 3 years of completion of taskbook)',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COMT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','FEMA/OKOHS Certified COMT: A performance based certification and qualification system to document minimum training, skills and knowledge, experience, and fitness requirements for COMT.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COMT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COMT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Medical and physical fitness requirements established by the AHJ that include the ability to perform duties under moderate stress by working under physical and emotional stress for sustained periods.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COMT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be Affiliated with a State, Local, or Tribal Emergency Response Jurisdiction.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COMT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Additional information about COMT requirements may be found in the Certified State of Oklahoma Communications Unit Leader/Communications Unit Technician Recognition Procedures handbook.',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='COMT');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','High School Diploma or GED Equivalent',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EART');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS IS 700, ICS 100, ICS 200, ICS 800, IS 704',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EART');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Mission-specific Training , as required by the AHJ',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EART');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Training commensurate with FCC Amateur Radio Technician level course work',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EART');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Minimum one year relevant Field Disaster experience',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EART');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Minimum Technician Level Amateur Radio License (FCC)',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EART');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EART');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Physical capability to work long hours in adverse environmental and potentially extreme temperature and weather conditions',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EART');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Requires a criminal background records check/OSBI if not a member of a State, Local, or Tribal Jurisdiction.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EART');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Individual must be sponsored by a recognized State, Local, or Tribal emergency services entity.',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EART');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','High School Degree or GED Equivalent (AHJ may require Higher Level)',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSTD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, IS 704, ICS 100, ICS 200',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSTD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFPA 1061 or Association of Public Safety Communications Officials (APCO) equivalent',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSTD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Completion of the following baseline criteria: Public Safety Telecommunicator Course or Equivalent, Receiving Information, processing Information , Disseminating Information',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSTD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Additional and Continuing Education requirements for dispatcher training as required by AHJ',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSTD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Functional experience in local communications and communications systems',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSTD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Functional experience with keyboarding, data entry, and basic mathematical calculations.',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSTD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Uses plain English and common terminology as a public safety communication standard.',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSTD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','NFPA 1061 or APCO Equivalent',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSTD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSTD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Medical and physical fitness requirements established by the AHJ that include the ability to perform duties under moderate stress by working under physical and emotional stress for sustained periods.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSTD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be Affiliated with a State, Local, or Tribal Jurisdiction or Certified Fire Department',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='PSTD');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','High School Diploma or GED Equivalent',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, IS 701, IS 703, ICS 100, ICS 200, IS 800, ICS 300',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Completion of Emergency Management Baseline Training: Scope, Roles and Responsibilities, Mitigation, Preparedness, Response, Recovery, Program Management to include the following FEMA courses within 1 year of appointment: IC 120, IS230, IS 235, IS 393, IS 634, IS 775',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Any additional/Specific training as determined by the AHJ',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','EOC / ICS interface Course',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Must be able to develop local Emergency Operations Plans (EOPs)',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Must have ongoing Emergency Response and/or Management Experience',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Jurisdictional Appointment as Emergency Mgt. Director and OEM Recognition.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Recommended: OK First Certification',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','The AHJ determines additional certification and recertification requirements, if any',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Able to perform under conditions of moderate to severe stress',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAD');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be Affiliated with a State, Local, or Tribal Emergency Agency/ Organization',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAD');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','High School Diploma or GED Equivalent',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, ICS 100, ICS 200, IS 800',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Completion of Emergency Management Baseline Training: Scope, Roles and Responsibilities, Mitigation, Preparedness, Response, Recovery',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Any additional/Specific training as determined by the AHJ',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Preferred: EOC / ICS interface Course',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Must have ongoing Emergency Response and/or Management Experience',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Local Jurisdictional may require Appointment as Emergency Management Staff',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Recommended: OK First Certification',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','The AHJ determines additional certification and recertification requirements, if any',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Able to perform under conditions of moderate to severe stress',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAS');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be Affiliated with a State, Local, or Tribal Emergency Agency/ Organization',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAS');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS FEMA; IS 700, ICS 100, ICS 200',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAV');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Any additional/Specific training as determined by the AHJ',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAV');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','May require Jurisdictional Appointment',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAV');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Recommended: OK First Certification',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAV');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','The AHJ determines additional certification and recertification requirements, if any',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAV');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAV');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Able to perform under conditions of moderate to severe stress',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAV');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be Affiliated with a State, Local, or Tribal Emergency Agency/ Organization',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EMAV');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','State, Local or Tribal Jurisdiction Identifies Minimum Education Requirements',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ARFF');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS IS 700, ICS 100, ICS 200',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ARFF');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFPA 1003',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ARFF');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Required: NFPA 472 or OSHA 1910.120 HazMat Awareness Training or Equivalent CBRNE Training. Preferred: NFPA 472 or OSHA 1910.120 HazMat Operations Training.',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ARFF');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Completion of the following baseline criteria: ARFF or Airport Firefighter, Response to Airport Emergencies, Fire Suppression Rescue',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ARFF');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Emergency Medical Responder (First Responder) including AED',5,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ARFF');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Any additional or mission-specific training determined by the AHJ',6,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ARFF');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Ongoing experience in Airport Crash Rescue as determined by AHJ',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ARFF');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','AHJ determines certification requirements pursuant to NFPA 1003',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ARFF');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','AHJ determines certification requirements pursuant to NFPA 472',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ARFF');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Recertification requirements are determined by the AHJ',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ARFF');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ARFF');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','NFPA 1582: Medical Baseline, Fitness Status, Annual Medical',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ARFF');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be affiliated with a state, local or tribal jurisdiction or Certified Fire Department',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='ARFF');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','State, Local or Tribal Jurisdiction Identifies Minimum Education Requirements',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EVT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS: IS 700, ICS 100',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EVT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFPA 1071 Emergency Vehicle Technician',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EVT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Completion of the following baseline training criteria: Chassis, Cab and Body Components, Electronics and Electrical systems, Auxiliary Drive Systems, Pump and Tank Systems, Aerial Systems, Specialized Systems.',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EVT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Any additional or mission-specific training determined by the AHJ',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EVT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Two years relevant experience as determined by AHJ',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EVT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','AHJ determines certification requirements pursuant to NFPA 1071',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EVT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Discipline appropriate components of the IAFC/ASE: Certified Emergency Vehicle Technician (EVT) as determined by the AHJ',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EVT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Recertification requirements are determined by the AHJ',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EVT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EVT');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Physical capability to work long hours in adverse environmental and potentially extreme temperature and weather conditions',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='EVT');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','State, Local or Tribal Jurisdiction Identifies Minimum Education Requirements',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FADO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS Training: IS 700, ICS 100, ICS 200',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FADO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFPA 1002',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FADO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Complete Baseline Criteria: Preventive Maintenance, Driving Operating Apparatus',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FADO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Any additional or mission-specific training determined by the AHJ',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FADO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Ongoing experience relevant to apparatus driving and operating as determined by the AHJ',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FADO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','AHJ determines certification requirements pursuant to NFPA 1002',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FADO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','Any Additional Operator Certification as Determined by the AHJ - The AHJ also determines recertification requirements, if any',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FADO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FADO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','AHJ determines minimum medical and physical criteria including ability to work long hours in adverse environmental and potentially extreme temperature and weather conditions.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FADO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be affiliated with a state, local or tribal jurisdiction or Certified Fire Department.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FADO');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','State, Local or Tribal Jurisdiction Identifies Minimum Education Requirements',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS Training: IS 700, ICS 100, ICS 200',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFPA 1001 Firefighter 1',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Complete following baseline criteria: Hazard Mitigation, Personal Protective Equipment (PPE), Use of Fire related Tools and Devices, Fire Behavior, Risk Assessment.',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Required: NFPA 472 or OSHA 1910.120 HazMat Awareness Training or Equivalent CBRNE Training. Preferred: NFPA 472 or OSHA 1910.120 HazMat Operations Training.',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Use of Self Contained Breathing Apparatus (SCBA) OSHA 1910.120 and or 1910.134 Respiratory Protection',5,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Any Additional/Specific Apparatus training as determined by the AHJ',6,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Ongoing firefighting experience as determined by the AHJ',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','AHJ determines certification pursuant to NFPA 1001',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','AHJ determines certification pursuant to NFPA 472',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','The AHJ also determines recertification requirements, if any',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Minimum Criteria: AHJ determines minimum medical and physical criteria including ability to work in adverse environmental and potentially extreme temperature and weather conditions.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be affiliated with a state, local or tribal jurisdiction or Certified Fire Department.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF1');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','State, Local or Tribal Jurisdiction Identifies Minimum Education Requirements',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS Training: IS 700, ICS 100, ICS 200',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFPA 1001 Firefighter II',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Complete following baseline criteria: Hazard Mitigation, Personal Protective Equipment (PPE), Use of Fire related Tools and Devices, Fire Behavior, Risk Assessment.',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Required: NFPA 472 or OSHA 1910.120 HazMat Awareness Training or Equivalent CBRNE Training. Preferred: NFPA 472 or OSHA 1910.120 HazMat Operations Training.',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Use of Self Contained Breathing Apparatus (SCBA) OSHA 1910.120 and or 1910.134 Respiratory Protection',5,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Any Additional/Specific Apparatus training as determined by the AHJ',6,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Ongoing firefighting experience as determined by the AHJ',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','AHJ determines certification pursuant to NFPA 1001',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','AHJ determines certification pursuant to NFPA 472',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','The AHJ also determines recertification requirements, if any',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Minimum Criteria: AHJ determines minimum medical and physical criteria including ability to work in adverse environmental and potentially extreme temperature and weather conditions.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be affiliated with a state, local or tribal jurisdiction or Certified Fire Department.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FF2');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PREREQ','Emergency Medical Responder (First Responder with AED)-EMR',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','State, Local or Tribal Jurisdiction Identifies Minimum Education Requirements',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS T: IS-700, ICS-100, ICS-200',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFPA 1031: Fire Inspector I or state-approved equivalent',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Complete following baseline criteria: Administration and Field Inspection',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Required: NFPA 472 or OSHA 1910.120 HazMat Awareness Training or Equivalent CBRNE Training. Preferred: NFPA 472 or OSHA 1910.120 HazMat Operations Training.',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Any additional/specific training as determined by the AHJ',5,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Ongoing relevant firefighting inspection experience as determined by the AHJ',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','AHJ determines certification pursuant to NFPA 1031',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','AHJ determines certification pursuant to NFPA 472',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','The AHJ also determines recertification requirements, if any',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Minimum Physical and Medical requirements established by the AHJ',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS1');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be affiliated with a state, local or tribal jurisdiction or Certified Fire Department.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS1');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PREREQ','Emergency Medical Responder (First Responder with AED)-EMR',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','State, Local or Tribal Jurisdiction Identifies Minimum Education Requirements',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS: IS-700, ICS-100, ICS-200',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFPA 1031: Fire Inspector II or state-approved equivalent',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Complete following baseline criteria: Administration, Field Inspection, and Plans Review',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Required: NFPA 472 or OSHA 1910.120 HazMat Awareness Training or Equivalent CBRNE Training. Preferred: NFPA 472 or OSHA 1910.120 HazMat Operations Training.',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Any additional/specific training as determined by the AHJ',5,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Ongoing relevant Fire Inspector 2 experience as determined by the AHJ',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','AHJ determines certification pursuant to NFPA 1031',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','AHJ determines certification pursuant to NFPA 472',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','The AHJ also determines recertification requirements, if any',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Minimum Physical and Medical requirements established by the AHJ',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS2');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be affiliated with a state, local or tribal jurisdiction or Certified Fire Department.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FINS2');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PREREQ','Emergency Medical Responder (First Responder with AED)-EMR',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PREREQ','Firefighter 2-FF2',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PREREQ','Additional Prerequisite Qualifications as determined by the AHJ',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','State, Local or Tribal Jurisdiction Identifies Minimum Education Requirements',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS: IS-700, ICS-100, ICS-200, ICS-300, IS-800',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFPA 1021-Fire Officer I, Fire Officer II or state-approved equivalent.',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Completion of the following baseline criteria: Human Resource Management, Community and Government Relations, Administration, Emergency Service Delivery, Health and Safety',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Required: NFPA 472 or OSHA 1910.120 HazMat Awareness Training or Equivalent CBRNE Training. Preferred: NFPA 472 or OSHA 1910.120 HazMat Operations Training.',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Any additional/specific training as determined by the AHJ',5,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Ongoing relevant Fire Officer (Supervisory) experience as determined by the AHJ',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','AHJ determines certification pursuant to NFPA 1021',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','AHJ determines certification pursuant to NFPA 1041',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','The AHJ also determines recertification requirements, if any',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Minimum Criteria: AHJ determines minimum medical and physical required criteria including ability to work in adverse environmental and potentially extreme temperature and weather conditions',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCO');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be affiliated with a state, local or tribal jurisdiction or Certified Fire Department.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCO');

INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PREREQ','Emergency Medical Responder (First Responder with AED)-EMR',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PREREQ','Firefighter 2-FF2',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PREREQ','Additional Prerequisite Qualifications as determined by the AHJ',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EDU','State, Local or Tribal Jurisdiction Identifies Minimum Education Requirements',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NIMS: IS-700, ICS-100, ICS-200, IS-800, ICS-300, ICS-400',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','NFPA 1021-Fire Officer III and Fire Officer IV',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Completion of the following baseline criteria: Human Resource Management, Community and Government Relations, Administration, Emergency Service Delivery, Health and Safety',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Required: NFPA 472 or OSHA 1910.120 HazMat Awareness Training or Equivalent CBRNE Training. Preferred: NFPA 472 or OSHA 1910.120 HazMat Operations Training.',4,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'TRAIN','Any additional/specific training as determined by the AHJ',5,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'EXP','Ongoing relevant Fire Officer (Command) experience as determined by the AHJ',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','AHJ determines certification pursuant to NFPA 1021',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','AHJ determines certification pursuant to NFPA 1041',2,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'CERT','The AHJ also determines recertification requirements, if any',3,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'LIC','Valid Oklahoma State Driver’s License',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'PHYS','Minimum Criteria: AHJ determines minimum medical and physical required criteria including ability to work in adverse environmental and potentially extreme temperature and weather conditions',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCM');
INSERT INTO T_EM_REF_QUAL_TYPE_REQ (QUAL_TYPE_IDX, QUAL_TYPE_REQ_TYPE,QUAL_TYPE_REQ_DESC,SORT_NUM,CREATE_USERIDX,CREATE_DT)
(select QUAL_TYPE_IDX, 'MISC','Must be affiliated with a state, local or tribal jurisdiction or Certified Fire Department.',1,0,GetDate() from T_EM_REF_QUAL_TYPE where QUAL_TYPE_CD='FOCM');




--****************RESOURCE TYPES ***********************************************************************************************
INSERT INTO T_EM_REF_RESOURCE_CAT (RESOURCE_CAT_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Animals and Agricultural Issues',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_CAT (RESOURCE_CAT_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Communications',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_CAT (RESOURCE_CAT_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Firefighting',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_CAT (RESOURCE_CAT_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Food and Water',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_CAT (RESOURCE_CAT_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Hazardous Materials Response',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_CAT (RESOURCE_CAT_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Health and Medical',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_CAT (RESOURCE_CAT_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Information and Planning',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_CAT (RESOURCE_CAT_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Law Enforcement and Security',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_CAT (RESOURCE_CAT_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Mass Care',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_CAT (RESOURCE_CAT_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Public Works and Engineering',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_CAT (RESOURCE_CAT_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Resource Management',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_CAT (RESOURCE_CAT_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Search and Rescue',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_CAT (RESOURCE_CAT_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Transportation',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_CAT (RESOURCE_CAT_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Volunteers and Donations',0,GetDate());

--****************RESOURCE KINDS ***********************************************************************************************
INSERT INTO T_EM_REF_RESOURCE_KIND (RESOURCE_KIND_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Aircraft',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_KIND (RESOURCE_KIND_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Equipment',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_KIND (RESOURCE_KIND_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Personnel',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_KIND (RESOURCE_KIND_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Team',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_KIND (RESOURCE_KIND_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Unit',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_KIND (RESOURCE_KIND_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Vehicles',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_KIND (RESOURCE_KIND_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Other',0,GetDate());

--****************RESOURCE DISCIPLINES***********************************************************************************************
INSERT INTO T_EM_REF_RESOURCE_DISCIPLINE (RESOURCE_DISC_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Animal Emergency Response',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_DISCIPLINE (RESOURCE_DISC_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Emergency Medical Services',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_DISCIPLINE (RESOURCE_DISC_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Fire and HazMat',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_DISCIPLINE (RESOURCE_DISC_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Incident Management',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_DISCIPLINE (RESOURCE_DISC_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Law Enforcement',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_DISCIPLINE (RESOURCE_DISC_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Mass Care',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_DISCIPLINE (RESOURCE_DISC_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Medical and Public Health',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_DISCIPLINE (RESOURCE_DISC_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Public Works',0,GetDate());
INSERT INTO T_EM_REF_RESOURCE_DISCIPLINE (RESOURCE_DISC_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Search and Rescue',0,GetDate());

--****************RESOURCE CORE CAPACITIES ***********************************************************************************************
INSERT INTO T_EM_REF_RESOURCE_CORE_CAP (RESOURCE_CORE_CAP_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Access Control and Identity Verification',0, GetDate());
INSERT INTO T_EM_REF_RESOURCE_CORE_CAP (RESOURCE_CORE_CAP_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Critical Transportation',0, GetDate());
INSERT INTO T_EM_REF_RESOURCE_CORE_CAP (RESOURCE_CORE_CAP_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Environmental Response/Health and Safety',0, GetDate());
INSERT INTO T_EM_REF_RESOURCE_CORE_CAP (RESOURCE_CORE_CAP_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Housing',0, GetDate());
INSERT INTO T_EM_REF_RESOURCE_CORE_CAP (RESOURCE_CORE_CAP_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Infrastructure Systems',0, GetDate());
INSERT INTO T_EM_REF_RESOURCE_CORE_CAP (RESOURCE_CORE_CAP_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Interdiction and Disruption',0, GetDate());
INSERT INTO T_EM_REF_RESOURCE_CORE_CAP (RESOURCE_CORE_CAP_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Mass Care Services',0, GetDate());
INSERT INTO T_EM_REF_RESOURCE_CORE_CAP (RESOURCE_CORE_CAP_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Mass Search and Rescue Operations',0, GetDate());
INSERT INTO T_EM_REF_RESOURCE_CORE_CAP (RESOURCE_CORE_CAP_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Operational Communications',0, GetDate());
INSERT INTO T_EM_REF_RESOURCE_CORE_CAP (RESOURCE_CORE_CAP_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Operational Coordination',0, GetDate());
INSERT INTO T_EM_REF_RESOURCE_CORE_CAP (RESOURCE_CORE_CAP_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('On-scene Security and Protection',0, GetDate());
INSERT INTO T_EM_REF_RESOURCE_CORE_CAP (RESOURCE_CORE_CAP_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Planning',0, GetDate());
INSERT INTO T_EM_REF_RESOURCE_CORE_CAP (RESOURCE_CORE_CAP_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Public and Private Services and Resources',0, GetDate());
INSERT INTO T_EM_REF_RESOURCE_CORE_CAP (RESOURCE_CORE_CAP_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Public Health and Medical Services',0, GetDate());
INSERT INTO T_EM_REF_RESOURCE_CORE_CAP (RESOURCE_CORE_CAP_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Public Information and Warning',0, GetDate());
INSERT INTO T_EM_REF_RESOURCE_CORE_CAP (RESOURCE_CORE_CAP_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Screening, Search, and Detection',0, GetDate());
INSERT INTO T_EM_REF_RESOURCE_CORE_CAP (RESOURCE_CORE_CAP_DESC,CREATE_USERIDX,CREATE_DT) VALUES ('Situational Assessment',0, GetDate());



GO

