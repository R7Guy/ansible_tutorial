-- Create Monitoring profile
-- This profile is used by the monitor software user accounts.
spool cre_cgimon.log

CREATE PROFILE monitor LIMIT
 FAILED_LOGIN_ATTEMPTS 5
 PASSWORD_LIFE_TIME    UNLIMITED
 PASSWORD_REUSE_TIME   1
 PASSWORD_REUSE_MAX    1
 PASSWORD_LOCK_TIME    1
 PASSWORD_GRACE_TIME   7
 PASSWORD_VERIFY_FUNCTION verify_function
;

--DROP USER CGIMON CASCADE;
--DROP VIEW V_CGIMON_DBGALERT;
--DROP ROLE ROLE_CGIMON;

CREATE USER CGIMON
 IDENTIFIED BY "tnvd%sk-4fkduvNH777jOZJ"
 PROFILE MONITOR
 ACCOUNT UNLOCK;

CREATE VIEW V_CGIMON_DBGALERT AS SELECT * FROM x$dbgalertext;
CREATE synonym CGIMON.v$alert_log FOR sys.V_CGIMON_DBGALERT;
CREATE ROLE ROLE_CGIMON;
GRANT CREATE SESSION                    TO ROLE_CGIMON;
 
GRANT SELECT ON DBA_AUDIT_SESSION       TO ROLE_CGIMON;
GRANT SELECT ON DBA_AUDIT_TRAIL         TO ROLE_CGIMON;
GRANT SELECT ON DBA_DATA_FILES          TO ROLE_CGIMON;
GRANT SELECT ON DBA_FREE_SPACE          TO ROLE_CGIMON;
GRANT SELECT ON DBA_REGISTRY            TO ROLE_CGIMON;
GRANT SELECT ON DBA_TABLESPACES         TO ROLE_CGIMON;
GRANT SELECT ON DBA_TEMP_FILES          TO ROLE_CGIMON;
GRANT SELECT ON DBA_USERS               TO ROLE_CGIMON;
GRANT SELECT ON GV_$ARCHIVED_LOG        TO ROLE_CGIMON;
GRANT SELECT ON GV_$DATABASE            TO ROLE_CGIMON;
GRANT SELECT ON GV_$DBFILE              TO ROLE_CGIMON;
GRANT SELECT ON GV_$INSTANCE            TO ROLE_CGIMON;
GRANT SELECT ON GV_$LATCH               TO ROLE_CGIMON;
GRANT SELECT ON GV_$LIBRARYCACHE        TO ROLE_CGIMON;
GRANT SELECT ON GV_$LOCK                TO ROLE_CGIMON;
GRANT SELECT ON GV_$LOG_HISTORY         TO ROLE_CGIMON;
GRANT SELECT ON GV_$PARAMETER           TO ROLE_CGIMON;
GRANT SELECT ON GV_$PGASTAT             TO ROLE_CGIMON;
GRANT SELECT ON GV_$PROCESS             TO ROLE_CGIMON;
GRANT SELECT ON GV_$SESSION             TO ROLE_CGIMON;
GRANT SELECT ON GV_$SGASTAT             TO ROLE_CGIMON;
GRANT SELECT ON GV_$SQLTEXT             TO ROLE_CGIMON;
GRANT SELECT ON GV_$SYSSTAT             TO ROLE_CGIMON;
GRANT SELECT ON GV_$SYSTEM_EVENT        TO ROLE_CGIMON;
GRANT SELECT ON GV_$_LOCK               TO ROLE_CGIMON;
GRANT SELECT ON V_$ARCHIVED_LOG         TO ROLE_CGIMON;
GRANT SELECT ON V_$DATABASE             TO ROLE_CGIMON;
GRANT SELECT ON V_$DBFILE               TO ROLE_CGIMON;
GRANT SELECT ON V_$INSTANCE             TO ROLE_CGIMON;
GRANT SELECT ON V_$LATCH                TO ROLE_CGIMON;
GRANT SELECT ON V_$LIBRARYCACHE         TO ROLE_CGIMON;
GRANT SELECT ON V_$LOCK                 TO ROLE_CGIMON;
GRANT SELECT ON V_$LOG_HISTORY          TO ROLE_CGIMON;
GRANT SELECT ON V_$PARAMETER            TO ROLE_CGIMON;
GRANT SELECT ON V_$PGASTAT              TO ROLE_CGIMON;
GRANT SELECT ON V_$PROCESS              TO ROLE_CGIMON;
GRANT SELECT ON V_$RECOVERY_FILE_DEST   TO ROLE_CGIMON;
GRANT SELECT ON V_$RMAN_STATUS          TO ROLE_CGIMON;
GRANT SELECT ON V_$SESSION              TO ROLE_CGIMON;
GRANT SELECT ON V_$SGASTAT              TO ROLE_CGIMON;
GRANT SELECT ON V_$SQLTEXT              TO ROLE_CGIMON;
GRANT SELECT ON V_$SYSSTAT              TO ROLE_CGIMON;
GRANT SELECT ON V_$SYSTEM_EVENT         TO ROLE_CGIMON;
GRANT SELECT ON V_$_LOCK                TO ROLE_CGIMON;
GRANT SELECT ON V_CGIMON_DBGALERT       TO ROLE_CGIMON;
 
-- set role as default for the user --
ALTER USER CGIMON DEFAULT ROLE NONE;
GRANT ROLE_CGIMON TO CGIMON;
ALTER USER CGIMON DEFAULT ROLE ROLE_CGIMON;


select count(1) from dba_tab_privs where grantee = 'ROLE_CGIMON';
spool off
exit

