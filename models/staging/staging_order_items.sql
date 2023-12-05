WITH items AS (
    SELECT 
        *
    FROM {{ source("nettikauppasimulaattori_data_warehouse", "import_order_items") }}

    WHERE order_id IS NOT NULL
    AND product_ID IS NOT NULL
)

SELECT * FROM items