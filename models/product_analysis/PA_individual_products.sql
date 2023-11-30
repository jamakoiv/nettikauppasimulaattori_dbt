SELECT
    product.id,
    product.name,
    COUNT(*) AS products_ordered,
    SUM(product.price) AS income,
    SUM(product.wholesale_price) AS wholesale_price,
    SUM(product.vat * product.price) AS tax,
    SUM(product.price - product.wholesale_price - (product.price * product.vat)) AS profit,

FROM {{ ref("staging_order_items") }} AS items
INNER JOIN {{ ref("staging_products") }} AS product ON items.product_id = product.id

GROUP BY product.id, product.name
ORDER BY product.id ASC