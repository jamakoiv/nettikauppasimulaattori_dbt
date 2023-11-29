WITH orders AS (
    SELECT DISTINCT *

    FROM {{ source("bigquery_nettikauppasimulaattori", "orders") }}

    WHERE   id IS NOT NULL
        AND order_placed IS NOT NULL
)

SELECT * FROM orders