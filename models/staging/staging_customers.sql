
WITH customers AS (
    SELECT DISTINCT
        id,
        first_name,
        last_name
    FROM {{ source('bigquery_nettikauppasimulaattori', 'customers') }}

    WHERE id IS NOT NULL
      AND first_name IS NOT NULL
      AND last_name IS NOT NULL
)

SELECT * FROM customers