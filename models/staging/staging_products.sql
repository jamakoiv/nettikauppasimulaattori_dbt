
WITH products AS (
    SELECT 
        *,
        DATETIME_TRUNC(CURRENT_DATETIME("UTC"), SECOND) AS created_at
    
    FROM {{ source("bigquery_nettikauppasimulaattori", "products") }}

    WHERE id IS NOT NULL
    AND name IS NOT NULL
    AND wholesale_price >= 0
    AND price >= 0
)

SELECT * FROM products