-- $Id$
--
CREATE OR REPLACE VIEW rhnServerGroupOverview (
         ORG_ID, SECURITY_ERRATA, BUG_ERRATA, ENHANCEMENT_ERRATA, GROUP_ID, GROUP_NAME, GROUP_ADMINS, SERVER_COUNT, NOTE_COUNT, MODIFIED, MAX_MEMBERS
)
AS
  SELECT SG.org_id,
         (SELECT COUNT(distinct E.id)
            FROM rhnErrata E,
                 rhnServerNeededPackageCache SNPC,
                 rhnServerGroupMembers SGM
           WHERE E.advisory_type = 'Security Advisory'
                 and snpc.errata_id = e.id
                 and snpc.server_id = sgm.server_id
                 and sgm.server_group_id = sg.id
                 AND EXISTS ( SELECT 1
                              FROM rhnServerFeaturesView SFV
                              WHERE SFV.server_id = SGM.server_id
                                    AND SFV.label = 'ftr_system_grouping')),
         (SELECT COUNT(distinct E.id)
            FROM rhnErrata E,
                 rhnServerNeededPackageCache SNPC,
                 rhnServerGroupMembers SGM
           WHERE E.advisory_type = 'Bug Fix Advisory'
                 and snpc.errata_id = e.id
                 and snpc.server_id = sgm.server_id
                 and sgm.server_group_id = sg.id
                 AND EXISTS ( SELECT 1
                              FROM rhnServerFeaturesView SFV
                              WHERE SFV.server_id = SGM.server_id
                                    AND SFV.label = 'ftr_system_grouping')),
         (SELECT COUNT(distinct E.id)
            FROM rhnErrata E,
                 rhnServerNeededPackageCache SNPC,
                 rhnServerGroupMembers SGM
           WHERE E.advisory_type = 'Product Enhancement Advisory'
                 and snpc.errata_id = e.id
                 and snpc.server_id = sgm.server_id
                 and sgm.server_group_id = sg.id
                 AND EXISTS ( SELECT 1
                              FROM rhnServerFeaturesView SFV
                              WHERE SFV.server_id = SGM.server_id
                                    AND SFV.label = 'ftr_system_grouping')),
         SG.id, SG.name,
         (SELECT COUNT(*) FROM rhnUserManagedServerGroups UMSG WHERE UMSG.server_group_id = SG.id),
         (SELECT COUNT(*) FROM rhnServerGroupMembers SGM WHERE SGM.server_group_id = SG.id
                 AND EXISTS ( SELECT 1
                              FROM rhnServerFeaturesView SFV
                              WHERE SFV.server_id = SGM.server_id
                                    AND SFV.label = 'ftr_system_grouping')),
         0, SYSDATE, MAX_MEMBERS
    FROM rhnServerGroup SG;

show errors;


-- $Log$
-- Revision 1.9  2001/07/29 07:51:24  cturner
-- removal of rhnServerNeededErrataCache since it is redundant and recent query changes make rhnServerNeededPackageCache just as fast
--
-- Revision 1.8  2001/07/23 19:52:25  cturner
-- fixed logic error
--
-- Revision 1.7  2001/07/23 19:47:10  cturner
-- speeding up the errata overview view
--
-- Revision 1.6  2001/07/19 12:46:21  cturner
-- display max members in server group overview
--
-- Revision 1.5  2001/07/03 18:20:19  cturner
-- view tweak
--
-- Revision 1.4  2001/07/02 03:26:42  cturner
-- better org servergroup overview
--
-- Revision 1.3  2001/06/27 02:05:25  gafton
-- add Log too
--
