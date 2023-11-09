#!/bin/bash
###############################################################################
# Program       : uitwijk_prod.sh
# Description   : Create the uitwijk prod database on nlmpdldb02
# Author        : Reyaz Alibux
# Date          : 2020-07-13
################################################################################
# v1.0.0  2020-07-13 Reyaz Alibux initial Version
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
export ORACLE_SID=prod
export LOG_DIR=/home/oracle/log
LOG_FILE="${LOG_DIR}/UITWIJK_PROD_$(date +%Y_%m_%d).log"
export TARGET_DB=prod
LIST="reyaz.alibux@cgi.com j.schmeltz@cgi.com john.timmer@cgi.com peter.verschoor@cgi.com javid.sharifi@cgi.com ron.vanden.bulk@cgi.com"
#LIST="reyaz.alibux@cgi.nl"

#begin
> ${LOG_FILE}
echo "begin" >> ${LOG_FILE}
echo >> ${LOG_FILE}

##shutdown database
#echo "shutdown destination database" >> ${LOG_FILE}
#echo >> ${LOG_FILE}
#sqlplus '/as sysdba'<<EOF >> ${LOG_FILE}
#select name, open_mode from v\$database ;
#shut immediate
#exit
#EOF

#cleanup database files 
echo "cleanup database files" >> ${LOG_FILE}
echo >> ${LOG_FILE}
cd /tmp && rm -rf $ORACLE_HOME/dbs/spfile$ORACLE_SID.ora
cd /tmp && rm -rf /u02/oradata/PROD/datafile/*.dbf
cd /tmp && rm -rf /u02/oradata/PROD/controlfile/*.ctl
cd /tmp && rm -rf /u03/oradata/PROD/controlfile/*.ctl
cd /tmp && rm -rf /u02/oradata/PROD/onlinelog/*.log
cd /tmp && rm -rf /u03/oradata/PROD/onlinelog/*.log
cd /tmp && rm -rf /u02/oradata/PROD/datafile/*.tmp

##drop database
#echo "drop target database" >> ${LOG_FILE}
#echo >> ${LOG_FILE}
#sqlplus '/as sysdba'<<EOF1 >> ${LOG_FILE}
#startup mount exclusive restrict;
#drop database;
#exit
#EOF1

#checkpfile
echo "check destination pfile" >> ${LOG_FILE}
echo >> ${LOG_FILE}
PFILE=$ORACLE_HOME/dbs/init$ORACLE_SID.ora
if [[ ! -f "$PFILE" ]]; then
    echo "$PFILE does not exist" >> ${LOG_FILE}
    exit 1
fi

#check_passwd_file
echo "check destination password file" >> ${LOG_FILE}
echo >> ${LOG_FILE}
FILE=$ORACLE_HOME/dbs/orapw$ORACLE_SID
if [[ ! -f "$FILE" ]]; then
    echo "$FILE does not exist" >> ${LOG_FILE}
    exit 1
fi

#perform restore
echo >> ${LOG_FILE}
echo "performing restore spfile and controlfile" >> ${LOG_FILE}
echo >> ${LOG_FILE}
rman<<EOF4 >> ${LOG_FILE}
connect target /
connect catalog rman_mpd_PROD/07Vndd86@RMANNLP12c
@/home/oracle/scripts/uitwijk_prod_1
EOF4

#perform restore
echo >> ${LOG_FILE}
echo "performing restore and recover database" >> ${LOG_FILE}
echo >> ${LOG_FILE}
rman<<EOF5 >> ${LOG_FILE}
connect target /
@/home/oracle/scripts/uitwijk_prod_2
EOF5
