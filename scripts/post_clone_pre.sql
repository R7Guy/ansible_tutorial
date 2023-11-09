-- koppeling met pensioenregister data voor testware

drop public database link pr;

create public database link pr
   connect to testregister identified by testregister
   USING 'PRPORTAL';

update pnodata.ris_referentie set waarde_c = null where domein = 'MAIL_RUIF';

commit;

grant sysdba to SRV_JENKINS;
grant dba to jacob;
alter user jacob default role dba;

-- ontwikkelaars mogen alles

grant dba to ontw;

delete from algemeen.accountbeperking;


commit;
-- exit;

