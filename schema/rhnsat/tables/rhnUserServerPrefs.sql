--
-- $Id$
--

create table
rhnUserServerPrefs
(
        user_id		number
                        constraint rhn_userServerPrefs_uid_nn not null
                        constraint rhn_userServerPrefs_uid_fk
                                references web_contact(id)
				on delete cascade,
        server_id	number
                        constraint rhn_userServerPrefs_sid_nn not null
                        constraint rhn_userServerPrefs_sid_fk
                                references rhnServer(id),
        name            varchar2(64)
                        constraint rhn_userServerPrefs_name_nn not null,
        value           varchar2(1)
                        constraint rhn_userServerPrefs_value_nn not null,
        created         date default(sysdate)
                        constraint rhn_userServerPrefs_created_nn not null,
        modified        date default(sysdate)
                        constraint rhn_userServerPrefs_mod_nn not null
)
	storage ( freelists 16 )
	initrans 32;

create unique index rhn_usprefs_uid_sid_n_uq
	on rhnUserServerPrefs(user_id, server_id, name)
	tablespace [[2m_tbs]]
	storage ( freelists 16 )
	initrans 32;

create index rhn_usprefs_n_sid_uid_idx
	on rhnUserServerPrefs(name, server_id, user_id)
	tablespace [[2m_tbs]]
	storage ( freelists 16 )
	initrans 32
	nologging;

create index rhn_usprefs_sid_uid_n_idx
	on rhnUserServerPrefs(server_id, user_id, name)
	tablespace [[2m_tbs]]
	storage ( freelists 16 )
	initrans 32
	nologging;

create or replace trigger
rhn_u_s_prefs_mod_trig
before insert or update on rhnUserServerPrefs
for each row
begin
        :new.modified := sysdate;
        :new.value := upper(:new.value);
end;
/
show errors

-- $Log$
-- Revision 1.13  2004/02/09 16:38:38  pjones
-- bugzilla: 115049 -- rework delete_server to be driven from the pl/sql instead
-- of with cascaded deletes
--
-- Revision 1.12  2003/02/18 16:08:49  pjones
-- cascades for delete_user
--
-- Revision 1.11  2003/01/30 16:11:28  pjones
-- storage parameters, also fix deps to make it build again
--
-- Revision 1.10  2002/10/08 21:42:48  pjones
-- index starting with server_id on rhnUserServerPrefs
--
-- Revision 1.9  2002/05/10 22:00:49  pjones
-- add rhnFAQClass, and make it a dep for rhnFAQ
-- add grants where appropriate
-- add cvs id/log where it's been missed
-- split data out where appropriate
-- add excludes where appropriate
-- make sure it still builds (at least as sat).
-- (really this time)
--
