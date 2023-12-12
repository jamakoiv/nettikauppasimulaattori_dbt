WITH monthly_sales AS (
    SELECT 
        DATETIME_TRUNC(order_placed, MONTH) AS order_placed,
        SUM(number_of_orders) AS number_of_orders,
        SUM(income) AS income,
        SUM(wholesale_price) AS wholesale_price,
        SUM(tax) AS tax,
        SUM(profit) AS profit,
        AVG(average_product_price) AS average_product_price

    FROM {{ ref("CaA_daily_totals") }}
    GROUP BY DATETIME_TRUNC(order_placed, MONTH)
)

SELECT
    *
FROM monthly_sales
ORDER BY order_placed ASC