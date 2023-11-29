
WITH products AS (
    SELECT *
    FROM {{ source("bigquery_nettikauppasimulaattori", "products") }}

    WHERE id IS NOT NULL
    AND name IS NOT NULL
    AND wholesale_price >= 0
    AND price >= 0
)

SELECT * FROM products