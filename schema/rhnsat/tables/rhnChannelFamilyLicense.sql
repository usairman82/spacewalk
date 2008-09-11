--
-- $Id$
--/

CREATE TABLE
rhnChannelFamilyLicense
(
        channel_family_id   number
			    constraint rhn_cfl_cfid_nn not null
    	    	    	    constraint rhn_cfl_cfid_fk
                            	references rhnChannelFamily(id)
				on delete cascade,
    	license_path        varchar2(1000)
	    	       	    constraint rhn_cfl_license_nn not null,
	created		date default (sysdate)
			constraint rhn_cfl_created_nn not null,
	modified	date default (sysdate)
			constraint rhn_cfl_modified_nn not null
)
	storage ( freelists 16 )
	initrans 32;

create unique index rhn_cf_license_cfid_uq
	on rhnChannelFamilyLicense(channel_family_id)
	tablespace [[64k_tbs]]
	storage ( freelists 16 )
	initrans 32;

create or replace trigger
rhn_cf_license_mod_trig
before insert or update on rhnChannelFamilyLicense
for each row
begin
        :new.modified := sysdate;
end;
/
SHOW ERRORS;


-- $Log$
-- Revision 1.4  2003/01/30 16:11:28  pjones
-- storage parameters, also fix deps to make it build again
--
-- Revision 1.3  2002/10/09 14:15:57  cturner
-- fix for broken trigger creation in rhnChannelFamilyLicense.sql and rhnChannelFamilyLicenseConsent.sql
--
-- Revision 1.2  2002/10/02 19:21:04  bretm
-- o  3rd party channel schema changes, no more clobs...
--
-- Revision 1.1  2002/09/12 20:33:59  bretm
-- o  stuff for the bea channel
--
