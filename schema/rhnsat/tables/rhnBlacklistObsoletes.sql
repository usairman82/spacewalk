--
-- $Id$
--

create table rhnBlacklistObsoletes
(
	name_id			number
				constraint rhn_bl_obs_nid_nn not null
				constraint rhn_bl_obs_nid_fk
					references rhnPackageName(id),
	evr_id			number
				constraint rhn_bl_obs_eid_nn not null
				constraint rhn_bl_obs_eid_fk
					references rhnPackageEVR(id),
	package_arch_id		number
				constraint rhn_bl_obs_paid_nn not null
				constraint rhn_bl_obs_paid_fk
					references rhnPackageArch(id),
	ignore_name_id		number
				constraint rhn_bl_obs_inid_nn not null
				constraint rhn_bl_obs_inid_fk
					references rhnPackageName(id),
	created			date default(sysdate)
				constraint rhn_bl_obs_created_nn not null,
	modified		date default(sysdate)
				constraint rhn_bl_obs_modified_nn not null
);

create index rhn_bl_obs_nepi_idx
	on rhnBlacklistObsoletes ( name_id, evr_id, package_arch_id, 
		ignore_name_id )
--	tablespace [[64k_tbs]]
	storage ( freelists 16 )
	initrans 32;
alter table rhnBlacklistObsoletes add constraint rhn_bl_obs_nepi_uq
	unique ( name_id, evr_id, package_arch_id, ignore_name_id );

create or replace trigger
rhn_bl_obs_mod_trig
before insert or update on rhnBlacklistObsoletes
for each row
begin
	:new.modified := sysdate;
end;
/
show errors

-- $Log$
-- Revision 1.5  2003/02/10 22:35:07  misa
-- bugzilla: 83597 Refine the trigger
--
-- Revision 1.4  2003/02/10 22:17:52  misa
-- bugzilla: 83597 Trigger to upate last_modified for all channels upon table changes
--
-- Revision 1.3  2003/02/07 17:46:46  pjones
-- rework rhnBlacklistObsoletes
--
