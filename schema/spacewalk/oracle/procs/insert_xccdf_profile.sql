-- Copyright (c) 2012 Red Hat, Inc.
--
-- This software is licensed to you under the GNU General Public License,
-- version 2 (GPLv2). There is NO WARRANTY for this software, express or
-- implied, including the implied warranties of MERCHANTABILITY or FITNESS
-- FOR A PARTICULAR PURPOSE. You should have received a copy of GPLv2
-- along with this software; if not, see
-- http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
--
-- Red Hat trademarks are not licensed under GPLv2. No permission is
-- granted to use or replicate Red Hat trademarks that are incorporated
-- in this software or its documentation.

create or replace function
insert_xccdf_profile(identifier_in in varchar2, title_in in varchar2)
return number
is
    pragma autonomous_transaction;
    profile_id  number;
begin
    insert into rhnXccdfProfile (id, identifier, title)
    values (rhn_xccdf_profile_id_seq.nextval, identifier_in, title_in) returning id into profile_id;
    commit;
    return profile_id;
end;
/
show errors
