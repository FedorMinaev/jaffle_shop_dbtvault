SELECT date_part('year'::text, sod.order_date) AS year,
    date_part('week'::text, sod.order_date) AS week,
    sod.status,
    count(*) AS cnt
   FROM dbt.sat_order_details sod
  GROUP BY (date_part('year'::text, sod.order_date)), (date_part('week'::text, sod.order_date)), sod.status
  ORDER BY (date_part('year'::text, sod.order_date)), (date_part('week'::text, sod.order_date))