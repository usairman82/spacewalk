--
-- $Id$
--

create table
rhnPollQuestionType
(
        id              number
			constraint rhn_poll_questiontype_id_nn not null
                        constraint rhn_poll_questiontype_id_pk primary key
				using index tablespace rhn_ind
				storage ( initial 40960 
					next 507904 pctincrease 1 ),
	text		varchar2(32)
			constraint rhn_poll_questiontype_name_nn not null
)
storage ( initial 40960 next 5816320 pctincrease 1 );

insert into rhnPollState values (1,'TEXT');
insert into rhnPollState values (2,'SINGLE CHOICE');
insert into rhnPollState values (3,'SEVERAL CHOICES');


-- $Log$
-- Revision 1.1  2001/12/12 16:46:45  pjones
-- add question type to rhnPollQuestion
-- add rhnPollQuestionType
-- add answer and remove poll_choice_id's not null on rhnPollResponse
-- add verification trigger on rhnPollResponse
-- fix values in rhnPollState
--
-- Revision 1.1  2001/12/10 22:29:27  pjones
-- add poll state and begin/end dates
--
-- Revision 1.1  2001/12/10 22:19:09  pjones
-- initial checkin of user poll schema
--
