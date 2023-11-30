SELECT
    CAST(items.product_id / 1000 AS INTEGER) AS product_category,
    COUNT(*) AS products_ordered,
    SUM(products.price) AS income,
    SUM(products.wholesale_price) AS wholesale_price,
    SUM(products.vat * products.price) AS tax,
    SUM(products.price - products.wholesale_price - (products.price * products.vat)) AS profit,

FROM {{ ref("staging_products") }} AS products
JOIN {{ ref("staging_order_items") }} AS items ON items.product_id = products.id

GROUP BY product_category
ORDER BY product_category ASC