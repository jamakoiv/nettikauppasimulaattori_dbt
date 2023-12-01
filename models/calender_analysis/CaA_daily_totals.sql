WITH daily_sales AS (
    SELECT 
        EXTRACT(DATE FROM order_placed) AS order_placed,
        COUNT(*) AS number_of_orders,
        SUM(price) AS income,
        SUM(wholesale_price) AS wholesale_price,
        SUM(tax) AS tax,
        SUM(profit) AS profit,
        AVG(average_product_price) AS average_product_price

    FROM {{ ref("CA_order_totals") }}
    GROUP BY EXTRACT(DATE FROM order_placed)
)

SELECT
    *
FROM daily_sales
ORDER BY order_placed ASC
