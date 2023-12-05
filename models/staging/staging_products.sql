
WITH products AS (
    SELECT 
        *
    FROM {{ source("nettikauppasimulaattori_data_warehouse", "import_products") }}

    WHERE id IS NOT NULL
    AND name IS NOT NULL
    AND wholesale_price >= 0
    AND price >= 0
)

SELECT * FROM products