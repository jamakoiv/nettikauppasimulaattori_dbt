{{ config(materialized='table') }}

WITH orders AS (
    SELECT
        *,
        DATETIME_TRUNC(CURRENT_DATETIME("Europe/Helsinki"), SECOND) AS created_at
    FROM {{ source('bigquery_nettikauppasimulaattori', 'orders') }}
)

SELECT * FROM orders