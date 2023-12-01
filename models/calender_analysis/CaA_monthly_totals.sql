WITH monthly_sales AS (
    SELECT 
        EXTRACT(YEAR FROM order_placed) AS year,
        EXTRACT(MONTH FROM order_placed) AS month,
        SUM(number_of_orders) AS number_of_orders,
        SUM(income) AS income,
        SUM(wholesale_price) AS wholesale_price,
        SUM(tax) AS tax,
        SUM(profit) AS profit,
        AVG(average_product_price) AS average_product_price

    FROM {{ ref("CaA_daily_totals") }}
    GROUP BY EXTRACT(YEAR FROM order_placed), EXTRACT(MONTH FROM order_placed)
)

SELECT
    *
FROM monthly_sales
ORDER BY year, month ASC