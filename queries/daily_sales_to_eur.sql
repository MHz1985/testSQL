INSERT INTO output_table (
    country, sales_date, outlet_id, outlet_name, region, sales_value, sales_value_eur 
)
SELECT
    sales_daily.country,
    sales_daily.sales_date,
    sales_daily.outlet_id,
    outlets_info.outlet_name,
    outlets_info.region,
    sales_daily.sales_value,
    sales_daily.sales_value * curr_exchange_v2.ex_loc_to_eur AS sales_value_eur
FROM sales_daily 
JOIN curr_exchange_v2 
  ON sales_daily.country = curr_exchange_v2.country
 AND sales_daily.sales_date = curr_exchange_v2.rate_date
JOIN outlets_info 
  ON sales_daily.outlet_id = outlets_info.outlet_id
JOIN products_info
  ON sales_daily.product_id = products_info.product_id
WHERE NOT products_info.is_own_brand;
