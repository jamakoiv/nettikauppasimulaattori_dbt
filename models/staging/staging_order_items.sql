WITH items AS (
    SELECT 
        *,
        DATETIME_TRUNC(CURRENT_DATETIME, SECOND) AS created_at
    FROM {{ source("bigquery_nettikauppasimulaattori", "order_items") }}

    WHERE order_id IS NOT NULL
    AND product_ID IS NOT NULL
)

SELECT * FROM items