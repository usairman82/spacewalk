--
-- $Id$
--

CREATE OR REPLACE
PACKAGE rhn_exception
IS
    CURSOR exception_details(exception_label_in VARCHAR2) IS
        SELECT id, label, message
          FROM rhnException
         WHERE label = exception_label_in;

    PROCEDURE raise_exception(exception_label_in IN VARCHAR2);
    procedure raise_exception_val(
	exception_label_in in varchar2,
        val_in in number
    );
    PROCEDURE lookup_exception(exception_label_in IN VARCHAR2, exception_id_out OUT NUMBER, exception_message_out OUT VARCHAR2);
END rhn_exception;
/
SHOW ERRORS

-- $Log$
-- Revision 1.4  2002/05/10 22:08:23  pjones
-- id/log
--
