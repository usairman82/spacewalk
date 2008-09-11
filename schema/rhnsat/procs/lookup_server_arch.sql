--
-- $Id$
--

CREATE OR REPLACE FUNCTION
LOOKUP_SERVER_ARCH(label_in IN VARCHAR2)
RETURN NUMBER
DETERMINISTIC
IS
	server_arch_id		NUMBER;
BEGIN
	SELECT id
          INTO server_arch_id
          FROM rhnServerArch
         WHERE label = label_in;

	RETURN server_arch_id;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
            rhn_exception.raise_exception('server_arch_not_found');
END;
/
SHOW ERRORS

-- $Log$
-- Revision 1.2  2004/02/20 18:08:51  pjones
-- bugzilla: none -- make lookup_*_arch.sql not autonomous since they never
-- insert
-- add changes files for nonlinux systems
--
-- Revision 1.1  2002/11/13 23:16:18  pjones
-- lookup_*_arch()
--
