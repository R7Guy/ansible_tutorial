#!/bin/bash
###############################################################################
# Program       : purge_unified_audit_trail.sh
# Description   : Purge Unified Audit Trail
# Author        : Reyaz Alibux
# Date          : 2021-11-30
################################################################################
# v1.0.0  2021-11-30 Reyaz Alibux initial Version
# v1.0.2    
# v1.0.3  
################################################################################
# Oracle Settings
export TMP=/tmp
export TMPDIR=$TMP
export ORACLE_HOSTNAME=nlmpdldb02
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
export TNS_ADMIN=$ORACLE_HOME/network/admin
export PATH=/usr/sbin:/usr/local/bin:$PATH
export PATH=$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
export ORACLE_SID=pre
export LOG_DIR=/home/oracle/log
LOG_FILE="${LOG_DIR}/purge_unified_audit_trail_$(date +%Y_%m_%d).log"
#export TARGET_DB=prod
#LIST="NL.GEN.Oracle-DBA@cgi.com"
LIST="reyaz.alibux@cgi.com"

#begin
> ${LOG_FILE}
echo "Begin Audit Trail Cleanup" >> ${LOG_FILE}
echo >> ${LOG_FILE}

for TARGET_DB in pre test ontw accept
do
export ORACLE_SID=${TARGET_DB}
#check target db
echo >> ${LOG_FILE}
echo "Database_Name: " ${TARGET_DB} >> ${LOG_FILE}
echo >> ${LOG_FILE}
echo "Checking target db" >> ${LOG_FILE}
echo >> ${LOG_FILE}
tnsping ${TARGET_DB}
if [ "$?" -ne 0 ]; then
  echo "${TARGET_DB} is not UP" >> ${LOG_FILE}
  exit 1
fi
#perform cleanup of unified audit trail
echo "Performing cleanup of unified audit trail" >> ${LOG_FILE}
echo >> ${LOG_FILE}
sqlplus '/as sysdba'<<EOF7 >> ${LOG_FILE}
@/home/oracle/scripts/check_db.sql
exit
EOF7
echo "**********************" >> ${LOG_FILE}
done

mailx -s "Unified Audit Trail Cleanup OTA MPD" -a ${LOG_FILE} ${LIST} < /home/oracle/bin/purge_unified_audit_trail.txt
#mailx -s "Unified Audit Trail Cleanup OTA MPD" reyaz.alibux@cgi.com < ${LOG_FILE}

