--
--$Id$
--
--

--url_probe current prod row count = 182
create table 
rhn_url_probe
(
    username                         varchar2 (40),
    password                         varchar2 (255),
    cookie_enabled                   char     (1)   default 0
        constraint rhn_urlpb_cookie_en_nn not null,
    multi_step                       char     (1)   default 0
        constraint rhn_urlpb_multi_step_nn not null
        constraint rhn_urlpb_multi_step_ck check (multi_step in ('0','1')),
    run_on_scouts                    char     (1)   default ('1')
        constraint rhn_urlpb_run_on_scouts_nn not null
        constraint rhn_urlpb_run_on_scouts_ck 
            check (run_on_scouts in ('0','1')),
    probe_id                         number   (12)
        constraint rhn_urlpb_probe_id_nn not null
        constraint rhn_urlpb_probe_id_pk primary key
            using index tablespace [[2m_tbs]]
            storage( pctincrease 1 freelists 16 )
            initrans 32,
    probe_type                       varchar2 (12)  default 'url'
        constraint rhn_urlpb_probe_type_nn not null
        constraint rhn_urlpb_probe_type_ck check (probe_type='url'),
    sat_cluster_id                   number   (12),
    scout_warning_threshold_is_all   char     (1)   default '1'
        constraint rhn_urlpb_scout_warn_isall_nn not null,
    scout_crit_threshold_is_all      char     (1)   default '1'
        constraint rhn_urlpb_scout_crit_isall_nn not null,
    scout_warning_threshold          number   (12)  default -1,
    scout_critical_threshold         number   (12)  default -1
)
    storage ( freelists 16 )
    initrans 32;

comment on table rhn_url_probe 
    is 'urlpb  url probe';

alter table rhn_url_probe
    add constraint rhn_urlpb_probe_pr_id_pr_fk
    foreign key ( probe_id, probe_type )
    references rhn_probe( recid, probe_type )
    on delete cascade;

create index rhn_url_probe_pid_ptype_idx
    on rhn_url_probe ( probe_id, probe_type )
    storage ( freelists 16 )
    initrans 32;

--$Log$
--Revision 1.3  2004/05/07 23:30:22  kja
--Shortened constraint/other names as needed.  Fixed minor syntax errors.
--
--Revision 1.2  2004/04/30 14:46:03  kja
--Moved foreign keys for non-circular references.
--
--Revision 1.1  2004/04/16 21:17:21  kja
--More monitoring tables.
--
--
--$Id$
--
--
