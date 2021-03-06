﻿CREATE VIEW [dbo].[vMailingAddresses]
	AS SELECT 
		isnull(altAddrs.AddressName, l.Name) AddressName,
		isnull(altAddrs.AddressLine, l.Address) AddressLine,
		isnull(altAddrs.AddressCity, dv.DefaultAddressCity) AddressCity,
		isnull(altAddrs.AddressStateCode, dv.DefaultAddressStateCode) AddressStateCode,
		isnull(altAddrs.AddressZipCode, dv.DefaultAddressZipCode) AddressZipCode,
		cast(case when altAddrs.AddressLine is null then 0 else 1 end as bit) [IsAlternateAddress],
		l.HouseNumber 
	FROM lots l
	left join AlternateAddress altAddrs
	on l.HouseNumber = altAddrs.HouseNumber
	left join [HoaGlobalValues] dv
	on 1=1
	where l.NonHomeLot = 0 -- true residential homes only

