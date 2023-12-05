WITH orders AS (
    SELECT DISTINCT 
        *,
        DATETIME_TRUNC(CURRENT_DATETIME, SECOND) AS created_at

    FROM {{ source("bigquery_nettikauppasimulaattori", "orders") }}

    WHERE   id IS NOT NULL
        AND order_placed IS NOT NULL
)

SELECT * FROM orders