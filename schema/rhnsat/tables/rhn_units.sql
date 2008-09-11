--
--$Id$
--
--

--reference table
--units current prod row count = 35
create table 
rhn_units
(
    unit_id             varchar2 (10)
        constraint rhn_units_unit_id_nn not null
        constraint rhn_units_unit_id_pk primary key
            using index tablespace [[64k_tbs]]
            storage( pctincrease 1 freelists 16 )
            initrans 32,
    quantum_id          varchar2 (10)
        constraint rhn_units_quantum_id_nn not null,
    unit_label          varchar2 (20),
    description         varchar2 (200),
    to_base_unit_fn     varchar2 (2000),
    from_base_unit_fn   varchar2 (2000),
    validate_fn         varchar2 (2000),
    last_update_user    varchar2 (40),
    last_update_date    date
)
    storage ( freelists 16 )
    initrans 32;

comment on table rhn_units 
    is 'units  unit definitions';

create index rhn_units_quantum_id_idx 
    on rhn_units ( quantum_id )
    tablespace [[64k_tbs]]
    storage ( freelists 16 )
    initrans 32;

alter table rhn_units
    add constraint rhn_units_qnta0_quantum_id_fk
    foreign key ( quantum_id )
    references rhn_quanta( quantum_id );

--$Log$
--Revision 1.3  2004/04/30 14:46:03  kja
--Moved foreign keys for non-circular references.
--
--Revision 1.2  2004/04/16 21:49:57  kja
--Adjusted small table sizes.  Documented small tables that are primarily static
--as "reference tables."  Fixed up a few syntactical errs.
--
--Revision 1.1  2004/04/16 21:17:21  kja
--More monitoring tables.
--
--
--$Id$
--
--
