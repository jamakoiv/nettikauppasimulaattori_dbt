WITH orders AS (
    SELECT DISTINCT 
        *
    FROM {{ source("nettikauppasimulaattori_data_warehouse", "import_orders") }}

    WHERE id IS NOT NULL AND order_placed IS NOT NULL
    {% if target.name == 'dev'%} /* Limit dataset when in development environment. */
    AND order_placed BETWEEN DATE_SUB(CURRENT_DATE("UTC"), INTERVAL 7 DAY) AND CURRENT_DATE("UTC")
    {% endif %}
)

SELECT * FROM orders