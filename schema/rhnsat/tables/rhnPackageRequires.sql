-- $Id$
--/

-- this is how requires works... poorly.
-- you can do:
--
-- select
--      cap1.id
-- from
--      rhnCapability cap1,
--      rhnCapability cap2,
--      rhnPackageRequires req
-- where 
--      cap2.id = req.capabilityId
--      and cap1.name = cap2.name
--      and cap1.arch = cap2.arch
--      and cap1.id > cap2.id
create table
rhnPackageRequires
(
        package_id      number
                        constraint rhn_pkg_requires_pid_nn not null
                        constraint rhn_pkg_requires_package_fk
                                references rhnPackage(id),
        capability_id   number
                        constraint rhn_pkg_requires_cid_nn not null
                        constraint rhn_pkg_requires_capability_fk
                                references rhnPackageCapability(id),
        sense           number default(0) -- comes from RPMSENSE_*
                        constraint rhn_pkg_requires_sense_nn not null,
        created         date default (sysdate)
                        constraint rhn_pkg_requires_ctime_nn not null,
        modified        date default (sysdate)
                        constraint rhn_pkg_requires_mtime_nn not null
)
	storage ( freelists 16 )
	initrans 32;

create unique index rhn_pkg_req_pid_cid_s_uq
	on rhnPackageRequires(package_id, capability_id, sense)
	tablespace [[4m_tbs]]
	storage ( freelists 16 )
	initrans 32;

create index rhn_pkg_requires_cid_idx
	on rhnPackageRequires(capability_id)
        nologging tablespace [[4m_tbs]]
	storage ( freelists 16 )
	initrans 32;

create or replace trigger
rhn_pkg_requires_mod_trig
before insert or update on rhnPackageRequires
for each row
begin
        :new.modified := sysdate;
end;
/
show errors

-- $Log$
-- Revision 1.12  2004/12/07 20:18:56  cturner
-- bugzilla: 142156, simplify the triggers
--
-- Revision 1.11  2003/01/30 16:11:28  pjones
-- storage parameters, also fix deps to make it build again
--
-- Revision 1.10  2003/01/24 16:42:23  pjones
-- last_modified on rhnPackage and rhnPackageSource
--
-- Revision 1.9  2002/05/10 22:00:48  pjones
-- add rhnFAQClass, and make it a dep for rhnFAQ
-- add grants where appropriate
-- add cvs id/log where it's been missed
-- split data out where appropriate
-- add excludes where appropriate
-- make sure it still builds (at least as sat).
-- (really this time)
--
