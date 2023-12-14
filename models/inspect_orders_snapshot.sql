SELECT
    *
FROM {{ ref('orders_snapshot') }}
WHERE dbt_updated_at IS NOT NULL