/***************************************************************** */
/*************DROP EXISTING DATABASE (only use if refreshing DB*** */
/***************************************************************** */
/*
	  EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'EMERG_DB'
	  GO
	  USE [master]
	  GO
	  ALTER DATABASE [EMERG_DB] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
	  GO
	  USE [master]
	  GO
	  DROP DATABASE [EMERG_DB]
	  GO
*/

/************************************************************ */
/*************CREATE DATABASE******************************** */
/************************************************************ */
CREATE DATABASE [EMERG_DB]
GO

/************************************************************************* */
/*************CREATE USER AND GRANT RIGHTS******************************** */
/************************************************************************* */
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = N'emerg_login')
DROP LOGIN [emerg_login]


use [EMERG_DB]
Create login emerg_login with password='F$GHWjpN!18g';
EXEC sp_defaultdb @loginame='emerg_login', @defdb='EMERG_DB' 
Create user [emerg_user] for login [emerg_login]; 
exec sp_addrolemember 'db_owner', 'emerg_user'; 


/************************************************************ */
/*************CREATE TABLES  ******************************** */
/************************************************************ */
Use [EMERG_DB] 

CREATE TABLE [dbo].[T_OE_APP_SETTINGS](
	[SETTING_IDX] [int] IDENTITY(1,1) NOT NULL,
	[SETTING_NAME] [varchar](100) NOT NULL,
	[SETTING_VALUE] [varchar](200) NULL,
	[ENCRYPT_IND] [bit] NULL,
	[SETTING_VALUE_SALT] [varchar](100) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_OE_APP_SETTINGS] PRIMARY KEY CLUSTERED ([SETTING_IDX] ASC)
) ON [PRIMARY]

GO
 

CREATE TABLE [dbo].[T_OE_ORGANIZATIONS](
	[ORG_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[ORG_NAME] [varchar](100) NOT NULL,
	[ORG_DESC] [varchar](200) NULL,
	[ALLOW_JOIN_IND] [bit] NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_OE_ORGANIZATIONS] PRIMARY KEY CLUSTERED  ([ORG_IDX] ASC)
) ON [PRIMARY]

GO	 



CREATE TABLE [dbo].[T_OE_USERS](
	[USER_IDX] [int] IDENTITY(0,1) NOT NULL,
	[USER_ID] [varchar](150) NOT NULL,
	[PWD_HASH] [varchar](100) NOT NULL,
	[PWD_SALT] [varchar](100) NOT NULL,
	[FNAME] [varchar](40) NOT NULL,
	[LNAME] [varchar](40) NOT NULL,
	[EMAIL] [varchar](150) NULL,
	[INITAL_PWD_FLAG] [bit] NOT NULL,
	[EFFECTIVE_DT] [datetime2](0) NOT NULL,
	[LASTLOGIN_DT] [datetime2](0) NULL,
	[PHONE] [varchar](12) NULL,
	[PHONE_EXT] [varchar](4) NULL,
	[USER_AVATAR] [varbinary](max) NULL,
	[LOG_ATMPT] [int] NULL,
	[CURR_INCIDENT_IDX] [uniqueidentifier] NULL,
	[SECURITY_STAMP] [varchar](100) NULL,
	[LOCKOUT_END_DATE_UTC] [datetime2] NULL,
	[LOCKOUT_ENABLED] [bit] NOT NULL DEFAULT 0,
	[TRACK_IND] [bit] NOT NULL DEFAULT 1,
	[ACT_IND] [bit] NOT NULL,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_OE_USERS] PRIMARY KEY CLUSTERED ( [USER_IDX] ASC)
) ON [PRIMARY]

--ALTER TABLE [T_OE_USERS] ADD [TRACK_IND] [bit] NOT NULL DEFAULT 1;

GO


CREATE TABLE [dbo].[T_OE_ROLES](
	[ROLE_IDX] [int] IDENTITY(1,1) NOT NULL,
	[ROLE_NAME] [varchar](25) NOT NULL,
	[ROLE_DESC] [varchar](100) NOT NULL,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_OE_ROLES] PRIMARY KEY CLUSTERED  ([ROLE_IDX] ASC)
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[T_OE_USER_ROLES](
	[USER_ROLE_IDX] [int] IDENTITY(1,1) NOT NULL,
	[USER_IDX] [int] NOT NULL,
	[ROLE_IDX] [int] NOT NULL,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_OE_USER_ROLES] PRIMARY KEY CLUSTERED ([USER_ROLE_IDX] ASC),
 CONSTRAINT [UK_T_OE_USER_ROLES] UNIQUE NONCLUSTERED (	[USER_IDX] ASC,	[ROLE_IDX] ASC),
 FOREIGN KEY (ROLE_IDX) references T_OE_ROLES (ROLE_IDX) 
	ON UPDATE CASCADE 
	ON DELETE CASCADE, 
 FOREIGN KEY (USER_IDX) references T_OE_USERS (USER_IDX)
 	ON UPDATE CASCADE 
	ON DELETE CASCADE
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[T_OE_USER_TOKENS](
	[USER_IDX] [int] NOT NULL,
	[USER_TOKEN_IDX] [uniqueidentifier] NOT NULL,
	[CREATE_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_OE_USER_TOKENS] PRIMARY KEY CLUSTERED ([USER_IDX], [USER_TOKEN_IDX]),
 FOREIGN KEY (USER_IDX) references T_OE_USERS (USER_IDX)
 	ON UPDATE CASCADE 
	ON DELETE CASCADE
) ON [PRIMARY]


GO

CREATE TABLE [dbo].[T_OE_SYS_LOG](
	[SYS_LOG_ID] [int] IDENTITY(1,1) NOT NULL,
	[LOG_DT] [datetime2](0) NOT NULL,
	[LOG_USERIDX] [int] NULL,
	[LOG_TYPE] [varchar](15) NULL,
	[LOG_MSG] [varchar](2000) NULL,
 CONSTRAINT [PK_T_OE_SYS_LOG] PRIMARY KEY CLUSTERED  ([SYS_LOG_ID] ASC)
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[T_OE_SYS_EMAIL_LOG](
	[EMAIL_LOG_ID] [int] IDENTITY(1,1) NOT NULL,
	[LOG_DT] [datetime2](0) NULL,
	[LOG_FROM] [varchar](200) NULL,
	[LOG_TO] [varchar](200) NULL,
	[LOG_CC] [varchar](200) NULL,
	[LOG_SUBJ] [varchar](200) NULL,
	[LOG_MSG] [varchar](2000) NULL,
	[EMAIL_TYPE] [varchar](15) NULL,
 CONSTRAINT [PK_T_OE_SYS_EMAIL_LOG] PRIMARY KEY CLUSTERED  ([EMAIL_LOG_ID] ASC)
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[T_OE_REF_STATE](
	[STATE_CD] [varchar](2) NOT NULL,
	[STATE_NAME] [varchar](20) NOT NULL,
 CONSTRAINT [PK_T_OE_REF_STATE] PRIMARY KEY CLUSTERED ([STATE_CD] ASC)
 ) on [PRIMARY]

 GO

CREATE TABLE [dbo].[T_OE_REF_COUNTY](
	[STATE_CD] [varchar](2) NOT NULL,
	[COUNTY_CD] [varchar](3) NOT NULL,
	[COUNTY_NAME] [varchar](50) NOT NULL,
 CONSTRAINT [PK_OE_REF_COUNTY] PRIMARY KEY CLUSTERED (STATE_CD ASC, COUNTY_CD ASC),
 FOREIGN KEY ([STATE_CD]) references [T_OE_REF_STATE] ([STATE_CD]) ON UPDATE CASCADE ON DELETE CASCADE

) ON [PRIMARY]



CREATE TABLE [dbo].[T_EM_REF_COMPLEX_LVL](
	[INCIDENT_COMPLEX_LVL] [varchar](7) NOT NULL,
	[COMPLEX_LVL_DESC] [varchar](500) NOT NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_REF_COMPLEX_LVL] PRIMARY KEY CLUSTERED ([INCIDENT_COMPLEX_LVL] ASC)
 ) on [PRIMARY]


CREATE TABLE [dbo].[T_EM_REF_INCIDENT_PRIORITY](
	[INCIDENT_PRIORITY] [varchar](20) NOT NULL,
	[SORT_ORD] [int] NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_REF_INCIDENT_PRIORITY] PRIMARY KEY CLUSTERED ([INCIDENT_PRIORITY] ASC)
 ) on [PRIMARY]


CREATE TABLE [dbo].[T_EM_REF_MANAGEMENT_ORG](
	[INC_MANAGEMENT_ORG_CD] [varchar](4) NOT NULL,
	[COMPLEX_LVL_DESC] [varchar](40) NOT NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_REF_MANAGEMENT_ORG] PRIMARY KEY CLUSTERED ([INC_MANAGEMENT_ORG_CD] ASC)
 ) on [PRIMARY]

 
CREATE TABLE [dbo].[T_EM_REF_SHARE_TYPE](
	[SHARE_TYPE] [varchar](20) NOT NULL,
	[SHARE_DESC] [varchar](50) NOT NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
 CONSTRAINT [PK_T_EM_REF_SHARE_TYPE] PRIMARY KEY CLUSTERED (SHARE_TYPE)
) ON [PRIMARY]


 
CREATE TABLE [dbo].[T_EM_REF_INC_STATUS_TYPE](
	[STATUS_TYPE_CD] [varchar](20) NOT NULL,
	[STATUS_DESC] [varchar](50) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
 CONSTRAINT [PK_T_EM_REF_INC_STATUS_TYPE] PRIMARY KEY CLUSTERED ([STATUS_TYPE_CD])
) ON [PRIMARY]



CREATE TABLE [dbo].[T_EM_REF_RESOURCE_CAT](
	[RESOURCE_CATEGORY_CD] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[RESOURCE_CAT_DESC] [varchar](50) NOT NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_REF_RESOURCE_CAT] PRIMARY KEY CLUSTERED ([RESOURCE_CATEGORY_CD] ASC)
 ) on [PRIMARY]

GO

CREATE TABLE [dbo].[T_EM_REF_RESOURCE_KIND](
	[RESOURCE_KIND_CD] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[RESOURCE_KIND_DESC] [varchar](50) NOT NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_REF_RESOURCE_KIND] PRIMARY KEY CLUSTERED ([RESOURCE_KIND_CD] ASC)
 ) on [PRIMARY]

GO

CREATE TABLE [dbo].[T_EM_REF_RESOURCE_DISCIPLINE](
	[RESOURCE_DISCIPLINE_CD] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[RESOURCE_DISC_DESC] [varchar](50) NOT NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_REF_RESOURCE_DISCIPLINE] PRIMARY KEY CLUSTERED ([RESOURCE_DISCIPLINE_CD] ASC)
 ) on [PRIMARY]

GO

CREATE TABLE [dbo].[T_EM_REF_RESOURCE_CORE_CAP](
	[RESOURCE_CORE_CAP_CD] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[RESOURCE_CORE_CAP_DESC] [varchar](50) NOT NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_REF_RESOURCE_CORE_CAP] PRIMARY KEY CLUSTERED ([RESOURCE_CORE_CAP_CD] ASC)
 ) on [PRIMARY]

GO
 
CREATE TABLE [dbo].[T_EM_REF_RESOURCE_STATUS](
	[RESOURCE_STATUS_CD] [varchar] (1) NOT NULL,
	[RESOURCE_STATUS_NAME] [varchar](25) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_REF_RESOURCE_STATUS] PRIMARY KEY CLUSTERED ([RESOURCE_STATUS_CD] ASC)
 ) on [PRIMARY]

GO

CREATE TABLE [dbo].[T_EM_REF_RESOURCE_TYPE](
	[RESOURCE_TYPE_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[RESOURCE_FEMA_ID] [varchar](12) NULL,
	[RESOURCE_TYPE_NAME] [varchar](100) NOT NULL,
	[RESOURCE_TYPE_DESC] [varchar](1000) NULL,
	[RESOURCE_FUNCTION] [varchar](1000) NULL,
	[RESOURCE_CATEGORY] [varchar](50) NULL,
	[RESOURCE_KIND] [varchar](50) NULL,
	[RESOURCE_DISCIPLINE] [varchar](50) NULL,
	[RESOURCE_CORE_CAP] [varchar](50) NULL,
	[RESOURCE_ORDERING_INST] [varchar](max) NULL,
	[RESOURCE_FLAVOR_COUNT] [int] NULL,
	[ORG_IDX] [uniqueidentifier] NULL,  --only used for jurisdiction-specific resources
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_REF_RESOURCE_TYPE] PRIMARY KEY CLUSTERED (RESOURCE_TYPE_IDX ASC),
 FOREIGN KEY ([ORG_IDX]) references [T_OE_ORGANIZATIONS] ([ORG_IDX]) ON UPDATE CASCADE ON DELETE CASCADE
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[T_EM_REF_RESOURCE_TYPE_DTL](
	[RESOURCE_TYPE_DTL_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[RESOURCE_TYPE_IDX] [uniqueidentifier] NOT NULL,
	[COMPONENT] [varchar](50) NULL,
	[METRIC] [varchar](150) NULL,
	[CAPABILITY] [varchar](50) NULL,
	[ORDERING_SEQ] [int] NULL,
	[COMMENTS] [varchar](1000) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_REF_RESOURCE_TYPE_DTL] PRIMARY KEY CLUSTERED (RESOURCE_TYPE_DTL_IDX),
 FOREIGN KEY ([RESOURCE_TYPE_IDX]) references [T_EM_REF_RESOURCE_TYPE] ([RESOURCE_TYPE_IDX]) ON UPDATE CASCADE ON DELETE CASCADE
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[T_EM_REF_RESOURCE_TYPE_DTL_DATA](
	[RESOURCE_TYPE_DTL_IDX] [uniqueidentifier] NOT NULL,
	[TYPE_INT] [int] NOT NULL,
	[VALUE] [varchar](1000) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_REF_RESOURCE_TYPE_DTL_DATA] PRIMARY KEY CLUSTERED (RESOURCE_TYPE_DTL_IDX, TYPE_INT),
 FOREIGN KEY (RESOURCE_TYPE_DTL_IDX) references [T_EM_REF_RESOURCE_TYPE_DTL] (RESOURCE_TYPE_DTL_IDX) ON UPDATE CASCADE ON DELETE CASCADE
) ON [PRIMARY]



CREATE TABLE [dbo].[T_EM_REF_DOC_TYPE](
	[DOC_TYPE] [varchar](50) NOT NULL,
	[DOC_TYPE_DESC] [varchar](200) NULL,
	[ACT_IND] [bit] NOT NULL,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_REF_DOC_TYPE] PRIMARY KEY CLUSTERED (DOC_TYPE ASC)
) ON [PRIMARY];


CREATE TABLE [dbo].[T_EM_REF_DOC_STATUS_TYPE](
	[DOC_STATUS_TYPE] [varchar](10) NOT NULL,
	[ACT_IND] [bit] NOT NULL,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_REF_DOC_STATUS_TYPE] PRIMARY KEY CLUSTERED (DOC_STATUS_TYPE ASC)
) ON [PRIMARY];





CREATE TABLE [dbo].[T_EM_USER_ORG](
	[USER_ORG_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[USER_IDX] [int] NOT NULL,
	[ORG_IDX] [uniqueidentifier] NOT NULL,
	[ROLE_CD] [varchar](1) NULL,
	[STATUS_CD] [varchar](1) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_USER_ORG] PRIMARY KEY CLUSTERED ([USER_ORG_IDX] ASC),
 FOREIGN KEY ([USER_IDX]) references [T_OE_USERS] ([USER_IDX]) ON DELETE CASCADE,
 FOREIGN KEY ([ORG_IDX]) references [T_OE_ORGANIZATIONS] ([ORG_IDX]) ON DELETE CASCADE
 ) on [PRIMARY]


CREATE TABLE [dbo].[T_EM_USER_LOCATION](
	[USER_LOC_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[USER_IDX] [int] NOT NULL,
	[LATITUDE] [decimal](18,5) NULL,
	[LONGITUDE] [decimal](18,5) NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_USER_LOCATION] PRIMARY KEY CLUSTERED ([USER_LOC_IDX] ASC),
 FOREIGN KEY ([USER_IDX]) references [T_OE_USERS] ([USER_IDX]) ON DELETE CASCADE
 ) on [PRIMARY]




/*******************************************************************************************************/
/***************************************  NOTIFICATION  ************************************************/
/*******************************************************************************************************/

CREATE TABLE [dbo].[T_EM_USER_NOTIFICATION](
    [NOTIFICATION_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[USER_IDX] [int] NOT NULL,
	[NOTIFY_DT] [datetime2](0) NOT NULL,
	[NOTIFY_TYPE] [varchar](10) NOT NULL,
	[NOTIFY_TITLE] [varchar](50) NULL,
	[NOTIFY_DESC] [varchar](200) NULL,
	[READ_IND] bit NULL,
	[FROM_USER_IDX] [int] NULL,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_USER_NOTIFICATION] PRIMARY KEY CLUSTERED ([NOTIFICATION_IDX] ASC)
 ) on [PRIMARY]


/*******************************************************************************************************/
/***************************************  INDIVIDUALS ************************************************/
/*******************************************************************************************************/
CREATE TABLE [dbo].[T_EM_INDIVIDUALS](
	[INDIVIDUAL_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[ORG_IDX] [uniqueidentifier] NOT NULL,
	[INDV_FIRST_NAME] [varchar](40) NULL,
	[INDV_MID_NAME] [varchar](1) NULL,
	[INDV_LAST_NAME] [varchar](40) NULL,
	[INDV_DOB] [datetime2](0) NULL,
	[INDV_PHONE] [varchar](13) NULL,
	[INDV_EMAIL] [varchar](200) NULL,
	[INDV_AFFILIATION] [varchar](100) NULL, --new
	[ADD_LINE_ADR] [varchar](40) NULL,
	[ADD_CITY] [varchar](25) NULL,
	[ADD_STATE] [varchar](2) NULL,
	[ADD_ZIP] [varchar](10) NULL,
	[LINKED_USERIDX] [int] NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1, 
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_INDIVIDUALS] PRIMARY KEY CLUSTERED ([INDIVIDUAL_IDX] ASC),
 FOREIGN KEY ([ORG_IDX]) references [T_OE_ORGANIZATIONS] ([ORG_IDX]) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY ([LINKED_USERIDX]) references [T_OE_USERS] ([USER_IDX]) ON UPDATE CASCADE ON DELETE CASCADE
) ON [PRIMARY]

--ALTER TABLE T_EM_INDIVIDUALS ADD [INDV_AFFILIATION] [varchar](100) NULL;

/*******************************************************************************************************/
/***************************************  RESOURCE  ****************************************************/
/*******************************************************************************************************/
CREATE TABLE [dbo].[T_EM_RESOURCE](
	[RESOURCE_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[ORG_IDX] [uniqueidentifier] NOT NULL,
	[RESOURCE_TYPE_IDX] [uniqueidentifier] NOT NULL,
	[RESOURCE_COUNT] [varchar](5) NOT NULL,
	[RESOURCE_UNIT] [varchar](50) NULL,
	[RESOURCE_DESC] [varchar](200) NULL,
	[RESOURCE_LAT] [decimal](18,5) NULL,
	[RESOURCE_LONG] [decimal](18,5) NULL,
	[SHARE_TYPE] [varchar](20) NULL,
	[FEMA_NIMS_TYPE] [int] NULL,
	[RESOURCE_STATUS_CD] [varchar](1) NULL,
	[RESOURCE_EXP_DT] [datetime2](0) NULL,
	[VERIFY_DT] [datetime2](0) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,  
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_RESOURCE] PRIMARY KEY CLUSTERED ([RESOURCE_IDX] ASC),
 FOREIGN KEY ([ORG_IDX]) references [T_OE_ORGANIZATIONS] ([ORG_IDX]) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY ([RESOURCE_TYPE_IDX]) references [T_EM_REF_RESOURCE_TYPE] ([RESOURCE_TYPE_IDX]),
 FOREIGN KEY ([SHARE_TYPE]) references [T_EM_REF_SHARE_TYPE] ([SHARE_TYPE]),
 FOREIGN KEY ([RESOURCE_STATUS_CD]) references [T_EM_REF_RESOURCE_STATUS] ([RESOURCE_STATUS_CD])
) ON [PRIMARY]

--  alter table T_EM_RESOURCE add RESOURCE_EXP_DT datetime2(0) null;


CREATE TABLE [dbo].[T_EM_RESOURCE_DTL](
	[RESOURCE_DTL_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[RESOURCE_IDX] [uniqueidentifier] NOT NULL,
	[RESOURCE_TYPE_DTL_IDX] [uniqueidentifier] NOT NULL,
	[VALUE] [varchar](1000) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1, 
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_RESOURCE_DTL] PRIMARY KEY CLUSTERED ([RESOURCE_DTL_IDX] ASC),
 FOREIGN KEY ([RESOURCE_IDX]) references [T_EM_RESOURCE] ([RESOURCE_IDX]) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY ([RESOURCE_TYPE_DTL_IDX]) references [T_EM_REF_RESOURCE_TYPE_DTL] ([RESOURCE_TYPE_DTL_IDX]) 
) ON [PRIMARY]


CREATE TABLE [dbo].[T_EM_RESOURCE_VER_HIST](
	[RESOURCE_VER_HIST_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[RESOURCE_IDX] [uniqueidentifier] NOT NULL,
	[VERIFICATION_DT] [datetime2](0) NULL,
	[VERIFIED_BY_IDX] [int] NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1, 
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_RESOURCE_VER_HIST] PRIMARY KEY CLUSTERED ([RESOURCE_VER_HIST_IDX] ASC),
 FOREIGN KEY ([RESOURCE_IDX]) references [T_EM_RESOURCE] ([RESOURCE_IDX]) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY ([VERIFIED_BY_IDX]) references [T_OE_USERS] ([USER_IDX]) ON UPDATE CASCADE ON DELETE CASCADE
) ON [PRIMARY]


/*******************************************************************************************************/
/***************************************  INCIDENT  ****************************************************/
/*******************************************************************************************************/

CREATE TABLE [dbo].[T_EM_INCIDENT](
	[INCIDENT_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[ORG_IDX] [uniqueidentifier] NOT NULL,
	[INCIDENT_ID] [varchar](20) NULL,
	[INCIDENT_NAME] [varchar](50) NOT NULL,
	[INCIDENT_DESC] [varchar](500) NULL,
	[INCIDENT_PRIORITY] [varchar](20) NULL, --added
	[INC_MANAGEMENT_ORG_CD] [varchar](4) NULL,
	[INCIDENT_START_DT] [datetime2](0) NULL,
	[INCIDENT_END_DT] [datetime2](0) NULL,
	[INCIDENT_COMPLEX_LVL] [varchar](7) NULL,
	[INCIDENT_LOC_DESC] [varchar](200) NULL,
	[INCIDENT_LAT] [decimal](18,5) NULL,
	[INCIDENT_LONG] [decimal](18,5) NULL,
	[INCIDENT_STATE] [varchar](2) NULL,
	[INCIDENT_CNTY] [int] NULL,
	[INCIDENT_CITY] [varchar](30) NULL,
	[INCIDENT_LAND_SURVEY] [varchar](30) NULL,

	[INCIDENT_SIZE] [varchar](10) NULL,
	[INCIDENT_SIZE_UNIT] [varchar](10) NULL,
	[INCIDENT_PCT_CONTAINED] [decimal](18,5) NULL,
	[INCIDENT_HAZ_MAT] [varchar](100) NULL,
	[INCIDENT_WEATHER] [varchar](100) NULL,
	[INCIDENT_COSTS] [decimal](11,2) NULL,
	[INCIDENT_TOTAL_COSTS] [decimal](11,2) NULL,
	[SHARE_TYPE] [varchar](20) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_INCIDENT] PRIMARY KEY CLUSTERED ([INCIDENT_IDX] ASC),
 FOREIGN KEY ([INCIDENT_COMPLEX_LVL]) references [T_EM_REF_COMPLEX_LVL] ([INCIDENT_COMPLEX_LVL]) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY ([INC_MANAGEMENT_ORG_CD]) references [T_EM_REF_MANAGEMENT_ORG] ([INC_MANAGEMENT_ORG_CD]) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY ([ORG_IDX]) references [T_OE_ORGANIZATIONS] ([ORG_IDX]) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY ([SHARE_TYPE]) references [T_EM_REF_SHARE_TYPE] ([SHARE_TYPE]) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY ([INCIDENT_PRIORITY]) references [T_EM_REF_INCIDENT_PRIORITY] (INCIDENT_PRIORITY) ON UPDATE CASCADE ON DELETE CASCADE
) ON [PRIMARY]

GO


--ALTER TABLE T_EM_INCIDENT add [SHARE_TYPE] [varchar](20) NULL;
--ALTER TABLE T_EM_INCIDENT add [INCIDENT_PRIORITY] [varchar](20) NULL;
--ALTER TABLE T_EM_INCIDENT add FOREIGN KEY ([SHARE_TYPE]) references [T_EM_REF_SHARE_TYPE] ([SHARE_TYPE]);
--ALTER TABLE T_EM_INCIDENT add FOREIGN KEY ([INCIDENT_PRIORITY]) references [T_EM_REF_INCIDENT_PRIORITY] ([INCIDENT_PRIORITY]);





CREATE TABLE [dbo].[T_EM_INCIDENT_ATTACH](
	[ATTACH_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[INCIDENT_IDX] [uniqueidentifier] NOT NULL,
	[ATTACH_CONTENT] [varbinary](max) NULL,
	[ATTACH_TYPE] [varchar](20) NOT NULL,
	[ATTACH_NAME] [varchar](40) NULL,
	[ATTACH_DESC] [varchar](150) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_INCIDENT_ATTACH] PRIMARY KEY CLUSTERED ([ATTACH_IDX] ASC),
 FOREIGN KEY ([INCIDENT_IDX]) references [T_EM_INCIDENT] ([INCIDENT_IDX]) ON UPDATE CASCADE ON DELETE CASCADE
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[T_EM_INCIDENT_STATUS](
	[INC_STATUS_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[INCIDENT_IDX] [uniqueidentifier] NOT NULL,
	[STATUS_DT] [datetime] NOT NULL,
	[STATUS_TYPE_CD] [varchar](20) NULL,
	[STATUS_DESC] [varchar](40) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_INCIDENT_STATUS] PRIMARY KEY CLUSTERED ([INC_STATUS_IDX] ASC),
 FOREIGN KEY ([INCIDENT_IDX]) references [T_EM_INCIDENT] ([INCIDENT_IDX]) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY ([STATUS_TYPE_CD]) references [T_EM_REF_INC_STATUS_TYPE] ([STATUS_TYPE_CD]) ON UPDATE CASCADE ON DELETE CASCADE
) ON [PRIMARY]



CREATE TABLE [dbo].[T_EM_INCIDENT_LOC_AREA](
	[INCIDENT_LOC_AREA_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[INCIDENT_IDX] [uniqueidentifier] NOT NULL,
	[LOCATION_AREA_TYPE] [varchar](20) NULL,
	[LOCATION_PERIMETER] [varchar](max) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_INCIDENT_LOC_AREA] PRIMARY KEY CLUSTERED ([INCIDENT_LOC_AREA_IDX] ASC),
 FOREIGN KEY ([INCIDENT_IDX]) references [T_EM_INCIDENT] ([INCIDENT_IDX]) ON UPDATE CASCADE ON DELETE CASCADE
) ON [PRIMARY]


CREATE TABLE [dbo].[T_EM_INCIDENT_OP_PERIOD](
	[INCIDENT_OP_PERIOD_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[INCIDENT_IDX] [uniqueidentifier] NOT NULL,
	[OP_PERIOD_NAME] [varchar](30) NULL,
	[OP_PERIOD_START_DT] [datetime2](0) NULL,
	[OP_PERIOD_END_DT] [datetime2](0) NULL,
	[OP_PERIOD_COMMAND_EMPHASIS] [varchar](1000) NULL,
	[OP_PERIOD_SIT_AWARENESS] [varchar](1000) NULL,
	[OP_PERIOD_PLANNED_ACTION] [varchar](1000) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_INCIDENT_OP_PERIOD] PRIMARY KEY CLUSTERED ([INCIDENT_OP_PERIOD_IDX] ASC),
 FOREIGN KEY ([INCIDENT_IDX]) references [T_EM_INCIDENT] ([INCIDENT_IDX]) ON UPDATE CASCADE ON DELETE CASCADE
) ON [PRIMARY]


CREATE TABLE [dbo].[T_EM_INCIDENT_TEAM_DTL](
	[INCIDENT_TEAM_DTL_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[INCIDENT_OP_PERIOD_IDX] [uniqueidentifier] NULL,
	[INCIDENT_IDX] [uniqueidentifier] NULL,
	[REPORTS_TO_TEAM_DTL_IDX] [uniqueidentifier] NULL,
	[INDIVIDUAL_IDX] [uniqueidentifier] NULL,
	[RESOURCE_IDX] [uniqueidentifier] NULL,
	[ROLE_NAME] [varchar](30) NULL,
	[AGENCY] [varchar](50) NULL,
	[SEQ_NO] [int] NULL,
	[TRAINEE_IND] [varchar](1) NULL,
	[CONTACT_TYPE] [varchar](10) NULL,
	[CONTACT_INFO] [varchar](200) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_INCIDENT_TEAM_DTL] PRIMARY KEY CLUSTERED ([INCIDENT_TEAM_DTL_IDX] ASC),
 FOREIGN KEY ([INCIDENT_OP_PERIOD_IDX]) references [T_EM_INCIDENT_OP_PERIOD] ([INCIDENT_OP_PERIOD_IDX]),
 FOREIGN KEY ([INCIDENT_IDX]) references [T_EM_INCIDENT] ([INCIDENT_IDX]),
 FOREIGN KEY ([INDIVIDUAL_IDX]) references [T_EM_INDIVIDUALS] ([INDIVIDUAL_IDX]),
 FOREIGN KEY ([RESOURCE_IDX]) references [T_EM_RESOURCE] ([RESOURCE_IDX]),
) ON [PRIMARY]


CREATE TABLE [dbo].[T_EM_INCIDENT_OBJECTIVES](
	[INCIDENT_OBJECTIVE_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[INCIDENT_OP_PERIOD_IDX] [uniqueidentifier] NOT NULL,
	[INCIDENT_OBJECTIVE] [varchar](1000) NULL,
	[OBJECTIVE_PRIORITY] [varchar](10) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_INCIDENT_OBJECTIVES] PRIMARY KEY CLUSTERED ([INCIDENT_OBJECTIVE_IDX] ASC),
 FOREIGN KEY ([INCIDENT_OP_PERIOD_IDX]) references [T_EM_INCIDENT_OP_PERIOD] ([INCIDENT_OP_PERIOD_IDX])
) ON [PRIMARY]


CREATE TABLE [dbo].[T_EM_INCIDENT_ACTIONS](
	[INCIDENT_ACTION_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[INCIDENT_OP_PERIOD_IDX] [uniqueidentifier] NOT NULL,
	[ACTION_ASSIGNMENT_DATE] [datetime2](0) NULL,
	[RESPONSE_ACTION] [varchar](1000) NULL,
	[SPECIAL_INSTRUCTIONS] [varchar](1000) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_INCIDENT_ACTIONS] PRIMARY KEY CLUSTERED ([INCIDENT_ACTION_IDX] ASC),
 FOREIGN KEY ([INCIDENT_OP_PERIOD_IDX]) references [T_EM_INCIDENT_OP_PERIOD] ([INCIDENT_OP_PERIOD_IDX])
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[T_EM_INCIDENT_RESOURCES](
	[INCIDENT_RESOURCE_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[INCIDENT_IDX] [uniqueidentifier] NOT NULL,
	[RESOURCE_IDX] [uniqueidentifier] NOT NULL,
	[RESOURCE_COUNT] [varchar](5) NULL,
	[RESOURCE_ORDERED_DT] [datetime2](0) NULL,
	[RESOURCE_ETA_DT] [datetime2](0) NULL,
	[RESOURCE_ARRIVED_IND] [bit] NULL DEFAULT 0,
	[RESOURCE_NOTES] [varchar](1000) NULL,
	[RESOURCE_ASSIGNED_TO] [varchar](50) NULL,
	[RESOURCE_ASSIGNED_PERSONS_COUNT] [integer] NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_INCIDENT_RESOURCES] PRIMARY KEY CLUSTERED ([INCIDENT_RESOURCE_IDX] ASC),
 FOREIGN KEY ([INCIDENT_IDX]) references [T_EM_INCIDENT] ([INCIDENT_IDX]),
 FOREIGN KEY ([RESOURCE_IDX]) references [T_EM_RESOURCE] ([RESOURCE_IDX])
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[T_EM_INCIDENT_DMG_ASSESS](
	[INCIDENT_DMG_ASSESS_IDX] [uniqueidentifier] NOT NULL,
	[INCIDENT_IDX] [uniqueidentifier] NOT NULL,
	[ASSESSMENT_DATE] [datetime2](0) NULL,
	[ASSESSORS] [varchar](200) NULL,
	[ASSESS_LOCATION] [varchar](200) NULL,
	[ACT_IND] [bit] NOT NULL,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_INCIDENT_DMG_ASSESS] PRIMARY KEY CLUSTERED ([INCIDENT_DMG_ASSESS_IDX] ASC),
 FOREIGN KEY ([INCIDENT_IDX]) references [T_EM_INCIDENT] ([INCIDENT_IDX]) ON UPDATE CASCADE ON DELETE CASCADE
) ON [PRIMARY]

GO





/*******************************************************************************************************/
/***************************************  CERTIFICATION ************************************************/
/*******************************************************************************************************/
/*******************************************************************************************************/
CREATE TABLE [dbo].[T_EM_REF_QUAL_CATEGORY](
	[QUAL_CAT_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[QUAL_CAT_NAME] [varchar](70) NOT NULL,
	[QUAL_TYPE_DESC] [varchar](1000) NULL,
	[QUAL_CAT_COLOR] [varchar](8) NULL,
	[QUAL_CAT_LOGO] [varbinary](max) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1, 
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_REF_QUAL_CATEGORY] PRIMARY KEY CLUSTERED ([QUAL_CAT_IDX] ASC)
) ON [PRIMARY]


CREATE TABLE [dbo].[T_EM_REF_QUAL_TYPE](
	[QUAL_TYPE_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[QUAL_CAT_IDX] [uniqueidentifier] NOT NULL,
	[QUAL_TYPE_CD] [varchar](8) NOT NULL,
	[QUAL_TYPE_NAME] [varchar](70) NOT NULL,
	[QUAL_TYPE_DESC] [varchar](1000) NULL,
	[ORG_IDX] [uniqueidentifier] NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1, 
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_REF_QUAL_TYPE] PRIMARY KEY CLUSTERED ([QUAL_TYPE_IDX] ASC),
 FOREIGN KEY ([ORG_IDX]) references [T_OE_ORGANIZATIONS] ([ORG_IDX]) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY ([QUAL_CAT_IDX]) references [T_EM_REF_QUAL_CATEGORY] ([QUAL_CAT_IDX])
) ON [PRIMARY]


CREATE TABLE [dbo].[T_EM_REF_QUAL_TYPE_REQ](
	[QUAL_TYPE_REQ_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[QUAL_TYPE_IDX] [uniqueidentifier] NOT NULL,
	[QUAL_TYPE_REQ_TYPE] [varchar](20) NOT NULL,
	[QUAL_TYPE_REQ_DESC] [varchar](1000) NOT NULL,
	[SORT_NUM] [int] NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1, 
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_REF_QUAL_TYPE_REQ] PRIMARY KEY CLUSTERED ([QUAL_TYPE_REQ_IDX] ASC),
 FOREIGN KEY ([QUAL_TYPE_IDX]) references [T_EM_REF_QUAL_TYPE] ([QUAL_TYPE_IDX])
) ON [PRIMARY]




CREATE TABLE [dbo].[T_EM_QUALIFICATIONS](
	[QUALIFICATION_IDX]  [uniqueidentifier] NOT NULL DEFAULT newid(),
	[ORG_IDX]  [uniqueidentifier] NOT NULL,
	[INDIVIDUAL_IDX] [uniqueidentifier] NOT NULL,
	[QUAL_TYPE_IDX] [uniqueidentifier] NOT NULL,
	[EFF_DATE] [datetime2](0) NULL,
	[EXP_DATE] [datetime2](0) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1, 
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_QUALIFICATIONS] PRIMARY KEY CLUSTERED ([QUALIFICATION_IDX] ASC),
 FOREIGN KEY ([ORG_IDX]) references [T_OE_ORGANIZATIONS] ([ORG_IDX]) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY ([INDIVIDUAL_IDX]) references [T_EM_INDIVIDUALS] ([INDIVIDUAL_IDX]),
 FOREIGN KEY ([QUAL_TYPE_IDX]) references [T_EM_REF_QUAL_TYPE] ([QUAL_TYPE_IDX]),
) ON [PRIMARY]


GO


CREATE TABLE [dbo].[T_EM_QUALIFICATION_ATTACH](
	[QUAL_ATTACH_IDX]  [uniqueidentifier] NOT NULL DEFAULT newid(),
	[QUALIFICATION_IDX]  [uniqueidentifier] NOT NULL,
	[ATTACH_CONTENT] [varbinary](max) NULL,
	[ATTACH_DESC] [varchar](100) NULL,
	[ACT_IND] [bit] NOT NULL DEFAULT 1, 
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_QUALIFICATION_ATTACH] PRIMARY KEY CLUSTERED ([QUAL_ATTACH_IDX] ASC),
 FOREIGN KEY ([QUALIFICATION_IDX]) references [T_EM_QUALIFICATIONS] ([QUALIFICATION_IDX]) ON UPDATE CASCADE ON DELETE CASCADE
)



/*******************************************************************************************************/
/***************************************  DOCUMENTS ************************************************/
/*******************************************************************************************************/
/*******************************************************************************************************/

CREATE TABLE [dbo].[T_EM_DOCUMENTS](
	[DOC_IDX] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[ORG_IDX]  [uniqueidentifier] NOT NULL,
	[DOC_CONTENT] [varbinary](max) NULL,
	[DOC_NAME] [varchar](100) NULL,
	[DOC_TYPE] [varchar](50) NULL,
	[DOC_FILE_TYPE] [varchar](75) NULL,
	[DOC_SIZE] [int] NULL,
	[DOC_COMMENT] [varchar](200) NULL,
	[DOC_AUTHOR] [varchar](100) NULL,
	[SHARE_TYPE] [varchar](20) NULL,
	[DOC_STATUS_TYPE] [varchar](10) NULL,
	[ACT_IND] [bit] NOT NULL,
	[CREATE_USERIDX] [int] NULL,
	[CREATE_DT] [datetime2](0) NULL,
	[MODIFY_USERIDX] [int] NULL,
	[MODIFY_DT] [datetime2](0) NULL,
 CONSTRAINT [PK_T_EM_DOCUMENTS] PRIMARY KEY CLUSTERED (DOC_IDX ASC),
 FOREIGN KEY ([ORG_IDX]) references T_OE_ORGANIZATIONS ([ORG_IDX]) ON UPDATE CASCADE ,
 FOREIGN KEY (DOC_TYPE) references T_EM_REF_DOC_TYPE (DOC_TYPE) ON UPDATE CASCADE ,
 FOREIGN KEY (SHARE_TYPE) references T_EM_REF_SHARE_TYPE (SHARE_TYPE) ON UPDATE CASCADE, 
 FOREIGN KEY (DOC_STATUS_TYPE) references T_EM_REF_DOC_STATUS_TYPE (DOC_STATUS_TYPE) ON UPDATE CASCADE
) ON [PRIMARY];


GO


-- ****************************************************************************************************************************************
-- ************************* VIEWS                        *********************************************************************************
-- ****************************************************************************************************************************************
create view V_EM_TIMELINE as
select row_number() over(order by (select 0)) as TIMELINE_IDX, * 
from
(
	select INCIDENT_IDX, create_dt as TIMELINE_DT, 'Attachment Added' as UPDATE_TYPE, ATTACH_NAME as NME, ATTACH_IDX as KEY_IDX from T_EM_INCIDENT_ATTACH 
	union
	select INCIDENT_IDX, STATUS_DT as TIMELINE_DT, 'Status Update' as UPDATE_TYPE, STATUS_TYPE_CD as NME, INC_STATUS_IDX as KEY_IDX  from T_EM_INCIDENT_STATUS
	union
	select INCIDENT_IDX, OP_PERIOD_START_DT as TIMELINE_DT, 'Operational Period Started' as UPDATE_TYPE, OP_PERIOD_NAME as NME, INCIDENT_OP_PERIOD_IDX as KEY_IDX  from T_EM_INCIDENT_OP_PERIOD
	union 
	select INCIDENT_IDX, create_dt as TIMELINE_DT, 'Resource Added' as UPDATE_TYPE, '' as NME, INCIDENT_RESOURCE_IDX as KEY_IDX  from T_EM_INCIDENT_RESOURCES
) as T

GO



CREATE VIEW V_EM_INCIDENT_TEAM_DISPLAY
as
select ITD.*, I.INDV_FIRST_NAME, I.INDV_LAST_NAME, I.INDV_PHONE, RT.RESOURCE_TYPE_NAME
from T_EM_INCIDENT_TEAM_DTL ITD
left join T_EM_INDIVIDUALS I on ITD.INDIVIDUAL_IDX = I.INDIVIDUAL_IDX
left join T_EM_RESOURCE R on ITD.RESOURCE_IDX = R.RESOURCE_IDX
left join T_EM_REF_RESOURCE_TYPE RT on R.RESOURCE_TYPE_IDX = RT.RESOURCE_TYPE_IDX;

GO

-- ****************************************************************************************************************************************
-- ************************* [SP_RESOURCE_DTL]*********************************************************************************
-- ****************************************************************************************************************************************
CREATE PROCEDURE SP_RESOURCE_DTL
@ResourceIDX [uniqueidentifier]
AS
BEGIN
	/*
	DESCRIPTION: RETURNS RESOURCE DETAILS FOR A PARTICUALR RESOURCE_IDX
	CHANGE LOG: 
	*/
	SET NOCOUNT ON;
	DECLARE @ResourceTypeIDX [uniqueidentifier];
	select @ResourceTypeIDX = RESOURCE_TYPE_IDX from T_EM_RESOURCE where RESOURCE_IDX = @ResourceIDX;

	select R.RESOURCE_TYPE_DTL_IDX, R.RESOURCE_TYPE_IDX, R.COMPONENT, R.METRIC, R.CAPABILITY, R.ORDERING_SEQ, R.COMMENTS, RD.RESOURCE_IDX, RD.RESOURCE_DTL_IDX, RD.VALUE, RD.MODIFY_USERIDX, RD.MODIFY_DT
	from T_EM_REF_RESOURCE_TYPE_DTL R 
	left join T_EM_RESOURCE_DTL RD on R.RESOURCE_TYPE_DTL_IDX = RD.RESOURCE_TYPE_DTL_IDX
	where r.RESOURCE_TYPE_IDX = @ResourceTypeIDX
	and r.ACT_IND = 1
	ORDER BY ORDERING_SEQ;

END
GO



-- ****************************************************************************************************************************************
-- ************************* [SP_RESOURCE_ADV_SEARCH]*********************************************************************************
-- ****************************************************************************************************************************************
CREATE PROCEDURE SP_RESOURCE_ADV_SEARCH
@UserIDX int,
@OrgIDX [uniqueidentifier],
@ResourceStr varchar(50),
@LatMax decimal(12,8),
@LatMin decimal(12,8),
@LongMax decimal(12,8),
@LongMin decimal(12,8),
@kind varchar(50),
@statusCd varchar(1)
AS
BEGIN
	/*
	DESCRIPTION: RETURNS RESOURCES 
	CHANGE LOG: 
	*/
	SET NOCOUNT ON;
    
	if (@ResourceStr is null) 
		SET @ResourceStr = '';

	if (@kind = '')
		SET @kind = null;

	if (@statusCd = '')
		SET @statusCd = null;

	select 
    R.RESOURCE_IDX, R.ORG_IDX, R.RESOURCE_TYPE_IDX, R.RESOURCE_COUNT, R.RESOURCE_UNIT, R.RESOURCE_DESC, R.RESOURCE_LAT, R.RESOURCE_LONG, R.SHARE_TYPE,  R.RESOURCE_STATUS_CD,
	R.VERIFY_DT, R.ACT_IND, R.CREATE_USERIDX, R.CREATE_DT, R.MODIFY_USERIDX, R.MODIFY_DT, 
	RT.RESOURCE_TYPE_NAME, RT.RESOURCE_TYPE_DESC, RT.RESOURCE_KIND, RT.RESOURCE_CATEGORY, O.ORG_NAME, RS.RESOURCE_STATUS_NAME
	,(select count(*) from T_EM_USER_ORG EUO where EUO.ORG_IDX = R.ORG_IDX and EUO.USER_IDX = @UserIDX and EUO.STATUS_CD = 'A') as CAN_EDIT, R.RESOURCE_EXP_DT
	from T_EM_RESOURCE R, T_EM_REF_RESOURCE_TYPE RT, T_EM_REF_RESOURCE_STATUS RS, T_OE_ORGANIZATIONS O 
	where R.RESOURCE_TYPE_IDX = RT.RESOURCE_TYPE_IDX
    and R.RESOURCE_STATUS_CD = RS.RESOURCE_STATUS_CD
	and R.ORG_IDX = O.ORG_IDX 
	and R.ACT_IND = 1
	and (R.SHARE_TYPE in ('All Jurisdictions','Public') or R.ORG_IDX in (select UO.ORG_IDX from T_EM_USER_ORG UO where UO.USER_IDX = @UserIDX and UO.STATUS_CD = 'A'))
    and (@OrgIDX is null or R.ORG_IDX = @OrgIDX)  
	and (@statusCd is null or R.RESOURCE_STATUS_CD = @statusCd)
	and (@kind is null or RT.RESOURCE_KIND = @kind)
	and (@ResourceStr = '' or rt.RESOURCE_TYPE_NAME like '%' + @ResourceStr + '%')
    order by RT.RESOURCE_TYPE_NAME;
		
END
GO


-- ****************************************************************************************************************************************
-- ************************* [SP_RESOURCE_DETAIL_ADV_SEARCH - new]*********************************************************************************
-- ****************************************************************************************************************************************
CREATE PROCEDURE SP_RESOURCE_DTL_ADV_SEARCH
@UserIDX int
AS
BEGIN
	/*
	DESCRIPTION: RETURNS RESOURCE DETAILS USER HAS ACCESS TO
	CHANGE LOG: 
	*/
	SET NOCOUNT ON;
    
	select 
    RD.RESOURCE_DTL_IDX, RD.RESOURCE_IDX, RD.RESOURCE_TYPE_DTL_IDX, RD.VALUE, RD.ACT_IND, RD.CREATE_USERIDX, RD.CREATE_DT, RD.MODIFY_USERIDX, RD.MODIFY_DT,
	(select count(*) from T_EM_USER_ORG EUO where EUO.ORG_IDX = R.ORG_IDX and EUO.USER_IDX = @UserIDX and EUO.STATUS_CD = 'A') as CAN_EDIT
	from T_EM_RESOURCE R, T_EM_RESOURCE_DTL RD 
	where R.RESOURCE_IDX = RD.RESOURCE_IDX
	and R.ACT_IND = 1
	and (R.SHARE_TYPE in ('All Jurisdictions','Public') or R.ORG_IDX in (select UO.ORG_IDX from T_EM_USER_ORG UO where UO.USER_IDX = @UserIDX and UO.STATUS_CD = 'A'));
		
END
GO


-- ****************************************************************************************************************************************
-- ************************* [SP_INCIDENT_ADV_SEARCH]*********************************************************************************
-- ****************************************************************************************************************************************
CREATE PROCEDURE SP_INCIDENT_ADV_SEARCH
@UserIDX int,
@OrgIDX [uniqueidentifier]
AS
BEGIN
	/*
	DESCRIPTION: RETURNS INCIDENTS THAT ARE EITHER SET TO SHARED OR AMONGST THE USERS ORGS 
	CHANGE LOG: 
	*/
	SET NOCOUNT ON;
    
	select I.*, O.ORG_NAME, ImpactedArea.LOCATION_PERIMETER as ImpactedArea, ThreatenedArea.LOCATION_PERIMETER as ThreatenedArea
	,(select count(*) from T_EM_USER_ORG EUO where EUO.ORG_IDX = I.ORG_IDX and EUO.USER_IDX = @UserIDX and EUO.STATUS_CD = 'A') as CAN_EDIT
	from T_EM_INCIDENT I
	left join T_EM_INCIDENT_LOC_AREA ImpactedArea on I.INCIDENT_IDX = ImpactedArea.INCIDENT_IDX and ImpactedArea.LOCATION_AREA_TYPE = 'Impacted Area'
	left join T_EM_INCIDENT_LOC_AREA ThreatenedArea on I.INCIDENT_IDX = ThreatenedArea.INCIDENT_IDX and ThreatenedArea.LOCATION_AREA_TYPE = 'Threatened Area'
	, T_OE_ORGANIZATIONS O
	where I.ORG_IDX = O.ORG_IDX
	and I.ACT_IND = 1
	and (isnull(I.SHARE_TYPE,'') in ('All Jurisdictions','Public') or I.ORG_IDX in (select UO.ORG_IDX from T_EM_USER_ORG UO where UO.USER_IDX = @UserIDX and UO.STATUS_CD = 'A'))
    and (@OrgIDX is null or I.ORG_IDX = @OrgIDX)  
	;

END 
GO

-- ****************************************************************************************************************************************
-- ************************* [SP_QUAL_ADV_SEARCH]*********************************************************************************
-- ****************************************************************************************************************************************
--CREATE PROCEDURE SP_QUAL_ADV_SEARCH
--@UserIDX int,
--@OrgIDX [uniqueidentifier],
--@NameStr varchar(50),
--@QualTypeIDX int,
--@EffInd varchar(1)
--AS
--BEGIN
--	/*
--	DESCRIPTION: RETURNS QUALIFICATIONS
--	CHANGE LOG: 
--	*/
--	SET NOCOUNT ON;
    
--	if (@NameStr is null) 
--		SET @NameStr = '';

--/*
--	select 
--    Q.QUALIFICATION_IDX, Q.ORG_IDX, Q.INDIVIDUAL_IDX, Q.QUAL_TYPE_IDX, Q.EFF_DATE, Q.EXP_DATE,  RT.RESOURCE_TYPE_IDX, R.RESOURCE_COUNT, R.RESOURCE_UNIT, R.RESOURCE_DESC, R.RESOURCE_LAT, R.RESOURCE_LONG, R.VERIFY_DT, 
--    RT.RESOURCE_TYPE_NAME, RT.RESOURCE_TYPE_DESC, RT.RESOURCE_KIND, RT.RESOURCE_CATEGORY, O.ORG_NAME, R.RESOURCE_STATUS_CD, RS.RESOURCE_STATUS_NAME
--	from T_EM_RESOURCE R, T_EM_REF_RESOURCE_TYPE RT, T_EM_USER_ORG U, T_OE_ORGANIZATIONS O, T_EM_REF_RESOURCE_STATUS RS
--	where R.RESOURCE_TYPE_IDX = RT.RESOURCE_TYPE_IDX
--    and R.ORG_IDX = U.ORG_IDX
--	and R.ORG_IDX = O.ORG_IDX 
--    and U.USER_IDX = @UserIDX
--    and R.RESOURCE_STATUS_CD = RS.RESOURCE_STATUS_CD
--    and (@ResourceStr = '' or rt.RESOURCE_TYPE_NAME like '%' + @ResourceStr + '%')
--    order by RT.RESOURCE_TYPE_NAME;
	
--*/
--END
--GO

-- ****************************************************************************************************************************************
-- ************************* [SP_DASHBOARD_COUNTS        ]*********************************************************************************
-- ****************************************************************************************************************************************
CREATE PROCEDURE SP_DASHBOARD_COUNTS
@UserIDX int
AS
BEGIN
	/*
	DESCRIPTION: RETURNS VARIOUS COUNT INFORMATION USED ON THE DASHBOARD
	CHANGE LOG: 
	*/
	SET NOCOUNT ON;
    
	DECLARE @ResourceCount int = 0;
	DECLARE @JurisCount int = 0;
	DECLARE @ResponderCount int = 0;
	DECLARE @IncidentCount int = 0;

	select @ResourceCount = count(*) from T_EM_RESOURCE R 
	where R.RESOURCE_STATUS_CD = 'A' 
	and R.ACT_IND = 1
	and (R.SHARE_TYPE in ('Public','All Jurisdictions') or R.ORG_IDX in (select UO.ORG_IDX from T_EM_USER_ORG UO where UO.ORG_IDX = R.ORG_IDX and UO.USER_IDX = @UserIDX))

	select @JurisCount = count(distinct(r.org_idx)) from T_EM_RESOURCE R 
	where R.RESOURCE_STATUS_CD = 'A' or R.ORG_IDX in (select UO.ORG_IDX from T_EM_USER_ORG UO where UO.ORG_IDX = R.ORG_IDX and UO.USER_IDX = @UserIDX)

	select @ResponderCount = count(*) from T_EM_INDIVIDUALS IND where IND.ACT_IND = 1
	and IND.ORG_IDX in (select UO.ORG_IDX from T_EM_USER_ORG UO where UO.ORG_IDX = IND.ORG_IDX and UO.USER_IDX = @UserIDX);

	select @IncidentCount = count(*) from T_EM_INCIDENT I 
	where I.INCIDENT_END_DT is null
	and I.ACT_IND = 1 
	and (I.ORG_IDX in (select UO.ORG_IDX from T_EM_USER_ORG UO where UO.ORG_IDX = I.ORG_IDX and UO.USER_IDX = @UserIDX)
	    or (isnull(I.SHARE_TYPE,'') in ('All Jurisdictions','Public')));
	
	select @ResourceCount as ResourceCount, @JurisCount as JurisCount, @ResponderCount as ResponderCount, @IncidentCount as IncidentCount
	
END
GO





CREATE PROCEDURE [dbo].[SP_INCIDENT_STATUS_QUERY]
@UserIDX int,
@OrgIDX [uniqueidentifier]
AS
BEGIN
	/*
	DESCRIPTION: RETURNS INCIDENT STATUSES THAT ARE EITHER SET TO SHARED OR AMONGST THE USERS ORGS 
	CHANGE LOG: 
	*/
	SET NOCOUNT ON;
    
	select IST.* 
	,(select count(*) from T_EM_USER_ORG EUO where EUO.ORG_IDX = I.ORG_IDX and EUO.USER_IDX = @UserIDX and EUO.STATUS_CD = 'A') as CAN_EDIT
	from T_EM_INCIDENT I, T_EM_INCIDENT_STATUS IST
	where I.INCIDENT_IDX = IST.INCIDENT_IDX
	and I.ACT_IND = 1
	and IST.ACT_IND = 1
	and (isnull(I.SHARE_TYPE,'') in ('All Jurisdictions','Public') or I.ORG_IDX in (select UO.ORG_IDX from T_EM_USER_ORG UO where UO.USER_IDX = @UserIDX and UO.STATUS_CD = 'A'))
    and (@OrgIDX is null or I.ORG_IDX = @OrgIDX)  
	;

END 



GO


CREATE PROCEDURE [dbo].[SP_INCIDENT_RESOURCE_QUERY]
@UserIDX int,
@OrgIDX [uniqueidentifier]
AS
BEGIN
	/*
	DESCRIPTION: RETURNS INCIDENT RESOURCES THAT ARE EITHER SET TO SHARED OR AMONGST THE USERS ORGS 
	CHANGE LOG: 
	*/
	SET NOCOUNT ON;
    
	select IST.* 
	,(select count(*) from T_EM_USER_ORG EUO where EUO.ORG_IDX = I.ORG_IDX and EUO.USER_IDX = @UserIDX and EUO.STATUS_CD = 'A') as CAN_EDIT
	from T_EM_INCIDENT I, T_EM_INCIDENT_RESOURCES IST
	where I.INCIDENT_IDX = IST.INCIDENT_IDX
	and I.ACT_IND = 1
	and IST.ACT_IND = 1
	and (isnull(I.SHARE_TYPE,'') in ('All Jurisdictions','Public') or I.ORG_IDX in (select UO.ORG_IDX from T_EM_USER_ORG UO where UO.USER_IDX = @UserIDX and UO.STATUS_CD = 'A'))
    and (@OrgIDX is null or I.ORG_IDX = @OrgIDX)  
	;

END 

GO