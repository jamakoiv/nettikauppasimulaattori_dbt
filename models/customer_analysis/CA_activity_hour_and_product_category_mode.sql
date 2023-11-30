/* Calculate peak active hour and favourite product category for each customer.
Both are taken as the statistical mode of each parameter. */

/* Count how many orders have been placed at each individual hour of the day. */
WITH ranked_hours AS (
    WITH tmp AS (
        SELECT
            customer_id,
            EXTRACT(HOUR FROM order_placed) AS hour,
            COUNT(*) AS count,
            RANK() OVER (PARTITION BY customer_id ORDER BY COUNT(*) DESC) AS hour_rank,
        FROM {{ ref("staging_orders") }} AS orders
        GROUP BY customer_id, hour
        )
    SELECT  
        customer_id, 
        AVG(hour) AS peak_activity_hour, /* RANK gives multiple values if they have same count, so we need this AVG here.*/
        SUM(count) AS orders_in_peak_activity_hour
    FROM tmp WHERE hour_rank = 1
    GROUP BY customer_id
), 

/* Count how many items in each product category every customer has ordered. */
ranked_categories AS (
    with tmp2 AS (
        SELECT
            orders.customer_id AS customer_id,
            CAST(items.product_id / 1000 AS INTEGER) AS product_category,
            COUNT(*) AS count,
            RANK() OVER (PARTITION BY orders.customer_id ORDER BY COUNT(*) DESC) AS category_rank,
        FROM {{ ref("staging_orders") }} AS orders
        JOIN {{ ref("staging_order_items") }} AS items ON items.order_id = orders.id

        GROUP BY orders.customer_id, product_category
        )
    SELECT 
        customer_id, 
        product_category AS favourite_product_category, 
        count AS products_ordered_in_category 
    FROM tmp2 WHERE category_rank = 1
)

SELECT
    h.customer_id,
    peak_activity_hour,
    favourite_product_category
FROM ranked_hours AS h
JOIN ranked_categories AS c ON h.customer_id = c.customer_id
ORDER BY h.customer_id ASC