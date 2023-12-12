WITH hourly_sales AS (
SELECT 
    DATETIME_TRUNC(order_placed, HOUR) AS order_placed,
    COUNT(*) AS number_of_orders,
    SUM(price) AS income,
    SUM(wholesale_price) AS wholesale_price,
    SUM(tax) AS tax,
    SUM(profit) AS profit,
    AVG(average_product_price) AS average_product_price

FROM {{ ref("CA_order_totals") }}
GROUP BY DATETIME_TRUNC(order_placed, HOUR)
)

SELECT * FROM hourly_sales
ORDER BY order_placed