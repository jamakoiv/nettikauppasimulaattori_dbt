{{ config(materialized='table') }}

WITH items AS (
    SELECT
        *,
        DATETIME_TRUNC(CURRENT_DATETIME("UTC"), SECOND) AS created_at
    FROM {{ source('bigquery_nettikauppasimulaattori', 'order_items') }}
)

SELECT * FROM items