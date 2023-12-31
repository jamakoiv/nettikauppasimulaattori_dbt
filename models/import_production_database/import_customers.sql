{{ config(materialized='table') }}

WITH customers AS (
    SELECT
        *,
        DATETIME_TRUNC(CURRENT_DATETIME("Europe/Helsinki"), SECOND) AS created_at
    FROM {{ source('bigquery_nettikauppasimulaattori', 'customers') }}
)

SELECT * FROM customers