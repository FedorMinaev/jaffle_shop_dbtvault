select 
	hc.customer_pk
	,scd.first_name 
	,scd.last_name 
	,scd.email 
	,scd.effective_from 
	,lead(scd.effective_from,1,'9999.12.31') over(partition by scd.customer_pk order by scd.effective_from) as effective_to
from {{ ref('hub_customer') }} hc left outer join
	{{ ref('sat_customer_details') }} scd on hc.customer_pk =scd.customer_pk 