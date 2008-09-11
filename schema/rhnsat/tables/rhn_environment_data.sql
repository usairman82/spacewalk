--
--$Id$
--
-- 
--

--data for rhn_environment

insert into rhn_environment(name,description) 
    values ( 'LICENSE','Licensed Software Model');
insert into rhn_environment(name,description) 
    values ( 'ALL','All environments');
commit;

--$Log$
--Revision 1.5  2004/07/15 00:58:05  dfaraldo
--Removed DEV, QA, STAGE, and PROD environments. -dfaraldo
--
--Revision 1.4  2004/06/17 20:48:59  kja
--bugzilla 124970 -- _data is in for 350.
--
--Revision 1.3  2004/05/29 21:51:49  pjones
--bugzilla: none -- _data is not for 340, so says kja.
--
--Revision 1.2  2004/05/04 20:03:38  kja
--Added commits.
--
--Revision 1.1  2004/04/22 17:49:49  kja
--Added data for the reference tables.
--
