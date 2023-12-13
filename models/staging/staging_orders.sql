WITH orders AS (
    SELECT DISTINCT 
        *
    FROM {{ source("nettikauppasimulaattori_data_warehouse", "import_orders") }}

    WHERE   id IS NOT NULL
        AND order_placed IS NOT NULL
)

SELECT * FROM orders