

exec DBMS_AUDIT_MGMT.CLEAN_AUDIT_TRAIL(AUDIT_TRAIL_TYPE => DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED, use_last_arch_timestamp => false);

delete from dba_audit_mgmt_last_arch_ts where DATABASE_ID <> (select  dbid from v$database);

commit;


ALTER AUDIT POLICY mpd_pol add actions CREATE TABLE                   ;
ALTER AUDIT POLICY mpd_pol add actions INSERT                         ;
ALTER AUDIT POLICY mpd_pol add actions UPDATE                         ;
ALTER AUDIT POLICY mpd_pol add actions DELETE                         ;
ALTER AUDIT POLICY mpd_pol add actions CREATE INDEX                   ;
ALTER AUDIT POLICY mpd_pol add actions DROP INDEX                     ;
ALTER AUDIT POLICY mpd_pol add actions ALTER INDEX                    ;
ALTER AUDIT POLICY mpd_pol add actions DROP TABLE                     ;
ALTER AUDIT POLICY mpd_pol add actions CREATE SEQUENCE                ;
ALTER AUDIT POLICY mpd_pol add actions ALTER SEQUENCE                 ;
ALTER AUDIT POLICY mpd_pol add actions ALTER TABLE                    ;
ALTER AUDIT POLICY mpd_pol add actions DROP SEQUENCE                  ;
ALTER AUDIT POLICY mpd_pol add actions CREATE SYNONYM                 ;
ALTER AUDIT POLICY mpd_pol add actions DROP SYNONYM                   ;
ALTER AUDIT POLICY mpd_pol add actions CREATE VIEW                    ;
ALTER AUDIT POLICY mpd_pol add actions DROP VIEW                      ;
ALTER AUDIT POLICY mpd_pol add actions CREATE PROCEDURE               ;
ALTER AUDIT POLICY mpd_pol add actions ALTER PROCEDURE                ;
ALTER AUDIT POLICY mpd_pol add actions CREATE DATABASE LINK           ;
ALTER AUDIT POLICY mpd_pol add actions DROP DATABASE LINK             ;
ALTER AUDIT POLICY mpd_pol add actions ALTER DATABASE                 ;
ALTER AUDIT POLICY mpd_pol add actions DROP TABLESPACE                ;
ALTER AUDIT POLICY mpd_pol add actions ALTER USER                     ;
ALTER AUDIT POLICY mpd_pol add actions ALTER SYSTEM                   ;
ALTER AUDIT POLICY mpd_pol add actions CREATE USER                    ;
ALTER AUDIT POLICY mpd_pol add actions CREATE ROLE                    ;
ALTER AUDIT POLICY mpd_pol add actions DROP USER                      ;
ALTER AUDIT POLICY mpd_pol add actions DROP ROLE                      ;
ALTER AUDIT POLICY mpd_pol add actions CREATE TRIGGER                 ;
ALTER AUDIT POLICY mpd_pol add actions ALTER TRIGGER                  ;
ALTER AUDIT POLICY mpd_pol add actions DROP TRIGGER                   ;
ALTER AUDIT POLICY mpd_pol add actions CREATE PROFILE                 ;
ALTER AUDIT POLICY mpd_pol add actions DROP PROFILE                   ;
ALTER AUDIT POLICY mpd_pol add actions ALTER PROFILE                  ;
ALTER AUDIT POLICY mpd_pol add actions DROP PROCEDURE                 ;
ALTER AUDIT POLICY mpd_pol add actions CREATE TYPE                    ;
ALTER AUDIT POLICY mpd_pol add actions DROP TYPE                      ;
ALTER AUDIT POLICY mpd_pol add actions ALTER ROLE                     ;
ALTER AUDIT POLICY mpd_pol add actions TRUNCATE TABLE                 ;
ALTER AUDIT POLICY mpd_pol add actions ALTER VIEW                     ;
ALTER AUDIT POLICY mpd_pol add actions CREATE FUNCTION                ;
ALTER AUDIT POLICY mpd_pol add actions ALTER FUNCTION                 ;
ALTER AUDIT POLICY mpd_pol add actions DROP FUNCTION                  ;
ALTER AUDIT POLICY mpd_pol add actions CREATE PACKAGE                 ;
ALTER AUDIT POLICY mpd_pol add actions ALTER PACKAGE                  ;
ALTER AUDIT POLICY mpd_pol add actions DROP PACKAGE                   ;
ALTER AUDIT POLICY mpd_pol add actions CREATE PACKAGE BODY            ;
ALTER AUDIT POLICY mpd_pol add actions ALTER PACKAGE BODY             ;
ALTER AUDIT POLICY mpd_pol add actions DROP PACKAGE BODY              ;
ALTER AUDIT POLICY mpd_pol add actions CREATE DIRECTORY               ;
ALTER AUDIT POLICY mpd_pol add actions DROP DIRECTORY                 ;
ALTER AUDIT POLICY mpd_pol add actions CREATE RESTORE POINT           ;
ALTER AUDIT POLICY mpd_pol add actions DROP RESTORE POINT             ;
ALTER AUDIT POLICY mpd_pol add actions CREATE AUDIT POLICY            ;
ALTER AUDIT POLICY mpd_pol add actions ALTER AUDIT POLICY             ;
ALTER AUDIT POLICY mpd_pol add actions DROP AUDIT POLICY              ;
ALTER AUDIT POLICY mpd_pol add actions GRANT                          ;
ALTER AUDIT POLICY mpd_pol add actions REVOKE                         ;
ALTER AUDIT POLICY mpd_pol add actions AUDIT                          ;
ALTER AUDIT POLICY mpd_pol add actions NOAUDIT                        ;
ALTER AUDIT POLICY mpd_pol add actions PURGE DBA_RECYCLEBIN           ;

noaudit policy ORA_SECURECONFIG ;
audit policy ORA_SECURECONFIG except SRV_JENKINS;
noaudit policy ORA_LOGON_FAILURES;
audit policy ORA_LOGON_FAILURES WHENEVER NOT SUCCESSFUL;

noaudit policy mpd_pol by sys;
noaudit policy mpd_pol by system;

