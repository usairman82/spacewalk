--
-- $Id$
--
-- this is much more readable with ts=4, enjoy!

create or replace view
rhnChannelNewestPackageView
as
select  cp.channel_id		channel_id,
		p.name_id			name_id,
		p.evr_id			evr_id,
		p.package_arch_id	package_arch_id,
		p.id				package_id
from	rhnPackageEVR		pe,
		rhnPackage			p,
		rhnChannelPackage	cp
where	cp.package_id = p.id
		and p.evr_id = pe.id
		and pe.evr = (
			select	max(sq_pe.evr)
			from	rhnChannelPackage sq_cp,
					rhnPackage sq_p,
					rhnPackageEVR sq_pe
			where	1=1
				and sq_cp.channel_id = cp.channel_id
				and sq_cp.package_id = sq_p.id
				and sq_p.name_id = p.name_id
				and sq_pe.id = sq_p.evr_id
		)
/

-- $Log$
-- Revision 1.2  2002/12/12 21:23:56  pjones
-- Misa found a bug in this; we always want all arches, but only for the
-- newest version.  What we were giving was the newest version per arch.
--
-- The best example of breakage is the old kernel i586 packages; we want
-- i586 boxes to get the newer i386 package.
--
-- Revision 1.1  2002/12/11 22:11:46  pjones
-- view to populate rhnChannelNewestPackage from
--
