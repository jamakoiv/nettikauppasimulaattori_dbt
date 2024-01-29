WITH res AS (
    SELECT
        orders.id AS order_id,
        orders.customer_id AS customer_id,
        orders.order_placed AS order_placed,
        products.wholesale_price AS wholesale_price,
        products.vat AS vat,
        products.price AS price,
        dbt_valid_from,
        dbt_valid_to,

    FROM {{ ref('staging_orders') }} AS orders
    JOIN {{ ref('staging_order_items') }} AS items 
        ON orders.id = items.order_id
    JOIN {{ ref('products_snapshot') }} AS products 
        ON items.product_id = products.id
)

SELECT 
    res.order_id,
    res.customer_id,
    res.order_placed,

    SUM(res.wholesale_price) AS wholesale_price,
    SUM(res.price * res.vat) AS tax,
    SUM(res.price) AS price,
    AVG(res.price) AS average_product_price,
    SUM(res.price) - SUM(res.wholesale_price) - SUM(res.price * res.vat) AS profit

FROM res
WHERE order_placed BETWEEN dbt_valid_from AND COALESCE(dbt_valid_to, "2100-01-01")

/* AND res.customer_id = 219 */ 

GROUP BY order_id, customer_id, order_placed
ORDER BY order_placed, customer_id