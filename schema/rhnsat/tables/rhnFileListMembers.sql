--
-- $Id$
--

create table
rhnFileListMembers
(
	file_list_id		number
				constraint rhn_flmembers_flid_nn not null
				constraint rhn_flmembers_flid_fk
					references rhnFileList(id)
					on delete cascade,
	config_file_name_id	number
				constraint rhn_flmembers_cfnid_nn not null
				constraint rhn_flmembers_cfnid_fk
					references rhnConfigFileName(id),
	created			date default (sysdate)	
				constraint rhn_flmembers_creat_nn not null,
	modified		date default (sysdate)
				constraint rhn_flmembers_mod_nn not null
)
	storage ( freelists 16 )
	initrans 32;

create unique index rhn_flmembers_flid_cfnid_uq
	on rhnFileListMembers( file_list_id, config_file_name_id )
	tablespace [[4m_tbs]]
	storage ( freelists 16 )
	initrans 32;

create or replace trigger
rhn_flmembers_mod_trig
before insert or update on rhnFileListMembers
for each row
begin
	:new.modified := sysdate;
end rhn_flmembers_mod_trig;
/
show errors

--
-- $Log$
-- Revision 1.1  2004/05/25 02:25:34  pjones
-- bugzilla: 123426 -- tables in which to keep lists of files to be preserved.
--

