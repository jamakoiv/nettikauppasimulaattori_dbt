WITH items AS (
    SELECT *
    FROM {{ source("bigquery_nettikauppasimulaattori", "order_items") }}

    WHERE order_id IS NOT NULL
    AND product_ID IS NOT NULL
)

SELECT * FROM items