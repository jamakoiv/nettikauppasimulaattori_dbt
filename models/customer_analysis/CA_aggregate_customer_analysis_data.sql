
/* Calculate averages of the orders data. */
WITH averages AS (
    SELECT
        totals.customer_id,
        AVG(totals.price) AS price,
        AVG(totals.profit) AS profit,
        AVG(totals.average_product_price) AS average_product_price,
        COUNT(*) AS number_of_orders
    FROM {{ ref("CA_order_totals") }} AS totals

    GROUP BY totals.customer_id
    ORDER BY totals.customer_id
)

/* Gather all necessary customer data to single table. */
SELECT
    averages.customer_id as customer_id,
    averages.price AS average_order_price,
    averages.average_product_price AS average_product_price,
    averages.profit AS average_profit,
    averages.number_of_orders AS number_of_orders,
    mean_time.mean_hours_between_orders AS mean_hours_between_orders,
    modes.peak_activity_hour AS peak_activity_hour,
    modes.favourite_product_category AS favourite_product_category

FROM averages 
INNER JOIN {{ ref("CA_mean_time_between_orders") }} AS mean_time ON averages.customer_id = mean_time.customer_id
INNER JOIN {{ ref("CA_activity_hour_and_product_category_mode") }} AS modes ON averages.customer_id = modes.customer_id
/* Are these joins slow? */

ORDER BY customer_id ASC