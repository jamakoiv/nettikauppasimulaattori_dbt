/* Calculate time difference in hours between orders for each customer. */

WITH tmp AS (
    SELECT
        id as order_id,
        customer_id,
        order_placed,
        DATETIME_DIFF(
            order_placed, 
            LAG(order_placed) OVER(PARTITION BY customer_id ORDER BY customer_id,order_placed), 
            HOUR) as order_placed_diff

    FROM {{ ref("staging_orders") }}
    # WHERE customer_id = 120
    ORDER BY customer_id, order_placed
)

SELECT 
    customer_id,
    AVG(order_placed_diff) AS mean_hours_between_orders
FROM tmp
WHERE order_placed_diff IS NOT NULL  /* First result is always NULL since there is no previous order_placed. */
GROUP BY customer_id
ORDER BY customer_id