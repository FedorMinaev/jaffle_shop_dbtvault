select 
    sat1.customer_pk
	,sat1.first_name 
	,sat1.last_name 
	,sat1.email 
    ,sat2.country
    ,sat2.age 
    ,sat1.effective_from
    ,sat1.effective_to
    ,sat2.effective_from_2
    ,sat2.effective_to_2
from
(
    select 
        hc.customer_pk
        ,scd.first_name 
        ,scd.last_name 
        ,scd.email 
        ,scd.effective_from
        ,coalesce(lead(scd.effective_from) over(partition by hc.customer_pk order by scd.effective_from),'9999.12.31') as effective_to
    from {{ ref('hub_customer') }} hc left outer join
        {{ ref('sat_customer_details') }} scd on hc.customer_pk =scd.customer_pk 
) as sat1    left outer join
(
    select 
        hc.customer_pk
        ,scrd.country
        ,scrd.age 
        ,scrd.effective_from as effective_from_2 
        ,coalesce(lead(scrd.effective_from) over(partition by hc.customer_pk order by scrd.effective_from),'9999.12.31') as effective_to_2
    from {{ ref('hub_customer') }} hc left outer join
	    {{ ref('sat_customer_region_details') }} scrd on hc.customer_pk =scrd.customer_pk 
) as sat2 on sat1.customer_pk=sat2.customer_pk