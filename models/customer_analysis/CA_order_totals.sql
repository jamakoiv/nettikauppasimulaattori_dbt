/* Calculate order totals (price, wholesale_price, tax, profit) for each order. */

WITH order_totals AS (
    SELECT
        orders.id AS order_id,
        orders.customer_id AS customer_id,
        orders.order_placed AS order_placed,
        
        SUM(products.wholesale_price) AS wholesale_price,
        SUM(products.price * products.vat) AS tax,
        SUM(products.price) AS price,
        AVG(products.price) AS average_product_price,
        SUM(products.price) - SUM(products.wholesale_price) - SUM(products.price * products.vat) AS profit
    FROM {{ ref("staging_orders") }} AS orders
    JOIN {{ ref("staging_order_items") }} AS items ON orders.id = items.order_id
    JOIN {{ ref("staging_products") }} AS products ON items.product_id = products.id

    GROUP BY
        orders.id, orders.customer_id, orders.order_placed
    ORDER BY orders.customer_id
) 

SELECT * FROM order_totals