--
-- $Id$
--

create table
rhnArchTypeActions
(
	arch_type_id	number
			constraint rhn_archtypeacts_atid_nn not null
			constraint rhn_archtypeacts_atid_fk
				references rhnArchType(id),
	action_style	varchar2(64)
			constraint rhn_archtypeacts_as_nn not null,
	action_type_id	number
			constraint rhn_archtypeacts_actid_nn not null
			constraint rhn_archtypeacts_actid_fk
				references rhnActionType(id),
	created		date default(sysdate)
			constraint rhn_archtypeacts_creat_nn not null,
	modified	date default(sysdate)
			constraint rhn_archtypeacts_mod_nn not null
)
	storage ( freelists 16 )
	initrans 32;

create unique index rhn_archtypeacts_atid_as_uq
	on rhnArchTypeActions( arch_type_id, action_style )
	tablespace [[64k_tbs]]
	storage ( freelists 16 )
	initrans 32;

create or replace trigger
rhn_archtypeacts_mod_trig
before insert or update on rhnArchTypeActions
for each row
begin
	:new.modified := sysdate;
end;
/
show errors

--
-- $Log$
-- Revision 1.1  2004/02/13 19:38:37  pjones
-- bugzilla: 115515 -- add table to make arch types and an action label to
-- action names
--
