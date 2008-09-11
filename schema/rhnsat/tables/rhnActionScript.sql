--
-- $Id$
--

create sequence rhn_actscript_id_seq;

create table
rhnActionScript
(
	id		number
			constraint rhn_actscript_id_nn not null
			constraint rhn_actscript_id_pk primary key
				using index tablespace [[4m_tbs]],
	action_id	number
			constraint rhn_actscript_aid_nn not null
			constraint rhn_actscript_aid_fk
				references rhnAction(id)
				on delete cascade,
	username	varchar2(32)
			constraint rhn_actscript_user_nn not null,
	groupname	varchar2(32)
			constraint rhn_actscript_group_nn not null,
	script		blob,
	timeout		number,
	created		date default(sysdate)
			constraint rhn_actscript_creat_nn not null,
	modified	date default(sysdate)
			constraint rhn_actscript_mod_nn not null
)
	tablespace [[blob]]
	storage ( freelists 16 )
	initrans 32;

create unique index rhn_actscript_aid_uq_idx on
	rhnActionScript( action_id )
	tablespace [[4m_tbs]]
	storage ( freelists 16 )
	initrans 32;

create or replace trigger
rhn_actscript_mod_trig
before insert or update on rhnActionScript
for each row
begin
	:new.modified := sysdate;
end;
/
show errors

--
-- $Log$
-- Revision 1.5  2005/02/11 01:16:12  jslagle
-- Changed index on action_id to be unique
-- bz # 143092
--
-- Revision 1.4  2004/02/19 15:43:43  pjones
-- bugzilla: 115898 -- add timeoute, start/stop times, and return code
--
-- Revision 1.3  2004/02/19 00:30:27  pjones
-- bugzilla: none -- add groupname too
--
-- Revision 1.2  2004/02/18 16:45:30  pjones
-- 115898 -- add username
--
-- Revision 1.1  2004/02/17 00:19:54  pjones
-- bugzilla: 115898 -- tables for scripts in actions and their results
--
			
