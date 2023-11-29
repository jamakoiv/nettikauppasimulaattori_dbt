WITH order_totals AS (
    SELECT
        orders.id AS order_id,
        orders.customer_id AS customer_id,
        orders.order_placed AS order_placed,
        
        SUM(products.wholesale_price) AS wholesale_price,
        SUM(products.price * products.vat) AS tax,
        SUM(products.price) AS price,
        SUM(products.price) - SUM(products.wholesale_price) - SUM(products.price * products.vat) AS profit
    FROM store_operational.orders AS orders
    JOIN store_operational.order_items AS items ON orders.id = items.order_id
    JOIN store_operational.products AS products ON items.product_id = products.id

    GROUP BY
        orders.id, orders.customer_id, orders.order_placed
    ORDER BY orders.customer_id
) 

SELECT * FROM order_totals