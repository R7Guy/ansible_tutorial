select  count(*) from unified_audit_trail;
BEGIN
DBMS_AUDIT_MGMT.CLEAN_AUDIT_TRAIL(
audit_trail_type         =>  DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED,
use_last_arch_timestamp  =>  FALSE);
END;
/
select  count(*) from unified_audit_trail;
