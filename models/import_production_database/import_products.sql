{{ config(materialized='table') }}

WITH products AS (
    SELECT
        *,
        DATETIME_TRUNC(CURRENT_DATETIME("UTC"), SECOND) AS created_at
    FROM {{ source('bigquery_nettikauppasimulaattori', 'products') }}
)

SELECT * FROM products