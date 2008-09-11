--
-- $Id$
--

create table
rhnActionConfigDateFile
(
	action_id		number
				constraint rhn_actioncd_file_aid_nn not null
				constraint rhn_actioncd_file_aid_fk
					references rhnAction(id)
					on delete cascade,
	file_name		varchar2(512)
				constraint rhn_actioncd_file_fn_nn not null,
	-- I could make this a lookup table, if anybody wants me to.
	-- right now it's 'W' for whitelist, 'B' for blacklist.
	file_type		char(1)
				constraint rhn_actioncd_file_ft_nn not null
				constraint rhn_actioncd_file_ft_ck
					check (file_type in ('W','B')),
	created			date default(sysdate)
				constraint rhn_actioncd_file_creat_nn not null,
	modified		date default(sysdate)
				constraint rhn_actioncd_file_mod_nn not null
)
	storage ( freelists 16 )
	initrans 32;

create index rhn_actioncd_file_aid_fn_idx
	on rhnActionConfigDateFile(action_id, file_name)
	tablespace [[4m_tbs]]
	storage ( freelists 16 )
	initrans 32;

create or replace trigger
rhn_actioncd_file_mod_trig
before insert or update on rhnActionConfigDateFile
for each row
begin
	:new.modified := sysdate;
end;
/
show errors

--
-- $Log$
-- Revision 1.2  2003/12/17 22:08:53  pjones
-- bugzilla: none -- move this column to the parent, not the blacklist info
--
-- Revision 1.1  2003/12/17 15:15:45  pjones
-- bugzilla: none ? -- add schema for import by date action
--
