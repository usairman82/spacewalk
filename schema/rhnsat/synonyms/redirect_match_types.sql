--
--$Id$
--

--create special redirect_match_types synonyms for monitoring backend code to function as is

create or replace synonym redirect_match_types for rhn_redirect_match_types;

--
--$Log$
--Revision 1.1  2004/06/23 15:01:07  kja
--bugzilla 126465 -- fix synonyms for monitoring backend
--
--
