--
-- $Id$
--

create table
rhnOrgChannelSettings
(
	org_id		number
			constraint rhn_orgcsettings_oid_nn not null
			constraint rhn_orgcsettings_oid_fk
				references web_customer(id)
				on delete cascade,
	channel_id	number
			constraint rhn_orgcsettings_cid_nn not null
			constraint rhn_orgcsettings_cid_fk
				references rhnChannel(id)
				on delete cascade,
	setting_id	number
			constraint rhn_orgcsettings_sid_nn not null
			constraint rhn_orgcsettings_sid_fk
				references rhnOrgChannelSettingsType(id),
	created		date default(sysdate)
			constraint rhn_orgcsettings_created_nn not null,
	modified	date default(sysdate)
			constraint rhn_orgcsettings_modified_nn not null
)
	storage ( freelists 16 )
	initrans 32;

create unique index rhn_orgcsettings_oid_cid_uq
	on rhnOrgChannelSettings(org_id, channel_id, setting_id)
	tablespace [[8m_tbs]]
	storage ( freelists 16 )
	initrans 32;

create or replace trigger
rhn_orgcsettings_mod_trig
before insert or update on rhnOrgChannelSettings
for each row
begin
	:new.modified := sysdate;	
end;
/
show errors

-- $Log$
-- Revision 1.3  2003/07/18 18:15:04  pjones
-- bugzilla: none -- shouldn't exclude this file ;)
--
-- Revision 1.2  2003/07/17 18:07:18  pjones
-- bugzilla: none
--
-- change this to be the new way which was discussed
--
-- Revision 1.1  2003/07/15 17:36:50  pjones
-- bugzilla: 98933
--
-- channel permissions
--
